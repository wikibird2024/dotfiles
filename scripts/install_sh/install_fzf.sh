#!/usr/bin/env bash
#
# ============================================================
#  FZF Installer (Stable Git Source)
#  Author : Ginko (optimized by GPT-5)
#  Purpose: Install fzf from official GitHub source with full
#           bindings, completions, and shell integration.
# ============================================================

set -e

echo "🔧 [1/6] Checking prerequisites..."
if ! command -v git >/dev/null 2>&1; then
    echo "❌ Git not found. Installing git..."
    sudo apt update && sudo apt install git -y
else
    echo "✅ Git found."
fi

echo "🧹 [2/6] Removing old fzf installation if any..."
sudo apt remove -y fzf >/dev/null 2>&1 || true
rm -rf ~/.fzf >/dev/null 2>&1 || true

echo "📦 [3/6] Cloning fzf stable source..."
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf

echo "⚙️ [4/6] Running fzf installer..."
yes | ~/.fzf/install --all >/dev/null 2>&1

echo "🔗 [5/6] Configuring shell integration..."
SHELL_NAME=$(basename "$SHELL")

case "$SHELL_NAME" in
  bash)
    CONFIG_FILE="$HOME/.bashrc"
    SOURCE_LINE='[ -f ~/.fzf.bash ] && source ~/.fzf.bash'
    ;;
  zsh)
    CONFIG_FILE="$HOME/.zshrc"
    SOURCE_LINE='[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh'
    ;;
  *)
    echo "⚠️ Unsupported shell ($SHELL_NAME). Please add FZF source manually."
    exit 1
    ;;
esac

if ! grep -Fxq "$SOURCE_LINE" "$CONFIG_FILE"; then
  echo "$SOURCE_LINE" >> "$CONFIG_FILE"
  echo "✅ Added FZF source line to $CONFIG_FILE"
else
  echo "ℹ️ FZF source already exists in $CONFIG_FILE"
fi

echo "🔁 [6/6] Reloading shell configuration..."
source "$CONFIG_FILE"

echo "✅ Installation completed successfully!"
echo "-----------------------------------------"
echo "FZF Version:"
fzf --version || echo "⚠️ fzf not found in PATH"
echo "-----------------------------------------"
echo "Usage tips:"
echo "  • Ctrl+R → Fuzzy search command history"
echo "  • Ctrl+T → Fuzzy search files"
echo "  • Type 'ls | fzf' to test manually"
echo "-----------------------------------------"

