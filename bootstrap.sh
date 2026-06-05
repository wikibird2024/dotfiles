#!/usr/bin/env bash
set -euo pipefail

# Get the absolute path of the repository root
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$DOTFILES_DIR"

# Execute your system installer from the scripts directory
if [ -f "./scripts/install_arch.sh" ]; then
    echo "[INFO] Running system package installer..."
    chmod +x ./scripts/install_arch.sh
    ./scripts/install_arch.sh
fi

# Run your Stow commands safely from the root folder
echo "[INFO] Stowing configurations..."
stow -R -T "$HOME" nvim i3 zsh tmux alacritty
