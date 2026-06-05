#!/bin/bash

# Tên file .xprofile
PROFILE_FILE="$HOME/.xprofile"

echo "Bắt đầu cài đặt Fcitx5 và các thành phần cần thiết trên Arch Linux..."

# 1. Cài đặt các gói Fcitx5
echo "Đang cập nhật hệ thống và cài đặt các gói Fcitx5 (cần quyền sudo)..."
sudo pacman -Syu --noconfirm fcitx5 fcitx5-configtool fcitx5-gtk fcitx5-qt fcitx5-rime

if [ $? -eq 0 ]; then
    echo "Cài đặt gói Fcitx5 thành công."
else
    echo "LỖI: Không thể cài đặt các gói Fcitx5. Vui lòng kiểm tra kết nối mạng và quyền hạn."
    exit 1
fi

# 2. Cấu hình Biến môi trường
echo "Đang cấu hình các biến môi trường trong $PROFILE_FILE..."

CONFIG_CONTENT="
# Cấu hình Fcitx5 cho bộ gõ Tiếng Việt
export GTK_IM_MODULE=fcitx
export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
"

# Kiểm tra nếu file tồn tại, nếu chưa thì tạo file mới
if [ ! -f "$PROFILE_FILE" ]; then
    touch "$PROFILE_FILE"
    echo "Tạo file $PROFILE_FILE mới."
fi

# Kiểm tra xem cấu hình đã tồn tại chưa để tránh ghi đè/nhân đôi
if grep -q "GTK_IM_MODULE=fcitx" "$PROFILE_FILE"; then
    echo "Cấu hình Fcitx đã tồn tại trong $PROFILE_FILE. Bỏ qua bước thêm biến môi trường."
else
    # Thêm nội dung vào cuối file .xprofile
    echo "$CONFIG_CONTENT" >> "$PROFILE_FILE"
    echo "Đã thêm các biến môi trường Fcitx5 vào $PROFILE_FILE."
fi

# 3. Hướng dẫn các bước thủ công
echo "---"
echo "✅ HOÀN TẤT CÀI ĐẶT CƠ BẢN"
echo "---"
echo "Để Fcitx5 hoạt động, bạn phải thực hiện các bước sau:"
echo "1. **ĐĂNG XUẤT VÀ ĐĂNG NHẬP LẠI** (hoặc khởi động lại) để các biến môi trường có hiệu lực."
echo "2. Sau khi đăng nhập lại, chạy công cụ cấu hình:"
echo "   fcitx5-configtool"
echo "3. Trong công cụ cấu hình, vào tab 'Input Method', nhấn **(+)** để thêm bộ gõ **Rime**."
echo "4. Sử dụng **Ctrl + Space** để kích hoạt bộ gõ."
