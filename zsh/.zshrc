
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

# Load Oh My Zsh core
if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
else
  echo "⚠️  Oh My Zsh not found at $ZSH"
fi

# --- 3. CORE ZSH OPTIONS ---
setopt histignorealldups sharehistory
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt autocd extended_glob
setopt correct        # Suggest corrections for mistyped commands
setopt interactivecomments  # Allow comments in interactive mode

# --- 4. KEYBINDINGS ---
bindkey -e   # Emacs keybindings (default)
# bindkey -v   # Uncomment for Vim-style keybindings

# --- 5. PATH & ENVIRONMENT ---
export PATH="$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH"
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR="nvim"

# --- 6. ESP-IDF ENVIRONMENT ---
# Automatically source ESP-IDF tools if available

# --- 7. TERMINAL SETTINGS ---
# Uncomment if using Alacritty or a 24-bit truecolor terminal
# export TERM="alacritty"

# --- 8. POWERLEVEL10K CONFIG ---
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# --- 9. CUSTOM ALIASES ---
alias ll='ls -lh --color=auto'
alias la='ls -lha --color=auto'
alias grep='grep --color=auto'
alias zshconfig='nvim ~/.zshrc'
alias ohmyzsh='nvim ~/.oh-my-zsh'
alias idf='cd ~/esp/esp-idf'
alias mainproj='cd ~/esp/mainproject'

# --- 10. AUTO UPDATE SETTINGS ---
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 14

# --- 11. EXTERNAL ALIASES ---
# You can keep personal aliases/functions modular in ~/.aliases.zsh
if [ -f ~/.aliases ]; then
  source ~/.aliases
fi

# --- 12. FINAL TOUCH: clear PROMPT_SP, ensure smooth startup ---
unsetopt nomatch      # Avoid errors on unmatched globs
