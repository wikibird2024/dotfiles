
# =======================================================================
# PROFESSIONAL ZSH CONFIGURATION - FINALIZED
# Clean, fast, and extensible — tuned for development, Git, Docker, ESP32.
# =======================================================================

# --- 0. POWERLEVEL10K INSTANT PROMPT (Keep this block at the top) ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- 1. OH MY ZSH SETUP ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
# Disable automatic updates
DISABLE_AUTO_UPDATE="true"

# --- 2. PLUGINS ---
plugins=(
  git
  zsh-autosuggestions
  sudo
  docker
  docker-compose
  history
  fzf
  zsh-syntax-highlighting
)

# --- 3. LOAD OH MY ZSH CORE ---
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
else
  echo "⚠️ Oh My Zsh not found at $ZSH"
fi

# --- 4. CORE ZSH OPTIONS & HISTORY ---
setopt histignorealldups sharehistory autocd extended_glob correct interactivecomments globdots
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# Khắc phục lỗi globbing thất bại
unsetopt nomatch

# --- 5. KEYBINDINGS ---
bindkey -e   # Emacs keybindings (default)
# bindkey -v   # Uncomment for Vim-style keybindings

# --- 6. PATH & ENVIRONMENT ---
typeset -aU path
path=($HOME/bin $HOME/.local/bin /usr/local/bin $path)
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR="nvim"

# --- 7. ESP-IDF ENVIRONMENT ---
# Uncomment to load ESP-IDF when needed
# [ -f ~/esp/esp-idf/export.sh ] && source ~/esp/esp-idf/export.sh

# --- 8. TERMINAL SETTINGS ---
# export TERM="alacritty"

# --- 9. LOAD ALIASES & FUNCTIONS ---
if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

if [ -f ~/.zsh_functions ]; then
  source ~/.zsh_functions
fi

# --- 10. CUSTOM SHORTCUTS (ZSH-SPECIFIC) ---
alias zshconfig='nvim ~/.zshrc'
alias bashconfig='nvim ~/.bashrc'
alias ohmyzsh='nvim "$ZSH"'
alias reload='exec zsh'

# --- 11. AUTO UPDATE SETTINGS ---
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 14

# --- 12. POWERLEVEL10K CONFIG ---
# Ensure no invalid number values in ~/.p10k.zsh
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# --- 13. ZOXIDE (SMART CD REPLACEMENT - MUST BE LAST) ---
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
