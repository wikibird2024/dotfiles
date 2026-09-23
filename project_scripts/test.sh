#!/usr/bin/env bash
set -Eeuo pipefail

# UNCOMMENT THE NEXT LINE IF YOU WANT BASH TO PRINT EVERY COMMAND EXECUTED:
# set -x

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
cd "$SCRIPT_DIR"

TEST_DIR="Test"
BUILD_DIR="$TEST_DIR/build"

step() {
    echo
    echo "=== $1 ==="
}

ok() {
    echo "[SUCCESS] $1"
}

fail() {
    echo "[ERROR] $1" >&2
    exit 1
}

START=$SECONDS

###############################################################################
# Configure
###############################################################################

step "[1/3] Configuring host tests"

# Standalone project, built with the host's own compiler -- NOT the
# arm-none-eabi cross-toolchain build.sh uses. Kept separate on purpose
# (see Test/CMakeLists.txt and CLAUDE.md's Test/ section).
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

step "[2/3] Building host tests"

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

step "[3/3] Running host tests"

if ctest --test-dir "$BUILD_DIR" --output-on-failure; then
    echo
    ok "All tests passed"
else
    echo
    fail "Tests failed"
fi

###############################################################################
# Summary
###############################################################################

ELAPSED=$((SECONDS - START))

echo
echo "=== SUMMARY ==="
echo "Suite    : $TEST_DIR"
echo "Duration : ${ELAPSED}s"
