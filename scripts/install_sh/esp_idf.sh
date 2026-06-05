#!/usr/bin/env bash
set -e  # dừng khi gặp lỗi
set -u  # lỗi khi dùng biến chưa khai báo

# ---- Config ----
ESP_IDF_DIR="$HOME/esp/esp-idf"   # đường dẫn cài đặt ESP-IDF
ESP_IDF_VERSION="v5.1"            # phiên bản ESP-IDF muốn cài

# ---- Update & install system dependencies ----
sudo apt update
sudo apt install -y git wget flex bison gperf python3 python3-pip cmake ninja-build ccache libffi-dev libssl-dev dfu-util

# ---- Tạo folder và clone ESP-IDF ----
mkdir -p "$(dirname "$ESP_IDF_DIR")"
if [ ! -d "$ESP_IDF_DIR" ]; then
    git clone -b "$ESP_IDF_VERSION" --recursive https://github.com/espressif/esp-idf.git "$ESP_IDF_DIR"
else
    echo "ESP-IDF đã tồn tại, bỏ qua clone"
fi

# ---- Cài toolchain (nếu chưa có) ----
"$ESP_IDF_DIR"/install.sh

# ---- Thiết lập environment ----
echo "Thiết lập environment, bạn có thể add dòng này vào ~/.bashrc hoặc ~/.zshrc"
echo "source $ESP_IDF_DIR/export.sh"
source "$ESP_IDF_DIR/export.sh"

# ---- Cài Python packages cần thiết ----
python3 -m pip install --upgrade pip
python3 -m pip install -r "$ESP_IDF_DIR/requirements.txt"

echo "Cài đặt ESP-IDF xong. Kiểm tra bằng: idf.py --version"

