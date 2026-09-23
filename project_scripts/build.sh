#!/usr/bin/env bash
set -Eeuo pipefail

# UNCOMMENT THE NEXT LINE IF YOU WANT BASH TO PRINT EVERY COMMAND EXECUTED:
# set -x

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
cd "$SCRIPT_DIR"

BUILD_DIR="build/Debug"
FW_DIR="../Grader_Tool/FW"

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
# Build
###############################################################################

step "[1/2] Building Debug"

# NOTE: If you need to see raw full compiler commands, append '-- -v' to the cmake line below:
# cmake --build --preset Debug -- -v
if cmake --build --preset Debug; then
    echo
    ok "Build succeeded"
else
    echo
    fail "Build failed"
fi

###############################################################################
# Find HEX/BIN
###############################################################################

step "[2/2] Copy firmware"

# Copy both .hex and .bin: Grader_Tool's Browse-a-file upgrade flow can be
# pointed straight at FW/*.bin (no hex-to-bin re-derivation in that path,
# unlike the default blank-path flow) -- a .bin left stale here from an
# older build would silently get flashed instead of the latest firmware.
shopt -s nullglob
hex_files=("$BUILD_DIR"/*.hex)
bin_files=("$BUILD_DIR"/*.bin)
shopt -u nullglob

check_single() {
    local label="$1"
    shift
    local files=("$@")
    case ${#files[@]} in
        0)
            fail "No .$label found in $BUILD_DIR"
            ;;
        1)
            ;;
        *)
            echo "[ERROR] Multiple .$label files found:" >&2
            for file in "${files[@]}"; do
                echo "  $file" >&2
            done
            exit 1
            ;;
    esac
}

check_single "hex" "${hex_files[@]}"
check_single "bin" "${bin_files[@]}"

HEX_FILE="${hex_files[0]}"
BIN_FILE="${bin_files[0]}"

echo "Target directory: $FW_DIR"
mkdir -p "$FW_DIR"

# Using -v (verbose) to output the raw file copy result on terminal
cp -vf "$HEX_FILE" "$BIN_FILE" "$FW_DIR/"

ok "Copied $(basename "$HEX_FILE") and $(basename "$BIN_FILE")"

###############################################################################
# Summary
###############################################################################

ELAPSED=$((SECONDS - START))

echo
echo "=== SUMMARY ==="
echo "Firmware : $(basename "$HEX_FILE"), $(basename "$BIN_FILE")"
echo "Output   : $FW_DIR"
echo "Duration : ${ELAPSED}s"
