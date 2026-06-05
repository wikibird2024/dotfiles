
#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

BLUE='\033[0;34m'
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

log() { echo -e "${GREEN}➤ $1${NC}"; }
die() { echo -e "${RED}✖ $1${NC}"; exit 1; }

[[ -f /etc/arch-release ]] || die "Script này chỉ dành cho Arch Linux."

log "Cập nhật hệ thống & cài core packages"
sudo pacman -Syu --needed --noconfirm \
  base-devel neovim git curl wget unzip tar \
  nodejs npm python python-pip clang rustup \
  ripgrep fd fzf tree-sitter-cli xclip \
  ttf-jetbrains-mono-nerd

log "Cấu hình Rust toolchain"
command -v rustup >/dev/null || die "rustup không tồn tại trong PATH"
rustup toolchain install stable
rustup default stable

VENV="$HOME/.local/share/nvim/venv"
if [[ ! -d "$VENV" ]]; then
  log "Tạo Python venv cho Neovim"
  python -m venv "$VENV"
  source "$VENV/bin/activate"
  pip install --upgrade pip
  pip install pynvim==0.5.0 debugpy==1.8.0
  deactivate
else
  log "Python venv đã tồn tại – bỏ qua"
fi

if [[ -d "$HOME/.config/nvim" ]]; then
  log "Đã tìm thấy ~/.config/nvim"
else
  echo -e "${RED}⚠ Không tìm thấy ~/.config/nvim – hãy symlink dotfiles của bạn.${NC}"
fi

cat <<EOF

${BLUE}Hoàn tất cài đặt nền tảng Neovim.${NC}

Các bước tiếp theo:
  nvim
  :Lazy sync
  :Mason
  :checkhealth

EOF
