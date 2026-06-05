
#!/usr/bin/env bash
# ==========================================================
# install_ripgrep_from_source.sh
# Author : Ginko
# Purpose: Build & install ripgrep (rg) from source safely
# ==========================================================

set -euo pipefail
trap 'echo "❌ Lỗi xảy ra tại dòng $LINENO"; exit 1' ERR

RIPGREP_VERSION="14.1.0"
REPO_URL="https://github.com/BurntSushi/ripgrep.git"
INSTALL_PATH="/usr/local/bin/rg"
USER_HOME=$(eval echo ~${SUDO_USER:-$USER})
CONFIG_PATH="$USER_HOME/.config/ripgrep/rc"

echo "=== [1/7] Chuẩn bị môi trường ==="
sudo apt update -y
sudo apt install -y build-essential curl git pkg-config libpcre2-dev

# ----------------------------------------------------------
# Cài đặt Rust (nếu chưa có)
# ----------------------------------------------------------
echo "=== [2/7] Kiểm tra Rust/Cargo ==="
if ! command -v cargo >/dev/null 2>&1; then
    echo "⚙️  Cargo chưa được cài, đang tiến hành cài Rust..."
    curl https://sh.rustup.rs -sSf | sh -s -- -y
    source "$USER_HOME/.cargo/env"
else
    echo "✅ Rust/Cargo đã có sẵn."
fi

# ----------------------------------------------------------
# Clone mã nguồn ripgrep
# ----------------------------------------------------------
echo "=== [3/7] Clone mã nguồn ripgrep (v$RIPGREP_VERSION) ==="
cd /tmp
rm -rf ripgrep 2>/dev/null || true
git clone --depth 1 --branch "$RIPGREP_VERSION" "$REPO_URL" ripgrep || {
    echo "⚠️ Không tìm thấy tag $RIPGREP_VERSION, dùng branch master."
    git clone --depth 1 "$REPO_URL" ripgrep
}
cd ripgrep

# ----------------------------------------------------------
# Build từ source
# ----------------------------------------------------------
echo "=== [4/7] Build ripgrep ở chế độ release (PCRE2 enabled) ==="
export PATH="$USER_HOME/.cargo/bin:$PATH"
cargo build --release --features 'pcre2'

# ----------------------------------------------------------
# Cài đặt binary
# ----------------------------------------------------------
echo "=== [5/7] Cài đặt ripgrep vào hệ thống ==="
sudo install -Dm755 target/release/rg "$INSTALL_PATH"

# ----------------------------------------------------------
# Cấu hình mặc định
# ----------------------------------------------------------
echo "=== [6/7] Tạo file cấu hình ripgrep mặc định ==="
mkdir -p "$(dirname "$CONFIG_PATH")"
if [ ! -f "$CONFIG_PATH" ]; then
cat <<EOF > "$CONFIG_PATH"
--smart-case
--hidden
--glob '!.git/*'
--colors 'match:fg:yellow'
--colors 'path:fg:green'
EOF
    echo "✅ Cấu hình mới được tạo: $CONFIG_PATH"
else
    echo "⚙️ Đã tồn tại file cấu hình, giữ nguyên: $CONFIG_PATH"
fi

# ----------------------------------------------------------
# Kiểm tra kết quả
# ----------------------------------------------------------
echo "=== [7/7] Kiểm tra cài đặt ripgrep ==="
if command -v rg >/dev/null 2>&1; then
    echo "✅ Cài đặt thành công!"
    rg --version
else
    echo "❌ Không tìm thấy lệnh 'rg' trong PATH."
    exit 1
fi

echo
echo "Cấu hình lưu tại: $CONFIG_PATH"
echo "Build từ source với tối ưu PCRE2"
echo "=== Hoàn tất ==="
