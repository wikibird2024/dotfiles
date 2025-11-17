
#!/usr/bin/env bash
# time.sh — Hiển thị ngày giờ cho i3blocks
# Portable, chạy trên nhiều distro
# Format: Thứ Ngày Tháng Giờ:Phút

# Kiểm tra date có sẵn
if ! command -v date &>/dev/null; then
    echo "date not found"
    exit 1
fi

# Xuất ra định dạng đẹp
date '+%a %d %b %H:%M'
