#!/bin/bash
# setup.sh
# An improved setup script for my work environment

set -euo pipefail

# Check for sudo and request password upfront
if ! sudo -n true 2>/dev/null; then
    sudo echo "Sudo password cached."
fi

# --- Main functions ---

function setup_system() {
    echo "Updating and upgrading system packages..."
    sudo apt update
    sudo apt -y upgrade
}

function install_packages() {
    echo "Installing required packages..."
    # Add your list of packages here
    # Example: sudo apt install -y vim git build-essential
    sudo apt install -y vim git tmux alacritty xfce4-terminal firefox
}

function setup_dotfiles() {
    echo "Setting up dotfiles..."
    # Clone your dotfiles repository
    # Example: git clone https://github.com/hx/dotfiles.git ~/dotfiles

    # Create symbolic links for configs
    echo "Creating symbolic links..."
    ln -sf ~/dotfiles/.vimrc ~/.vimrc
    ln -sf ~/dotfiles/.bashrc ~/.bashrc
    ln -sf ~/dotfiles/.config/tmux/tmux.conf ~/.tmux.conf
    ln -sf ~/dotfiles/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
    ln -sf ~/dotfiles/.config/i3/config ~/.config/i3/config
}

function configure_i3() {
    echo "Configuring i3 workspace layout..."
    # Ensure i3 is running
    if ! pgrep -x "i3" > /dev/null; then
        echo "i3 is not running. Please start i3 first."
        exit 1
    fi

    # Send commands to i3 to set up workspaces
    i3-msg 'workspace 1; exec alacritty'
    sleep 0.5
    i3-msg 'workspace 2'
    sleep 0.5
    i3-msg 'layout splith'
    sleep 0.5
    i3-msg 'exec xfce4-terminal --title="terminal_left"'
    sleep 0.5
    i3-msg 'exec firefox'
    sleep 1
    i3-msg '[title="terminal_left"] resize set width 33 ppt'
}

# --- Main script logic ---

echo "Starting system setup script..."
setup_system
install_packages
setup_dotfiles
configure_i3

echo "Setup complete!"
