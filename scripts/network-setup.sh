#!/bin/bash
# Chạy với sudo: sudo ./network-setup.sh

# Copy file vào hệ thống thay vì link
cp ./configs/*.conf /etc/NetworkManager/conf.d/

# Trả lại quyền cho root để đảm bảo bảo mật
chown root:root /etc/NetworkManager/conf.d/*.conf
chmod 644 /etc/NetworkManager/conf.d/*.conf

systemctl restart NetworkManager
