
#!/usr/bin/env bash

set -e

REPO="$HOME/dotfiles"
PKG="neomutt"

echo "[+] Creating directory structure..."

mkdir -p "$REPO/$PKG/.config/neomutt"

# Tạo file cấu hình mẫu nếu chưa có
NEOMUTT_RC="$REPO/$PKG/.config/neomutt/neomuttrc"

if [ ! -f "$NEOMUTT_RC" ]; then
    cat > "$NEOMUTT_RC" <<EOF
set realname = "Your Name"
set from = "your_email@example.com"
set use_from = yes

# IMAP
set imap_user = "your_email@example.com"
set imap_pass = ""
set folder = "imaps://imap.example.com/"
set spoolfile = "+INBOX"
set record = "+Sent"

# SMTP
set smtp_url = "smtp://your_email@example.com@smtp.example.com:587/"
set smtp_pass = ""

set ssl_starttls = yes
set ssl_force_tls = yes

set editor = "nvim"
set sort = 'reverse-date'
set delete = yes
set quit = yes
color status green default
EOF
    echo "[+] Created sample neomuttrc"
else
    echo "[+] neomuttrc already exists, skipping..."
fi

echo "[+] Running stow..."
cd "$REPO"
stow -v -R neomutt

echo "[+] NeoMutt dotfiles installed successfully!"
