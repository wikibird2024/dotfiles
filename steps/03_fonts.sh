#!/usr/bin/env bash
# Step 3 — Install JetBrainsMono Nerd Font (user-local, no sudo)

set -euo pipefail
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/lib/log.sh"

log_step "03 — Nerd Fonts"

FONT_DIR="$HOME/.local/share/fonts/JetBrainsMonoNF"

# Check if font already installed and cached
if fc-list | grep -qi "JetBrainsMono"; then
    log_ok "JetBrainsMono Nerd Font already installed."
    exit 0
fi

log_info "Downloading JetBrainsMono Nerd Font..."
local_zip="/tmp/JetBrainsMono.zip"
curl -Lo "$local_zip" \
    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip

rm -rf "$FONT_DIR"
mkdir -p "$FONT_DIR"
unzip -q "$local_zip" -d "$FONT_DIR"
rm "$local_zip"

log_info "Refreshing font cache..."
fc-cache -f "$FONT_DIR"

log_ok "JetBrainsMono Nerd Font installed to $FONT_DIR"
