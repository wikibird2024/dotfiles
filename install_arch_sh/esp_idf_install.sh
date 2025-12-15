#!/usr/bin/env bash
set -e  # Dừng khi gặp lỗi
set -u  # Lỗi khi dùng biến chưa khai báo

# ---- Config ----
IDF_PATH_DIR="$HOME/esp"            # Thư mục chứa ESP-IDF
ESP_IDF_DIR="$IDF_PATH_DIR/esp-idf" # Đường dẫn cài đặt ESP-IDF
ESP_IDF_VERSION="v5.1"              # Phiên bản ESP-IDF muốn cài

# ---- 1. Install system dependencies with pacman ----
echo "1. Cài đặt các gói phụ thuộc hệ thống qua Pacman (chỉ cài đặt gói, không cập nhật hệ thống)..."
# Các gói tương đương: git wget flex bison gperf python3 python3-pip cmake ninja-build ccache libffi-dev libssl-dev dfu-util
sudo pacman -S --noconfirm \
    git \
    wget \
    flex \
    bison \
    gperf \
    python \
    python-pip \
    cmake \
    ninja \
    ccache \
    libffi \
    openssl \
    dfu-util

if [ $? -ne 0 ]; then
    echo "LỖI: Không thể cài đặt các gói phụ thuộc. Vui lòng kiểm tra kết nối mạng và quyền hạn sudo."
    exit 1
fi
echo "Các gói phụ thuộc đã được cài đặt thành công."

# ---- 2. Tạo folder và clone ESP-IDF ----
echo "2. Tạo folder và Clone ESP-IDF (Phiên bản $ESP_IDF_VERSION)..."
mkdir -p "$IDF_PATH_DIR"

if [ ! -d "$ESP_IDF_DIR" ]; then
    git clone -b "$ESP_IDF_VERSION" --recursive https://github.com/espressif/esp-idf.git "$ESP_IDF_DIR"
    if [ $? -ne 0 ]; then
        echo "LỖI: Không thể clone ESP-IDF. Vui lòng kiểm tra kết nối mạng."
        exit 1
    fi
else
    echo "ESP-IDF đã tồn tại tại $ESP_IDF_DIR, bỏ qua clone."
fi

# ---- 3. Cài toolchain ----
echo "3. Cài đặt Toolchain và các công cụ khác..."
cd "$ESP_IDF_DIR" || { echo "LỖI: Không thể vào thư mục IDF."; exit 1; }

# Chạy install.sh (đã bao gồm bước tải và cài toolchain)
./install.sh

if [ $? -ne 0 ]; then
    echo "LỖI: Script install.sh không chạy thành công."
    exit 1
fi
echo "Toolchain đã được cài đặt thành công."

# ---- 4. Cài Python packages cần thiết ----
echo "4. Cài đặt các gói Python yêu cầu..."
python -m pip install --upgrade pip
python -m pip install -r "$ESP_IDF_DIR/requirements.txt"

# ---- 5. Thiết lập quyền truy cập Serial (UART/USB) ----
echo "5. Thiết lập quyền truy cập cổng Serial (UART/USB)."
echo "Thêm người dùng hiện tại ($USER) vào nhóm 'uucp':"
sudo usermod -a -G uucp "$USER"
echo "Để thay đổi quyền hạn có hiệu lực, bạn phải **ĐĂNG XUẤT VÀ ĐĂNG NHẬP LẠI**."

# ---- 6. Thông báo và Hướng dẫn Kích hoạt Môi trường Thủ công ----
echo "=========================================================="
echo "✅ HOÀN TẤT CÀI ĐẶT ESP-IDF ($ESP_IDF_VERSION)"
echo "=========================================================="
echo "LƯU Ý: Môi trường IDF không được kích hoạt tự động khi mở terminal."
echo "Khi bạn muốn sử dụng IDF, hãy chạy lệnh sau trong terminal:"
echo "source $ESP_IDF_DIR/export.sh"
echo "Kiểm tra bằng cách chạy: idf.py --version sau khi source."
