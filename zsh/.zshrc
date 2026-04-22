# ============================================================
# PORTABLE ZSH (UPGRADED VERSION)
# STARSHIP + ZOXIDE + FZF + AUTOSUGGEST + HIGHLIGHTING
# ============================================================

# ----------------------------
# 0. GUARD
# ----------------------------
[[ -n ${ZSH_PORTABLE_LOADED-} ]] && return
ZSH_PORTABLE_LOADED=1

# ----------------------------
# 1. ENVIRONMENT & COLORS
# ----------------------------
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=nvim
export VISUAL=nvim

# Bật màu cho ls tùy theo hệ điều hành
if [[ "$OSTYPE" == "darwin"* ]]; then
  export CLICOLOR=1
  export LSCOLORS=Gxfxcxdxbxegedabagacad
  alias ls='ls -G'
else
  alias ls='ls --color=auto'
fi

# ----------------------------
# 2. PATH (SAFE + DEDUP)
# ----------------------------
typeset -U path
path=(
  $HOME/.local/bin
  $HOME/bin
  /usr/local/bin
  $path
)

# ----------------------------
# 3. HISTORY
# ----------------------------
HISTFILE=$HOME/.zsh_history
HISTSIZE=20000
SAVEHIST=20000
setopt APPEND_HISTORY SHARE_HISTORY
setopt HIST_IGNORE_DUPS HIST_FIND_NO_DUPS HIST_IGNORE_SPACE

# ----------------------------
# 4. COMPLETION & PLUGINS (THE "BRAIN")
# ----------------------------
autoload -Uz compinit
compinit -d "$HOME/.zcompdump-${ZSH_VERSION}"

# Cấu hình Menu chọn (có màu và dùng phím mũi tên)
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z1-9}={A-Z1-9}' # Không phân biệt hoa thường
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

# Tự động tải Plugin nếu chưa có (Tăng lực cho gợi ý)
ZSH_TOOLS="$HOME/.zsh-tools"
mkdir -p "$ZSH_TOOLS"

function load_plugin() {
  local repo=$1
  local name=$(basename $repo)
  if [[ ! -d "$ZSH_TOOLS/$name" ]]; then
    echo "Installing $name..."
    git clone --depth 1 "https://github.com/$repo.git" "$ZSH_TOOLS/$name" >/dev/null 2>&1
  fi
  source "$ZSH_TOOLS/$name/$name.zsh" 2>/dev/null || source "$ZSH_TOOLS/$name/$name.plugin.zsh" 2>/dev/null
}

load_plugin "zsh-users/zsh-autosuggestions"     # Gợi ý lệnh mờ
load_plugin "zsh-users/zsh-syntax-highlighting" # Tô màu lệnh đúng/sai

# ----------------------------
# 5. STARSHIP (UI CORE)
# ----------------------------
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
else
  # Tự động cài Starship nếu thiếu
  if command -v curl >/dev/null 2>&1; then
    echo "Starship not found. Installing..."
    curl -sS https://starship.rs/install.sh | sh -s -- -y >/dev/null 2>&1
    eval "$(starship init zsh)"
  else
    setopt prompt_subst
    PROMPT='%F{cyan}%n@%m%f:%F{yellow}%~%f %# '
  fi
fi

# ----------------------------
# 6. ZOXIDE & FZF
# ----------------------------
# Zoxide (Smart CD)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# FZF Keybindings & Completion
FZF_DIR="$ZSH_TOOLS/fzf"
if [[ ! -d "$FZF_DIR" ]]; then
  command -v git >/dev/null 2>&1 && {
    git clone --depth 1 https://github.com/junegunn/fzf.git "$FZF_DIR" >/dev/null 2>&1
    "$FZF_DIR/install" --key-bindings --completion --no-update-rc >/dev/null 2>&1
  }
fi
[[ -f "$FZF_DIR/shell/key-bindings.zsh" ]] && source "$FZF_DIR/shell/key-bindings.zsh"
[[ -f "$FZF_DIR/shell/completion.zsh" ]] && source "$FZF_DIR/shell/completion.zsh"

# ----------------------------
# 7. ALIASES & FUNCTIONS
# ----------------------------
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'
alias ..='cd ..'
alias cls='clear && printf "\033c"'

# Git
alias gs='git status'
alias ga='git add'
alias gc='git commit'
alias gp='git push'

# Utils
mk() { mkdir -p "$@"; cd "$@"; } # Tạo folder và nhảy vào luôn
ff() { find . -type f 2>/dev/null | fzf; }
fd() { find . -type d 2>/dev/null | fzf; }

# ----------------------------
# 8. OPTIONS & FIXES
# ----------------------------
setopt autocd interactivecomments extended_glob globdots CORRECT
unsetopt nomatch

# Giữ Terminal Title sạch sẽ
case "$TERM" in
  xterm*|alacritty|kitty)
    add-zsh-hook precmd () { print -Pn "\e]0;%n@%m: %~\a" }
  ;;
esac

[[ -f ~/.aliases ]] && source ~/.aliases
