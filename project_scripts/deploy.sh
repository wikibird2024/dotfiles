#!/usr/bin/env bash
set -Eeuo pipefail

# UNCOMMENT THE NEXT LINE IF YOU WANT BASH TO PRINT EVERY COMMAND EXECUTED:
# set -x

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
cd "$SCRIPT_DIR"

BUILD_DIR="build/Debug"
GRADER_TOOL_DIR="../Grader_Tool"

REMOTE_HOST="greystone@172.16.21.48"
REMOTE_DIR="/home/greystone/HaoTranFW/FW"
REMOTE_GRADER_TOOL_DIR="/home/greystone/HaoTranFW/Grader_Tool"

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

step "[1/3] Building Debug"

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

step "[2/3] Copy firmware to $REMOTE_HOST:$REMOTE_DIR"

shopt -s nullglob
fw_files=("$BUILD_DIR"/*.hex "$BUILD_DIR"/*.bin)
shopt -u nullglob

if [ ${#fw_files[@]} -eq 0 ]; then
    fail "No .hex/.bin found in $BUILD_DIR"
fi

# Uses key-based auth (ssh-copy-id already run) -- no password prompt.
# Add -P <port> if the target uses a non-default SSH port.
scp "${fw_files[@]}" "$REMOTE_HOST:$REMOTE_DIR/"

for f in "${fw_files[@]}"; do
    ok "Copied $(basename "$f") to $REMOTE_HOST:$REMOTE_DIR"
done

mkdir -p "$GRADER_TOOL_DIR/FW"

# Also refresh local Grader_Tool/FW/ with this same build -- the rsync below
# mirrors the local Grader_Tool tree as-is, and the deployed app's own
# default upgrade path ("../FW/..." relative to wherever it runs) resolves
# to this folder, not to $REMOTE_DIR above. Without this, rsync would ship
# whatever stale .hex/.bin happened to already be sitting in Grader_Tool/FW/
# (e.g. from a build predating this one) instead of what was just built.
cp -vf "${fw_files[@]}" "$GRADER_TOOL_DIR/FW/"
ok "Refreshed $GRADER_TOOL_DIR/FW/ with this build"

###############################################################################
# Sync Grader_Tool
###############################################################################

step "[3/3] Sync Grader_Tool to $REMOTE_HOST:$REMOTE_GRADER_TOOL_DIR"

# Add/update only -- nothing on the remote is deleted, even if removed locally.
# Add -e "ssh -p <port>" if the target uses a non-default SSH port.
rsync -avz --progress "$GRADER_TOOL_DIR/" "$REMOTE_HOST:$REMOTE_GRADER_TOOL_DIR/"

ok "Synced $GRADER_TOOL_DIR to $REMOTE_HOST:$REMOTE_GRADER_TOOL_DIR"

###############################################################################
# Summary
###############################################################################

ELAPSED=$((SECONDS - START))

echo
echo "=== SUMMARY ==="
for f in "${fw_files[@]}"; do
    echo "Firmware   : $(basename "$f")"
done
echo "Grader_Tool: synced"
echo "Target     : $REMOTE_HOST:$REMOTE_DIR"
echo "Duration   : ${ELAPSED}s"
