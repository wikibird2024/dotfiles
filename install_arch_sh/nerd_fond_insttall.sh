#!/usr/bin/env bash
#
# ============================================================
#  JetBrainsMono Nerd Font Installer (Arch Linux)
#  Author : Ginko (optimized for Arch by GPT-5)
#  Purpose: Install a complete Nerd Font for Terminal + Neovim
#           to display icons, glyphs, and dev symbols.
# ============================================================

set -e

FONT_NAME="JetBrainsMono"
NF_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_NAME}.zip"
FONT_DIR="$HOME/.local/share/fonts/JetBrainsMonoNF"

echo "🔧 [1/5] Preparing font installation..."
sudo pacman -Sy --noconfirm wget unzip fontconfig >/dev/null

echo "🧹 [2/5] Cleaning old font installation..."
rm -rf "$FONT_DIR"
mkdir -p "$FONT_DIR"

echo "📦 [3/5] Downloading JetBrainsMono Nerd Font..."
wget -O /tmp/${FONT_NAME}.zip "$NF_URL"

echo "📂 [4/5] Extracting and installing font..."
unzip -o /tmp/${FONT_NAME}.zip -d "$FONT_DIR" >/dev/null
rm /tmp/${FONT_NAME}.zip

echo "🔁 [5/5] Updating font cache..."
fc-cache -fv >/dev/null

echo "✅ Installation complete!"
echo "------------------------------------------------------"
echo "Font installed to: $FONT_DIR"
echo "Set this font in your terminal preferences:"
echo "   → Kitty: ~/.config/kitty/kitty.conf → font_family JetBrainsMono Nerd Font"
echo "   → GNOME/Elementary Terminal: Preferences → Profiles → Text → Custom Font"
echo "     Select: JetBrainsMono Nerd Font"
echo "------------------------------------------------------"
echo "Test icons with:"
echo '   echo "      "'
echo "------------------------------------------------------"
echo "Tips:"
echo "  • Works perfectly with Neovim, fzf, tmux, lsd, etc."
echo "  • Update font cache anytime with: fc-cache -fv"
echo "------------------------------------------------------"

