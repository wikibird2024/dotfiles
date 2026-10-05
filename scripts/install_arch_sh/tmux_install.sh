#!/bin/bash
# TMUX Setup Script for Arch Linux

echo "🔧 Setting up tmux for Arch Linux..."

# Install required packages
echo "📦 Installing packages..."
sudo pacman -S --needed --noconfirm tmux git fzf

# Install clipboard tools (detect session type)
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    echo "🐧 Wayland detected, installing wl-clipboard..."
    sudo pacman -S --noconfirm wl-clipboard
else
    echo "X11 detected, installing xclip..."
    sudo pacman -S --noconfirm xclip
fi

# Backup existing config
if [[ -f ~/.tmux.conf ]]; then
    echo "💾 Backing up existing config..."
    cp ~/.tmux.conf ~/.tmux.conf.bak."$(date +%s)"
fi

# Copy config
echo "📄 Installing tmux config..."
cp tmux.conf ~/.tmux.conf

# Create directories
mkdir -p ~/.tmux/plugins
mkdir -p ~/.tmux/resurrect

# First run
echo "🚀 First run instructions:"
echo "1. Start tmux: tmux"
echo "2. Install plugins: Press Ctrl-a then Shift+i (capital I)"
echo "3. Reload config: Ctrl-a then r"

echo "✅ Setup complete!"
