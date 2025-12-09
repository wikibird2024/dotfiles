#!/usr/bin/env bash
# i3-gaps Full Auto Install Script for Linux Mint / Ubuntu
# This script installs all dependencies, builds i3-gaps, and sets up the session.
# Run with: sudo bash install_i3gaps.sh

set -e

echo "=== Updating system ==="
apt update

echo "=== Installing full dependencies and environment packages ==="
apt install -y \
  git meson ninja-build pkg-config build-essential ccache automake autoconf libtool \
  libxcb1-dev libxcb-util0-dev libxcb-icccm4-dev libxcb-keysyms1-dev \
  libxcb-xkb-dev libxcb-randr0-dev libxcb-xinerama0-dev libxcb-shape0-dev \
  libxcb-cursor-dev libxcb-xrm-dev libxcb-render-util0-dev libxcb-ewmh-dev \
  libxkbcommon-dev libxkbcommon-x11-dev libpango1.0-dev libyajl-dev \
  libstartup-notification0-dev libev-dev libx11-xcb-dev libxml2-utils \
  alacritty rofi feh picom polybar brightnessctl xclip \
  x11-xserver-utils network-manager-gnome pavucontrol lxappearance \
  thunar dunst libnotify-bin neovim i3lock-fancy acpi playerctl

echo "=== Cloning i3-gaps ==="
cd /opt || exit 1
git clone https://github.com/Airblader/i3 i3-gaps || true
cd i3-gaps

echo "=== Building i3-gaps ==="
rm -rf build
meson setup build
ninja -C build
ninja -C build install

echo "=== Creating i3-gaps session file ==="
cat >/usr/share/xsessions/i3-gaps.desktop <<EOF
[Desktop Entry]
Name=i3-gaps
Comment=Improved tiling window manager
Exec=i3
Type=Application
DesktopNames=i3
EOF

echo "=== Setting correct i3 binary priority ==="
if [ -f /usr/bin/i3 ]; then
    mv /usr/bin/i3 /usr/bin/i3.vanilla.backup
fi
ln -sf /usr/local/bin/i3 /usr/bin/i3

echo "=== Installation complete! ==="
echo "Reboot your machine and select 'i3-gaps' at the login screen."

