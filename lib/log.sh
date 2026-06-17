#!/usr/bin/env bash
# Colored logging helpers — sourced by all install steps

RED='\033[0;31m'; YELLOW='\033[1;33m'; GREEN='\033[0;32m'
CYAN='\033[0;36m'; BOLD='\033[1m'; RESET='\033[0m'

log_info()    { echo -e "${CYAN}[INFO]${RESET}  $*"; }
log_ok()      { echo -e "${GREEN}[OK]${RESET}    $*"; }
log_warn()    { echo -e "${YELLOW}[WARN]${RESET}  $*"; }
log_error()   { echo -e "${RED}[ERROR]${RESET} $*" >&2; }
log_step()    { echo -e "\n${BOLD}${CYAN}━━━ $* ━━━${RESET}"; }

# Check if a command exists
has() { command -v "$1" &>/dev/null; }

# Run only if the target is missing (idempotent guard)
# Usage: already_done <check_path_or_cmd> && return 0
already_done() {
    if [ -e "$1" ] || (has "$1" 2>/dev/null); then
        log_ok "$1 already present, skipping."
        return 0
    fi
    return 1
}
