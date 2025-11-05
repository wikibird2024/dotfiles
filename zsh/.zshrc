
# =======================================================================
# PROFESSIONAL ZSH CONFIGURATION
# Clean, fast, and extensible — tuned for development, Git, Docker, ESP32.
# =======================================================================

# --- 0. POWERLEVEL10K INSTANT PROMPT (Keep this block at the top) ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# --- 1. OH MY ZSH SETUP ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"

# --- 2. PLUGINS ---
# NOTE: Load syntax-highlighting last for performance and correctness
plugins=(
  git
  zsh-autosuggestions
  sudo
  docker
  docker-compose
  history
  zsh-syntax-highlighting
)

# --- 3. LOAD OH MY ZSH CORE ---
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
else
  echo "⚠️  Oh My Zsh not found at $ZSH"
fi

# --- 4. CORE ZSH OPTIONS ---
setopt histignorealldups sharehistory autocd extended_glob correct interactivecomments
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history

# --- 5. KEYBINDINGS ---
bindkey -e   # Emacs keybindings (default)
# bindkey -v   # Uncomment for Vim-style keybindings

# --- 6. PATH & ENVIRONMENT ---
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR="nvim"

# --- 7. ESP-IDF ENVIRONMENT ---
# Automatically source ESP-IDF tools if available
# [ -f ~/esp/esp-idf/export.sh ] && source ~/esp/esp-idf/export.sh

# --- 8. TERMINAL SETTINGS ---
# export TERM="alacritty"  # Uncomment for truecolor terminals

# --- 9. SHARED ALIASES (COMMON WITH BASH) ---
# Maintain all aliases in ~/.aliases to share across Bash and Zsh
if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

# --- 10. CUSTOM SHORTCUTS (SHELL-SPECIFIC) ---
alias zshconfig='nvim ~/.zshrc'
alias bashconfig='nvim ~/.bashrc'
alias ohmyzsh='nvim ~/.oh-my-zsh'
alias reload='exec zsh'

# --- 11. AUTO UPDATE SETTINGS ---
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 14

# --- 12. POWERLEVEL10K CONFIG ---
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# --- 13. FINAL TOUCH ---
unsetopt nomatch  # Avoid errors on unmatched globs
