#!/usr/bin/env bash
#
# ============================================================
#  JetBrainsMono Nerd Font Installer (System-Wide / User)
#  Author : Ginko (optimized by GPT-5)
#  Purpose: Install a complete Nerd Font for Terminal + Neovim
#           to display icons, glyphs, and dev symbols.
# ============================================================

set -e

FONT_NAME="JetBrainsMono"
NF_URL="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/${FONT_NAME}.zip"
FONT_DIR="$HOME/.local/share/fonts/JetBrainsMonoNF"

echo "🔧 [1/5] Preparing font installation..."
sudo apt update -y >/dev/null 2>&1 || true
sudo apt install -y wget unzip fontconfig >/dev/null 2>&1

echo "🧹 [2/5] Cleaning old font installation..."
rm -rf "$FONT_DIR"
mkdir -p "$FONT_DIR"

echo "📦 [3/5] Downloading JetBrainsMono Nerd Font..."
wget -O /tmp/${FONT_NAME}.zip "$NF_URL"

echo "📂 [4/5] Extracting and installing font..."
unzip -o /tmp/${FONT_NAME}.zip -d "$FONT_DIR" >/dev/null
rm /tmp/${FONT_NAME}.zip

echo "🔁 [5/5] Updating system font cache..."
fc-cache -fv >/dev/null

echo "✅ Installation complete!"
echo "------------------------------------------------------"
echo "Font installed to: $FONT_DIR"
echo "You can now set this font in your terminal preferences:"
echo
echo "   → Kitty: ~/.config/kitty/kitty.conf"
echo "     font_family JetBrainsMono Nerd Font"
echo
echo "   → GNOME/Elementary Terminal:"
echo "     Preferences → Profiles → Text → Custom Font"
echo "     Select: JetBrainsMono Nerd Font"
echo
echo "------------------------------------------------------"
echo "Test icons with:"
echo '   echo "      "'
echo "------------------------------------------------------"
echo "Tips:"
echo "  • Works perfectly with Neovim, fzf, tmux, lsd, etc."
echo "  • Update font cache anytime with: fc-cache -fv"
echo "------------------------------------------------------"

