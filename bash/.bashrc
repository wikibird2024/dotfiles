# =======================================================================
# PROFESSIONAL BASH CONFIGURATION - OPTIMIZED FOR STARSHIP & MODULARITY
# Clean, fast, environment-safe setup for development (ESP32, Rust, etc.)
# =======================================================================

# ──────────────────────────────────────────────────────────────────────────────
# 0. SHELL GUARD & CORE OPTIONS
# ──────────────────────────────────────────────────────────────────────────────
# Load only for interactive, non-login shells (Standard practice)
case $- in *i*) ;; *) return ;; esac

# Shell Options
shopt -s checkwinsize autocd cmdhist nocaseglob histappend

# ──────────────────────────────────────────────────────────────────────────────
# 1. HISTORY SETTINGS
# ──────────────────────────────────────────────────────────────────────────────
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=5000
HISTFILESIZE=10000
# Ghi lịch sử lệnh trước khi hiển thị prompt tiếp theo
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# ──────────────────────────────────────────────────────────────────────────────
# 2. PATH & DEFAULT ENVIRONMENT (Gộp tất cả các PATH lại đây)
# ──────────────────────────────────────────────────────────────────────────────
# Thiết lập các PATH ưu tiên theo thứ tự: User Bins -> System Tools -> Frameworks
export PATH="$HOME/.local/bin:$HOME/bin:/usr/local/texlive/2025/bin/x86_64-linux:$PATH"

# TERMINAL / EDITOR
export EDITOR=nvim  # Ưu tiên nvim/vim như bạn đã cấu hình
export VISUAL=$EDITOR

# ──────────────────────────────────────────────────────────────────────────────
# 3. COMPONENT & FRAMEWORK INITIALIZATION (Tải các script bên ngoài)
# ──────────────────────────────────────────────────────────────────────────────

# Bash Completion (Giúp các lệnh như Git, Docker hoàn thành tốt hơn)
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# ZOXIDE — SMART CD REPLACEMENT
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi

# NVM (Node Version Manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"

# RUST/CARGO
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# ESP-IDF ENVIRONMENT (Dựa trên dự án của bạn)
# [ -f ~/esp/esp-idf/export.sh ] && source ~/esp/esp-idf/export.sh

# ──────────────────────────────────────────────────────────────────────────────
# 4. PROMPT & FZF INTEGRATION
# ──────────────────────────────────────────────────────────────────────────────

# Starship Prompt (Đẹp & nhanh, thay thế hoàn toàn cho PS1 thủ công)
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
else
    # Prompt cấu hình thủ công (Dùng làm dự phòng nếu Starship không có)
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi

# FZF INTEGRATION (Dùng các file được cài đặt bởi package manager)
[[ -f /usr/share/fzf/key-bindings.bash ]] && source /usr/share/fzf/key-bindings.bash
[[ -f /usr/share/fzf/completion.bash ]] && source /usr/share/fzf/completion.bash

# Tùy chỉnh FZF (Uncomment nếu cần)
# export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
# export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
# export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

# ──────────────────────────────────────────────────────────────────────────────
# 5. ALIASES, COLORS & CUSTOM SCRIPTS
# ──────────────────────────────────────────────────────────────────────────────

# LS COLORS & ALIASES (Đặt LS COLORS trước khi tải ALIASES)
if command -v dircolors >/dev/null 2>&1; then
    if [ -r ~/.dircolors ]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
fi

# LOAD USER ALIASES
[ -f ~/.aliases ] && . ~/.aliases

# CUSTOM SHELL FUNCTIONS
[ -f ~/.bash_functions ] && . ~/.bash_functions

# LOCAL OVERRIDES (Tải cuối cùng để ghi đè mọi thiết lập trước đó)
[ -f ~/.bash_local ] && . ~/.bash_local

# 6. FINAL TOUCHES
# ──────────────────────────────────────────────────────────────────────────────
# ──────────────────────────────────────────────────────────────────────────────
# TERMINAL BELL CONTROL
if [[ "$(tty)" =~ ^/dev/tty[0-9]+$ ]] && [[ -z "$TMUX" ]] && [[ -z "$SSH_TTY" ]]; then
    # Tắt chuông terminal
    setterm --blength 0 2>/dev/null || true
fi

