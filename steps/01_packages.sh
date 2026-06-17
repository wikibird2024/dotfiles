#!/usr/bin/env bash
# Step 1 — Install core system packages
# Idempotent: apt/pacman won't reinstall already-present packages.

set -euo pipefail
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/lib/log.sh"
source "$DOTFILES_DIR/lib/detect.sh"

log_step "01 — Core system packages"

pkg_update

# ── Essentials ────────────────────────────────────────────────
PKGS_APT=(
    git curl wget unzip build-essential
    stow zsh
    xclip xsel wl-clipboard   # clipboard backends
    ripgrep                    # rg (used by nvim live grep)
    fontconfig                 # fc-cache for nerd fonts
    python3 python3-pip
    ninja-build cmake gettext  # needed if building nvim from source
)

PKGS_PACMAN=(
    git curl wget unzip base-devel
    stow zsh
    xclip xsel wl-clipboard
    ripgrep
    fontconfig
    python python-pip
    ninja cmake
)

pm=$(detect_pkg_manager)
log_info "Package manager: $pm"

case "$pm" in
    apt)
        sudo apt-get install -y "${PKGS_APT[@]}"
        ;;
    pacman)
        sudo pacman -S --noconfirm "${PKGS_PACMAN[@]}"
        ;;
    *)
        log_warn "Unknown package manager — install packages manually."
        ;;
esac

log_ok "Core packages done."
