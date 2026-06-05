
#!/usr/bin/env bash
# ==============================================================
# Install Alacritty from source (optimized for Debian/Ubuntu/Mint)
# Author: Ginko Pro Build
# ==============================================================

set -e
set -u
set -o pipefail

echo ">>> [1/7] Updating system and installing build dependencies..."
sudo apt update
sudo apt install -y \
    cmake pkg-config libfreetype6-dev libfontconfig1-dev \
    libxcb-xfixes0-dev libxkbcommon-dev python3 git curl \
    libegl1-mesa-dev libgles2-mesa-dev

# ─── Install Rust ──────────────────────────────────────────────
if ! command -v rustc &>/dev/null; then
    echo ">>> [2/7] Installing Rust toolchain (via rustup)..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
    source "$HOME/.cargo/env"
else
    echo ">>> [2/7] Rust already installed."
fi

# ─── Clone source ─────────────────────────────────────────────
WORKDIR="$HOME/alacritty"
if [ ! -d "$WORKDIR" ]; then
    echo ">>> [3/7] Cloning Alacritty source code..."
    git clone https://github.com/alacritty/alacritty.git "$WORKDIR"
else
    echo ">>> [3/7] Repository already exists. Pulling latest changes..."
    cd "$WORKDIR"
    git pull
fi

cd "$WORKDIR"

# ─── Build ─────────────────────────────────────────────────────
echo ">>> [4/7] Building Alacritty in release mode..."
cargo build --release

# ─── Install binary ────────────────────────────────────────────
echo ">>> [5/7] Installing binary to /usr/local/bin..."
sudo cp target/release/alacritty /usr/local/bin/

# ─── Desktop integration ───────────────────────────────────────
echo ">>> [6/7] Installing desktop entry and icons..."
sudo desktop-file-install extra/linux/Alacritty.desktop || true
sudo update-desktop-database || true

# ─── Copy default config ───────────────────────────────────────
echo ">>> [7/7] Setting up configuration..."
mkdir -p ~/.config/alacritty
if [ ! -f ~/.config/alacritty/alacritty.yml ]; then
    cp alacritty.yml ~/.config/alacritty/alacritty.yml
fi

# ─── Verify installation ───────────────────────────────────────
echo ">>> Installation complete!"
echo "---------------------------------------------------------------"
echo "Binary   : $(command -v alacritty)"
echo "Version  : $(alacritty --version)"
echo "Config   : ~/.config/alacritty/alacritty.yml"
echo "---------------------------------------------------------------"
echo "To run Alacritty, type:  alacritty"
echo "You can edit configuration in ~/.config/alacritty/alacritty.yml"
echo "---------------------------------------------------------------"
