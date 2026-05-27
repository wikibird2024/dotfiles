#!/usr/bin/env bash

# dependency_i3.sh - Install dependencies for the i3_ender configuration
# Designed for Ubuntu/Debian and Arch Linux / EndeavourOS

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

# Detect OS
OS="unknown"
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
    if [ "${ID_LIKE:-}" = "debian" ] || [ "$ID" = "ubuntu" ] || [ "$ID" = "debian" ]; then
        OS="debian"
    elif [ "${ID_LIKE:-}" = "arch" ] || [ "$ID" = "arch" ] || [ "$ID" = "endeavouros" ]; then
        OS="arch"
    fi
fi

if [ "$OS" = "unknown" ]; then
    log_error "Unsupported operating system."
    log_warn "This script supports Ubuntu/Debian and Arch Linux."
    exit 1
fi

if [ "$OS" = "debian" ]; then
    log_info "Detected Ubuntu/Debian-based system."
    
    # List of Debian/Ubuntu packages
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
        network-manager-gnome
        network-manager
        
        # Fonts (Crucial for Icons and UI)
        fonts-font-awesome
        fonts-noto
        
        # Script Dependencies & Utilities
        dex
        policykit-1-gnome
        lm-sensors
        sysstat
        jq
        curl
        perl
        python3
        python3-pip
    )

    log_info "Updating package databases and installing dependencies..."
    sudo apt-get update
    sudo apt-get install -y "${PACKAGES[@]}"

    # Install autotiling via pip if not available in apt
    if ! command -v autotiling >/dev/null 2>&1; then
        log_info "Installing autotiling via pip3..."
        sudo pip3 install --break-system-packages autotiling || sudo pip3 install autotiling || true
    fi

elif [ "$OS" = "arch" ]; then
    log_info "Detected Arch-based system."
    
    PACKAGES=(
        i3-wm i3blocks alacritty kitty xfce4-terminal rofi yad picom feh autotiling
        i3lock xss-lock scrot imagemagick power-profiles-daemon pulseaudio-utils
        alsa-utils pavucontrol playerctl brightnessctl thunar firefox
        network-manager-applet networkmanager ttf-font-awesome noto-fonts dex
        polkit-gnome lm_sensors sysstat jq curl perl python
    )

    log_info "Updating package databases and installing dependencies..."
    sudo pacman -Syu --needed "${PACKAGES[@]}"
fi

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
