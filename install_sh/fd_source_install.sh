
#!/usr/bin/env bash
# ===============================================
# Install fd-find (fd) from source on Linux
# Workflow-ready version by Ginko
# ===============================================

set -euo pipefail

# ---------------- Config ----------------
REPO_URL="https://github.com/sharkdp/fd.git"
INSTALL_DIR="/usr/local/bin"
TEMP_DIR="/tmp/fd-build"

# ---------------- Functions ----------------
echo_info() { echo -e "[\033[1;34m+\033[0m] $*"; }
echo_warn() { echo -e "[\033[1;33m!\033[0m] $*"; }
echo_ok() { echo -e "[\033[1;32m✓\033[0m] $*"; }

# ---------------- Dependency check ----------------
echo_info "Checking dependencies..."

# Git
if ! command -v git >/dev/null 2>&1; then
    echo_info "Installing git..."
    sudo apt update && sudo apt install -y git
else
    echo_info "Git found: $(git --version)"
fi

# Rust / Cargo
if ! command -v cargo >/dev/null 2>&1; then
    echo_info "Installing Rust (cargo)..."
    curl https://sh.rustup.rs -sSf | sh -s -- -y

    # Source env safely
    if [ -f "$HOME/.cargo/env" ]; then
        source "$HOME/.cargo/env"
    else
        echo_warn "Rust installed but $HOME/.cargo/env not found. Restart shell to use cargo."
    fi
else
    echo_info "Cargo found: $(cargo --version)"
fi

# ---------------- Clone fd ----------------
echo_info "Cloning fd repository..."
rm -rf "$TEMP_DIR"
git clone --depth 1 "$REPO_URL" "$TEMP_DIR"
cd "$TEMP_DIR"

# Ensure cleanup on exit
trap "rm -rf $TEMP_DIR" EXIT

# ---------------- Build ----------------
echo_info "Building fd (optimized for local CPU)..."
export RUSTFLAGS="-C target-cpu=native"
cargo build --release

# ---------------- Install ----------------
echo_info "Installing fd to $INSTALL_DIR..."
if [ ! -w "$INSTALL_DIR" ]; then
    echo_warn "$INSTALL_DIR not writable, using sudo..."
    SUDO="sudo"
else
    SUDO=""
fi

$SUDO cp target/release/fd "$INSTALL_DIR/fd"

# ---------------- Verify ----------------
echo_info "Verifying installation..."
fd --version
echo_ok "fd successfully installed from source!"

echo_info "You can now use 'fd' anywhere in your terminal."
