
#!/usr/bin/env bash
#
# install_clipboard_support.sh
# Tự động cài đặt và cấu hình clipboard chung cho Vim/Neovim trên Linux
# Author: Ginko

set -e

echo "📦 [1/5] Cập nhật gói hệ thống..."
sudo apt update -y

echo "🧰 [2/5] Cài các gói clipboard backend (xclip, xsel, wl-clipboard)..."
sudo apt install -y xclip xsel wl-clipboard

echo "🧠 [3/5] Kiểm tra môi trường hiển thị..."
if echo "$XDG_SESSION_TYPE" | grep -q "wayland"; then
    echo "→ Môi trường: Wayland"
    CLIP_CMD="wl-copy"
else
    echo "→ Môi trường: X11"
    CLIP_CMD="xclip"
fi

echo "🔍 [4/5] Cài Neovim đầy đủ có hỗ trợ clipboard..."
if command -v nvim >/dev/null 2>&1; then
    echo "Neovim đã tồn tại. Kiểm tra hỗ trợ clipboard..."
    if ! nvim --version | grep -q "+clipboard"; then
        echo "❌ Phiên bản hiện tại không hỗ trợ clipboard → Cài bản chính thức."
        sudo apt remove -y neovim
        sudo apt purge -y neovim
        sudo apt autoremove -y
    else
        echo "✅ Neovim đã hỗ trợ clipboard. Bỏ qua bước cài lại."
    fi
fi

if ! command -v nvim >/dev/null 2>&1 || ! nvim --version | grep -q "+clipboard"; then
    echo "⬇️ Tải và cài Neovim bản đầy đủ..."
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
    sudo tar xzvf nvim-linux64.tar.gz -C /usr/local/
    sudo ln -sf /usr/local/nvim-linux64/bin/nvim /usr/local/bin/nvim
    rm -f nvim-linux64.tar.gz
fi

echo "⚙️ [5/5] Cấu hình Neovim để sử dụng clipboard hệ thống..."
mkdir -p ~/.config/nvim
NVIM_CFG=~/.config_
