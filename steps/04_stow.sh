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
    claude
    vim
)

# ~/.claude must be a real folder before stowing `claude`: if it is missing,
# stow would link the whole folder into this repo and Claude Code would write
# credentials, history and sessions into git. Same for skills/ (the app adds
# its own synced skills there).
mkdir -p "$HOME/.claude/skills"

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

# ── Claude Code settings (copied once, not linked) ───────────
# Claude Code writes approved permissions into settings.json, so it stays a
# local file. The template only seeds a new machine.
CLAUDE_SETTINGS="$HOME/.claude/settings.json"
if [ ! -e "$CLAUDE_SETTINGS" ]; then
    cp "$DOTFILES_DIR/templates/claude/settings.json" "$CLAUDE_SETTINGS"
    log_ok "Claude settings copied from template."
else
    log_info "Claude settings already present, not overwritten."
fi

log_ok "Stow complete."
