#!/usr/bin/env bash
# Step 4 — Symlink configs using GNU Stow
# Re-stows every package with -R (restow) so new files are picked up.

set -euo pipefail
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/lib/log.sh"

log_step "04 — Stow configs"

cd "$DOTFILES_DIR"

# ── Packages to stow ─────────────────────────────────────────
# neovim is the active config; neovim_light (lighter variant) is not stowed.
STOW_PKGS=(
    neovim
    bash
    tmux
    alacritty
    kitty
    starship
    i3_wm_endervour
    picom
    zathura
    flameshot
    thunar
    fontconfig
    mods
    clang
    claude
    vim
    niri
    noctalia
    theme
    git
)

# ~/.claude must be a real folder before stowing `claude`: if it is missing,
# stow would link the whole folder into this repo and Claude Code would write
# credentials, history and sessions into git. Same for skills/ (the app adds
# its own synced skills there).
mkdir -p "$HOME/.claude/skills" "$HOME/.claude-personal/skills"

# A real (non-symlink) ~/.vimrc makes stow refuse the vim package; keep it
# as a backup instead.
if [ -f "$HOME/.vimrc" ] && [ ! -L "$HOME/.vimrc" ]; then
    mv "$HOME/.vimrc" "$HOME/.vimrc.bak.$(date +%s)"
    log_warn "Existing ~/.vimrc moved to ~/.vimrc.bak.*"
fi

# A new machine ships its own ~/.bashrc (and maybe aliases/functions), which
# makes stow refuse the bash package; keep them as backups instead.
for f in .bashrc .aliases .bash_functions; do
    if [ -f "$HOME/$f" ] && [ ! -L "$HOME/$f" ]; then
        mv "$HOME/$f" "$HOME/$f.bak.$(date +%s)"
        log_warn "Existing ~/$f moved to ~/$f.bak.*"
    fi
done

# A real ~/.gitconfig holds this machine's name and email: it becomes
# ~/.gitconfig.local (included by git/.gitconfig) so nothing is lost.
if [ -f "$HOME/.gitconfig" ] && [ ! -L "$HOME/.gitconfig" ]; then
    if [ ! -e "$HOME/.gitconfig.local" ]; then
        mv "$HOME/.gitconfig" "$HOME/.gitconfig.local"
        log_warn "Existing ~/.gitconfig moved to ~/.gitconfig.local (name, email kept)."
    else
        mv "$HOME/.gitconfig" "$HOME/.gitconfig.bak.$(date +%s)"
        log_warn "Existing ~/.gitconfig moved to ~/.gitconfig.bak.*"
    fi
fi
if [ -f "$HOME/.config/git/ignore" ] && [ ! -L "$HOME/.config/git/ignore" ]; then
    mv "$HOME/.config/git/ignore" "$HOME/.config/git/ignore.bak.$(date +%s)"
    log_warn "Existing ~/.config/git/ignore moved to ~/.config/git/ignore.bak.*"
fi

# Thunar writes its own uca.xml (right-click actions) on first start, which makes
# stow refuse the thunar package; keep it as a backup instead.
if [ -f "$HOME/.config/Thunar/uca.xml" ] && [ ! -L "$HOME/.config/Thunar/uca.xml" ]; then
    mv "$HOME/.config/Thunar/uca.xml" "$HOME/.config/Thunar/uca.xml.bak.$(date +%s)"
    log_warn "Existing ~/.config/Thunar/uca.xml moved to ~/.config/Thunar/uca.xml.bak.*"
fi

# niri writes a default ~/.config/niri on first start, which makes stow refuse
# the niri package; keep it as a backup instead.
if [ -d "$HOME/.config/niri" ] && [ ! -L "$HOME/.config/niri" ]; then
    mv "$HOME/.config/niri" "$HOME/.config/niri.bak.$(date +%s)"
    log_warn "Existing ~/.config/niri moved to ~/.config/niri.bak.*"
fi

for pkg in "${STOW_PKGS[@]}"; do
    if [ -d "$DOTFILES_DIR/$pkg" ]; then
        log_info "Stowing $pkg..."
        stow -R -t "$HOME" "$pkg" && log_ok "$pkg stowed." || log_warn "$pkg had conflicts — check manually."
    else
        log_warn "Package '$pkg' directory not found, skipping."
    fi
done

# ── niri: mask Ubuntu's waybar.service ───────────────────────
# It crash-loops under GNOME/X11 and gives niri a second bar; niri's
# scripts/shell starts waybar itself. A /dev/null link is what
# `systemctl --user mask` makes, and it needs no running user session.
if [ -f /usr/lib/systemd/user/waybar.service ]; then
    mkdir -p "$HOME/.config/systemd/user"
    ln -sfn /dev/null "$HOME/.config/systemd/user/waybar.service"
    log_ok "waybar.service masked (niri starts waybar itself)."
fi

# ── This repo's pre-commit hook (secret check, .githooks/) ────
git -C "$DOTFILES_DIR" config core.hooksPath .githooks && log_ok "Secret check before commit enabled."

# ── Color profile ────────────────────────────────────────────
# kitty, alacritty, tmux and Neovim read the active profile of the `theme`
# package; pick the default on a new machine, keep the user's choice after.
if [ ! -e "${XDG_STATE_HOME:-$HOME/.local/state}/theme/current" ] && [ -x "$HOME/.local/bin/theme" ]; then
    "$HOME/.local/bin/theme" ubuntu >/dev/null && log_ok "Color profile set to ubuntu (switch with: theme <name>)."
fi

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

# ── Claude Personal profile (linked instructions, copied settings) ─
CLAUDE_PERSONAL_DIR="$HOME/.claude-personal"
if [ -d "$CLAUDE_PERSONAL_DIR" ]; then
    ln -sf "$DOTFILES_DIR/claude/.claude/CLAUDE.md" "$CLAUDE_PERSONAL_DIR/CLAUDE.md"
    ln -sf "$DOTFILES_DIR/claude/.claude/skills/project-status" "$CLAUDE_PERSONAL_DIR/skills/project-status"
    if [ ! -e "$CLAUDE_PERSONAL_DIR/settings.json" ]; then
        cp "$DOTFILES_DIR/templates/claude/settings.json" "$CLAUDE_PERSONAL_DIR/settings.json"
        log_ok "Claude personal settings copied from template."
    fi
fi

# ── Vim plugins ──────────────────────────────────────────────
# Install every plugin in .vimrc now, so the first `vim` launch has no
# missing-plugin errors (vim-plug itself is fetched by .vimrc).
if command -v vim >/dev/null && [ -L "$HOME/.vimrc" ]; then
    log_info "Installing Vim plugins..."
    vim -Nu "$HOME/.vimrc" -es -c 'PlugInstall --sync' -c 'qa!' </dev/null >/dev/null 2>&1 &&
        log_ok "Vim plugins installed." || log_warn "PlugInstall failed — run :PlugInstall inside vim."
fi

log_ok "Stow complete."
