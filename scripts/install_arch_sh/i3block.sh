
#!/usr/bin/env bash
# ============================================================
# i3blocks Full Setup Script for Arch Linux
# Author: Ginko + optimized by GPT-5
# Purpose: Install essential packages for i3blocks
# ============================================================

# Ensure script is run as root or with sudo
if [[ $EUID -ne 0 ]]; then
   echo "Please run as root or use sudo"
   exit 1
fi

echo "==> Updating system..."
pacman -Syu --noconfirm

echo "==> Installing i3blocks and dependencies..."
# Core i3blocks
pacman -S --needed --noconfirm i3blocks i3status i3-wm xorg-xsetroot

# System monitoring
pacman -S --needed --noconfirm lm_sensors hddtemp sysstat bc inxi smartmontools

# Network info
pacman -S --needed --noconfirm iproute2 net-tools wireless_tools iw curl wget

# Audio / Media
pacman -S --needed --noconfirm pulseaudio pavucontrol playerctl

# Laptop / Battery
pacman -S --needed --noconfirm acpi upower

# Date / Time
pacman -S --needed --noconfirm util-linux

# Optional / Nice-to-have
pacman -S --needed --noconfirm feh rsync i3lock blueman

echo "==> Setup complete!"
echo "You can now configure your ~/.config/i3blocks/config"
