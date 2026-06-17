#!/usr/bin/env bash
# bootstrap.sh — One-command setup for a new Linux machine
#
# Usage:
#   ./bootstrap.sh              # Full setup
#   ./bootstrap.sh --skip-fonts # Skip font download
#   ./bootstrap.sh --only-stow  # Only deploy configs (useful after a pull)
#
# Each step is idempotent — safe to re-run any time.

set -euo pipefail

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$DOTFILES_DIR/lib/log.sh"

# ── Parse flags ───────────────────────────────────────────────
SKIP_PACKAGES=false
SKIP_TOOLS=false
SKIP_FONTS=false
SKIP_STOW=false
SKIP_SHELL=false

for arg in "$@"; do
    case "$arg" in
        --skip-packages) SKIP_PACKAGES=true ;;
        --skip-tools)    SKIP_TOOLS=true ;;
        --skip-fonts)    SKIP_FONTS=true ;;
        --skip-stow)     SKIP_STOW=true ;;
        --skip-shell)    SKIP_SHELL=true ;;
        --only-stow)
            SKIP_PACKAGES=true; SKIP_TOOLS=true
            SKIP_FONTS=true;    SKIP_SHELL=true
            ;;
        --help|-h)
            echo "Usage: $0 [--skip-packages] [--skip-tools] [--skip-fonts] [--skip-stow] [--skip-shell] [--only-stow]"
            exit 0
            ;;
        *) log_warn "Unknown flag: $arg" ;;
    esac
done

# ── Run steps ─────────────────────────────────────────────────
run_step() {
    local script="$DOTFILES_DIR/steps/$1"
    if [ ! -f "$script" ]; then
        log_error "Step script not found: $script"
        return 1
    fi
    chmod +x "$script"
    bash "$script"
}

echo ""
echo "╔══════════════════════════════════════════╗"
echo "║        DOTFILES BOOTSTRAP v2.0           ║"
echo "║  $(date '+%Y-%m-%d %H:%M')  —  $(uname -s)/$(uname -m)         ║"
echo "╚══════════════════════════════════════════╝"
echo ""

$SKIP_PACKAGES || run_step "01_packages.sh"
$SKIP_TOOLS    || run_step "02_tools.sh"
$SKIP_FONTS    || run_step "03_fonts.sh"
$SKIP_STOW     || run_step "04_stow.sh"
$SKIP_SHELL    || run_step "05_shell.sh"

echo ""
log_ok "Bootstrap complete!"
echo ""
echo "  Next steps:"
echo "  1. Log out and back in  (activates zsh as default shell)"
echo "  2. Open tmux            (plugins auto-install on first launch)"
echo "  3. Open nvim            (lazy.nvim auto-installs on first launch)"
echo ""
