#!/usr/bin/env bash
# =========================================================
# install_nvim_latest.sh — Professional Neovim installer
# Author: Ginko setup by ChatGPT GPT-5
# Purpose: Build & install Neovim (stable/nightly) from GitHub source
# Compatible: Ubuntu, Linux Mint, Debian, Elementary OS
# =========================================================

set -e

# ----- CONFIG -----
INSTALL_DIR="$HOME/neovim"
BRANCH="stable"   # default branch ("stable" or "nightly")

# ----- PARSE ARGUMENT -----
if [[ "$1" == "nightly" ]]; then
    BRANCH="nightly"
fi

echo "==========================================================="
echo ">>> Neovim Installer — Building branch: $BRANCH"
echo "==========================================================="

# ----- 1. Remove old apt version -----
echo "[1/6] Removing old Neovim packages (if any)..."
sudo apt remove --purge -y neovim || true
sudo apt autoremove -y || true

# ----- 2. Install dependencies -----
echo "[2/6] Installing build dependencies..."
sudo apt update
sudo apt install -y ninja-build gettext cmake unzip curl build-essential git

# ----- 3. Clone or update repo -----
echo "[3/6] Cloning or updating Neovim source..."
if [[ -d "$INSTALL_DIR/.git" ]]; then
    cd "$INSTALL_DIR"
    git fetch origin
    git checkout "$BRANCH"
    git pull
else
    git clone https://github.com/neovim/neovim.git "$INSTALL_DIR"
    cd "$INSTALL_DIR"
    git checkout "$BRANCH"
fi

# ----- 4. Build Neovim -----
echo "[4/6] Building Neovim..."
make CMAKE_BUILD_TYPE=RelWithDebInfo

# ----- 5. Install -----
echo "[5/6] Installing Neovim to /usr/local/bin..."
sudo make install

# ----- 6. Verify -----
echo "[6/6] Verifying installation..."
nvim --version | head -n 5

echo "==========================================================="
echo "✅ Neovim ($BRANCH) installed successfully!"
echo "   Executable: $(command -v nvim)"
echo "==========================================================="

