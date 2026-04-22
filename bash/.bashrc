# =======================================================================
# UNIVERSAL BASH CONFIG - ARCH & MINT COMPATIBLE
# =======================================================================

# 1. NGĂN CHẶN VÒNG LẶP (Chống treo máy trên Mint)
if [ -z "$__BASHRC_LOADED" ]; then
    export __BASHRC_LOADED=1
else
    return
fi

# 2. KIỂM TRA SHELL TƯƠNG TÁC
[[ $- != *i* ]] && return

# 3. KHAI BÁO CÁC BIẾN MÔI TRƯỜNG CƠ BẢN
export NVM_DIR="$HOME/.nvm"
export EDITOR=nvim

# 4. THIẾT LẬP PATH THÔNG MINH
# Gộp các đường dẫn, ưu tiên Cargo và Local bin
paths=(
    "$HOME/.cargo/bin"
    "$HOME/.local/bin"
    "$HOME/bin"
    "/usr/local/texlive/2025/bin/x86_64-linux"
)

for d in "${paths[@]}"; do
    if [ -d "$d" ]; then
        PATH="$d:$PATH"
    fi
done
export PATH

# 5. TỰ ĐỘNG NHẬN DIỆN DISTRO
if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
fi

# 6. KHỞI TẠO CÔNG CỤ (Dùng lệnh nạp trực tiếp để tránh lỗi PATH chưa cập nhật)
# Starship
command -v starship >/dev/null 2>&1 && eval "$(starship init bash)"

# Zoxide
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"

# NVM (Nạp đúng cách để dùng được ngay)
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# 7. FZF - ĐA NỀN TẢNG
fzf_paths=(
    "/usr/share/fzf/key-bindings.bash"
    "/usr/share/doc/fzf/examples/key-bindings.bash"
    "$HOME/.fzf.bash"
)
for f in "${fzf_paths[@]}"; do
    [ -f "$f" ] && . "$f"
done

# 8. ALIASES & OS CUSTOMIZATION
[ -f ~/.aliases ] && . ~/.aliases

case "$OS" in
    arch)
        alias pacs='sudo pacman -S'
        ;;
    linuxmint|ubuntu|debian)
        alias apts='sudo apt install'
        ;;
esac
