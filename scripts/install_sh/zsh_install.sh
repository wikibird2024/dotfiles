
#!/usr/bin/env bash
# =======================================================================
# ZSH + OH-MY-ZSH + POWERLEVEL10K INSTALLER
# Portable Auto-Setup Script for Developers (ESP-IDF, Git, Docker)
# Author: Ginko
# =======================================================================

set -euo pipefail

# -----------------------------
# 1. Install Dependencies
# -----------------------------
echo "[*] Installing dependencies..."

if command -v apt &>/dev/null; then
    sudo apt update -y
    sudo apt install -y zsh git curl wget fonts-powerline
elif command -v pacman &>/dev/null; then
    sudo pacman -Sy --noconfirm zsh git curl wget
elif command -v dnf &>/dev/null; then
    sudo dnf install -y zsh git curl wget
else
    echo "Unsupported package manager. Please install zsh, git, and curl manually."
fi

# -----------------------------
# 2. Install Oh My Zsh
# -----------------------------
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "[*] Installing Oh My Zsh..."
    RUNZSH=no KEEP_ZSHRC=yes sh -c \
        "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
else
    echo "[*] Oh My Zsh already installed. Skipping."
fi

# -----------------------------
# 3. Install Powerlevel10k
# -----------------------------
THEME_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k"
if [ ! -d "$THEME_DIR" ]; then
    echo "[*] Installing Powerlevel10k theme..."
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$THEME_DIR"
else
    echo "[*] Powerlevel10k already installed. Skipping."
fi

# -----------------------------
# 4. Install Plugins
# -----------------------------
PLUGIN_DIR="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins"

declare -A plugins=(
    ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"
    ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting.git"
    ["zsh-history"]="https://github.com/zsh-users/zsh-history.git"
)

for name in "${!plugins[@]}"; do
    if [ ! -d "$PLUGIN_DIR/$name" ]; then
        echo "[*] Installing plugin: $name"
        git clone --depth=1 "${plugins[$name]}" "$PLUGIN_DIR/$name"
    else
        echo "[*] Plugin $name already installed. Skipping."
    fi
done

# -----------------------------
# 5. Copy Configuration Files
# -----------------------------
echo "[*] Deploying Zsh configuration..."

DOTFILES_DIR="${DOTFILES_DIR:-$HOME/dotfiles}"

if [ -f "$DOTFILES_DIR/.zshrc" ]; then
    cp -f "$DOTFILES_DIR/.zshrc" "$HOME/.zshrc"
    echo "✓ Copied .zshrc"
fi

if [ -f "$DOTFILES_DIR/.p10k.zsh" ]; then
    cp -f "$DOTFILES_DIR/.p10k.zsh" "$HOME/.p10k.zsh"
    echo "✓ Copied .p10k.zsh"
fi

# -----------------------------
# 6. Set Zsh as Default Shell
# -----------------------------
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "[*] Changing default shell to zsh..."
    chsh -s "$(which zsh)"
else
    echo "✓ Zsh is already the default shell."
fi

# -----------------------------
# 7. Final Instructions
# -----------------------------
echo
echo "=========================================================="
echo "✅ Zsh environment setup completed successfully!"
echo "Restart your terminal or run: exec zsh"
echo "=========================================================="
