#!/usr/bin/env bash
set -Eeuo pipefail

# UNCOMMENT THE NEXT LINE IF YOU WANT BASH TO PRINT EVERY COMMAND EXECUTED:
# set -x

# Host unit tests: configure + build the test project, run ctest, report counts.
#
#   ./test.sh               all tests
#   ./test.sh StepGen       only tests whose name matches (ctest -R)
#
# The test project has its own CMakeLists.txt and build folder, built with the
# host's compiler -- not the firmware's cross toolchain.

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
cd "$SCRIPT_DIR"

###############################################################################
# Project settings -- edit these for each project
###############################################################################

TEST_DIR="Test"               # folder with the test project's CMakeLists.txt
BUILD_DIR="$TEST_DIR/build"   # its own build folder

###############################################################################

FILTER="${1:-}"
CTEST_LOG="$BUILD_DIR/ctest_output.log"

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'
# No color when the output goes to a file or CI log: escape codes are just noise there.
[ -t 1 ] || { RED=''; GREEN=''; NC=''; }

step() {
    echo
    echo "=== $1 ==="
}

ok() {
    echo "[SUCCESS] $1"
}

fail() {
    echo -e "${RED}[ERROR] $1${NC}" >&2
    exit 1
}

START=$SECONDS

###############################################################################
# Configure
###############################################################################

step "[1/3] Configuring tests"

if cmake -S "$TEST_DIR" -B "$BUILD_DIR"; then
    echo
    ok "Configure succeeded"
else
    echo
    fail "Configure failed"
fi

###############################################################################
# Build
###############################################################################

step "[2/3] Building tests"

if cmake --build "$BUILD_DIR"; then
    echo
    ok "Build succeeded"
else
    echo
    fail "Build failed"
fi

###############################################################################
# Run
###############################################################################

step "[3/3] Running tests${FILTER:+ matching '$FILTER'}"

CTEST_ARGS=(--test-dir "$BUILD_DIR" --output-on-failure)
[[ -n "$FILTER" ]] && CTEST_ARGS+=(-R "$FILTER")

# Logged as well as shown, so the counts can be read from ctest's own summary
# line. set +e: a failing test must still reach the summary below.
set +e
ctest "${CTEST_ARGS[@]}" | tee "$CTEST_LOG"
CTEST_EXIT=${PIPESTATUS[0]}
set -e

# ctest prints a line like "100% tests passed, 0 tests failed out of 3".
SUMMARY_LINE=$(grep -E '^[0-9]+% tests passed' "$CTEST_LOG" || true)
TOTAL=$(echo "$SUMMARY_LINE" | grep -oE 'out of [0-9]+' | grep -oE '[0-9]+' || echo "?")
FAILED=$(echo "$SUMMARY_LINE" | grep -oE '[0-9]+ tests failed' | grep -oE '^[0-9]+' || echo "?")
if [ "$TOTAL" != "?" ] && [ "$FAILED" != "?" ]; then
    PASSED=$((TOTAL - FAILED))
else
    PASSED="?"
fi

if [ "$CTEST_EXIT" -ne 0 ]; then
    echo
    fail "Tests failed ($FAILED/$TOTAL failing -- see output above)"
fi
[ -n "$SUMMARY_LINE" ] || fail "No tests ran${FILTER:+ -- nothing matches '$FILTER'}"

echo
ok "All tests passed ($PASSED/$TOTAL)"

###############################################################################
# Summary
###############################################################################

ELAPSED=$((SECONDS - START))

echo
echo "=== SUMMARY ==="
echo "Suite    : $TEST_DIR${FILTER:+ (filter: $FILTER)}"
echo -e "Result   : ${GREEN}${PASSED}/${TOTAL} passed${NC}"
echo "Duration : ${ELAPSED}s"
