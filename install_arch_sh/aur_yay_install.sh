#!/bin/bash
# ===========================================
# Arch Linux AUR Setup (Minimal Version)
# Author: Ginko
# Purpose: Install yay (AUR helper)
# ===========================================

set -e

echo "==> Installing required build tools..."
sudo pacman -S --needed --noconfirm base-devel git

echo "==> Cloning yay from AUR..."
cd ~
git clone https://aur.archlinux.org/yay.git

echo "==> Building and installing yay..."
cd yay
makepkg -si --noconfirm

echo "==> ✅ AUR setup complete!"
echo "You can now install AUR packages using:"
echo "   yay -S <package_name>"

