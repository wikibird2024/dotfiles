#!/usr/bin/env bash

# dependency_i3.sh - Install dependencies for the i3_ender configuration
# Designed for Arch Linux / EndeavourOS

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

log_info() {
    echo -e "${GREEN}[INFO]${NC} $*"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $*"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $*" >&2
}

# Check if running on an Arch-based system
if [ ! -f /etc/arch-release ]; then
    log_error "This script is designed for Arch Linux or Arch-based distributions (like EndeavourOS)."
    log_warn "If you are on Debian/Ubuntu or Fedora, please install the equivalent packages manually."
    exit 1
fi

# List of official packages to install
PACKAGES=(
    # Core Window Manager & Bar
    i3-wm
    i3blocks
    
    # Terminals
    alacritty
    kitty
    xfce4-terminal
    
    # Application Launcher & Menus
    rofi
    yad
    
    # Compositor, Wallpaper & Autotiling
    picom
    feh
    autotiling
    
    # Screen Locker & Power Management
    i3lock
    xss-lock
    scrot
    imagemagick
    power-profiles-daemon
    
    # Audio & Media Control
    pulseaudio-utils
    alsa-utils
    pavucontrol
    playerctl
    
    # Brightness Control
    brightnessctl
    
    # File Manager, Browser & System Tray
    thunar
    firefox
    network-manager-applet
    networkmanager
    
    # Fonts (Crucial for Icons and UI)
    ttf-font-awesome
    noto-fonts
    
    # Script Dependencies & Utilities
    dex
    polkit-gnome
    lm_sensors
    sysstat
    jq
    curl
    perl
    python
)

log_info "Updating package databases and installing dependencies..."
sudo pacman -Syu --needed "${PACKAGES[@]}"

log_info "Enabling and starting systemd services..."

# Enable and start power-profiles-daemon for the power profiles switcher
if systemctl list-unit-files | grep -q power-profiles-daemon; then
    log_info "Enabling power-profiles-daemon service..."
    sudo systemctl enable --now power-profiles-daemon.service
else
    log_warn "power-profiles-daemon service unit not found. Please check your installation."
fi

# Setup lm_sensors (optional interactive step, but recommended)
log_info "Detecting hardware sensors (lm_sensors)..."
log_warn "You may want to run 'sudo sensors-detect' manually after this script to configure your hardware sensors."

log_info "All dependencies installed successfully!"
log_info "Please restart i3 ($mod+Shift+r) or log out and log back in to apply all changes."
