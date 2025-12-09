#!/bin/bash

# ====================================================================
# SCRIPT CÀI ĐẶT DEPENDENCIES CHO RANGER (Ubuntu/Debian)
# Mục đích: Hỗ trợ các lệnh tùy chỉnh, scope.sh, và xem trước ảnh (Ueberzug).
# ====================================================================

echo "=== Bắt đầu cài đặt Dependencies cho Ranger ==="

# 1. Cập nhật hệ thống
sudo apt update -y

# 2. CÀI ĐẶT GÓI HỖ TRỢ RANGER VÀ CÁC LỆNH TÙY CHỈNH
# Bao gồm: Ranger, xclip, fzf, neovim, trash-cli, gcc, feh, sxiv
echo -e "\n-> Cài đặt Dependencies cho Custom Commands và Tool Cơ bản..."
sudo apt install -y \
    ranger \
    python3-pip \
    xclip fzf neovim \
    trash-cli gcc \
    feh sxiv

# 3. CÀI ĐẶT GÓI HỖ TRỢ SCRIPT SCOPE.SH (Xem trước tệp)
# Bao gồm: poppler-utils, mediainfo, atool, w3m, imagemagick, librsvg2-bin, antiword, catdoc, tiện ích nén
echo -e "\n-> Cài đặt Dependencies cho Scope.sh (Xem trước tệp)..."
sudo apt install -y \
    poppler-utils \
    mediainfo \
    atool \
    w3m \
    imagemagick \
    librsvg2-bin \
    antiword catdoc \
    p7zip-full unrar unzip tar

# 4. CÀI ĐẶT GÓI XEM TRƯỚC HÌNH ẢNH QUA PIP (Khuyến nghị: Ueberzug)
echo -e "\n-> Cài đặt Ueberzug qua pip (để xem trước ảnh trong terminal)..."
pip install ueberzug

echo -e "\n=== Hoàn tất cài đặt Dependencies! ==="
echo "Các gói sau đã được cài đặt: xclip, fzf, neovim, trash-cli, gcc, feh, sxiv, poppler-utils, mediainfo, atool, w3m, imagemagick, librsvg2-bin, antiword, catdoc, và các tiện ích nén."
