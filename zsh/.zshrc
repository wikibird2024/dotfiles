# =======================================================================
# PROFESSIONAL ZSH CONFIGURATION (Powered by Oh My Zsh & P10k)
# Optimized for performance, Git workflow, and ESP32 Development.
# =======================================================================

# --- 1. OH MY ZSH SETUP ---
# Đường dẫn tới thư mục cài đặt Oh My Zsh.
export ZSH="$HOME/.oh-my-zsh"

# THIẾT LẬP THEME: Sử dụng Powerlevel10k
ZSH_THEME="powerlevel10k/powerlevel10k"

# Kích hoạt các plugins cốt lõi (Bắt buộc phải có để thành pro)
plugins=(
    git                        # Cực nhiều alias ngắn gọn (gst, ga, gc...)
    zsh-autosuggestions        # Gợi ý lệnh từ lịch sử (bấm mũi tên phải để chấp nhận)
    zsh-syntax-highlighting    # Tô màu lệnh khi gõ (giúp phát hiện lỗi)
    zsh-history                # Tăng cường chức năng lịch sử
    sudo                       # Bấm ESC 2 lần để tự động thêm 'sudo ' vào đầu lệnh
    docker                     # Hoàn thành lệnh cho Docker
    docker-compose             # Hoàn thành lệnh cho Docker Compose
)

source $ZSH/oh-my-zsh.sh

# --- 2. CORE ZSH OPTIONS ---

# History Configuration (Giữ nguyên cấu hình tốt của bạn)
setopt histignorealldups sharehistory
HISTSIZE=10000 # Tăng lịch sử lên 10000 dòng (cao thủ cần lịch sử dài)
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Cho phép gõ cd path thay vì phải gõ 'cd path'
setopt autocd 

# Bật tính năng 'extended globbing' (tính năng tìm kiếm nâng cao)
setopt extended_glob

# --- 3. KEYBINDINGS ---

# Use Emacs keybindings
bindkey -e

# --- 4. ENVIRONMENT & PATHS ---

# Source Bash aliases/profile (Nếu bạn có các alias từ Bash)
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# KHỞI TẠO MÔI TRƯỜNG ESP-IDF (Quan trọng cho dự án Fall Detection)
# Đảm bảo các lệnh idf.py và công cụ toolchain hoạt động
if [ -f "$HOME/esp/esp-idf/export.sh" ]; then
    . "$HOME/esp/esp-idf/export.sh"
fi

# THIẾT LẬP CHO ALACRITTY TERM (Để các ứng dụng nhận diện 24-bit color)
# Đây là cách đặt TERM nếu bạn không muốn đặt trong alacritty.toml
# export TERM="alacritty"

# --- 5. POWERLEVEL10K CONFIG (Cần chạy p10k configure lần đầu) ---

# Khởi tạo p10k config. Sau lần đầu khởi động, nó sẽ tự tạo file ~/.p10k.zsh
# và load từ đó, giúp tăng tốc độ đáng kể.
if [[ -f ~/.p10k.zsh ]]; then
    source ~/.p10k.zsh
fi
