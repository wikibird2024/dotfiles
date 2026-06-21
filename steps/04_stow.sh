#!/usr/bin/env bash
# Step 4 — Symlink configs using GNU Stow
# Re-stows every package with -R (restow) so new files are picked up.

set -euo pipefail
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/lib/log.sh"

log_step "04 — Stow configs"

cd "$DOTFILES_DIR"

# ── Packages to stow ─────────────────────────────────────────
# nvim2 is the active config. nvim (old) is intentionally excluded.
STOW_PKGS=(
    nvim2
    tmux
    zsh
    alacritty
    kitty
    starship
    i3_wm_endervour
    picom
    zathura
    flameshot
    fontconfig
    mods
    clang
)

for pkg in "${STOW_PKGS[@]}"; do
    if [ -d "$DOTFILES_DIR/$pkg" ]; then
        log_info "Stowing $pkg..."
        stow -R -t "$HOME" "$pkg" && log_ok "$pkg stowed." || log_warn "$pkg had conflicts — check manually."
    else
        log_warn "Package '$pkg' directory not found, skipping."
    fi
done

# ── Xresources (single file, not a dir) ──────────────────────
if [ -d "$DOTFILES_DIR/Xresources" ]; then
    log_info "Stowing Xresources..."
    stow -R -t "$HOME" Xresources && log_ok "Xresources stowed."
fi

log_ok "Stow complete."
