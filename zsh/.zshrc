
# =======================================================================
# PROFESSIONAL ZSH CONFIGURATION
# Fast • Stable • Zinit-powered • P10k-ready • Clean Architecture
# =======================================================================


# -----------------------------------------------------------------------
# 0. POWERLEVEL10K INSTANT PROMPT (MUST BE FIRST)
# -----------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


# -----------------------------------------------------------------------
# PHASE 1 — BOOTSTRAP ENVIRONMENT
# -----------------------------------------------------------------------

# --- 1. Oh My Zsh core (no theme override) ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""                     # Prevent OMZ overriding P10k
DISABLE_AUTO_UPDATE="true"
DISABLE_OMZ_DIAGNOSTIC="true"

if [[ -f "$ZSH/oh-my-zsh.sh" ]]; then
  source "$ZSH/oh-my-zsh.sh"
fi


# --- 2. Zinit: Plugin Manager ---
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [[ ! -f "$ZINIT_HOME/zinit.zsh" ]]; then
  echo "Installing Zinit..."
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"


# -----------------------------------------------------------------------
# 3. Plugins: FAST & CLEAN (All FIXED)
# -----------------------------------------------------------------------

# Syntax & suggestions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# OH-MY-ZSH plugins via Zinit — FIXED
zinit snippet OMZ::plugins/sudo
zinit snippet OMZ::plugins/docker
zinit snippet OMZ::plugins/docker-compose
zinit snippet OMZ::plugins/history
zinit snippet OMZ::plugins/fzf

# Powerlevel10k — FIXED (no wait, no lucid)
zinit light romkatv/powerlevel10k


# -----------------------------------------------------------------------
# PHASE 2 — SHELL OPTIONS, PATH, ENVIRONMENT
# -----------------------------------------------------------------------

# Zsh options
setopt histignorealldups sharehistory autocd extended_glob correct \
       interactivecomments globdots

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
unsetopt nomatch

# PATH
path=(
  $HOME/bin
  $HOME/.local/bin
  /usr/local/bin
  $path
)

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Editor
export EDITOR="nvim"
export VISUAL="$EDITOR"

# Keybindings
bindkey -e   # Emacs mode


# Aliases & extra functions
for file in ~/.aliases ~/.zsh_functions ~/.bash_functions; do
  [[ -f "$file" ]] && source "$file"
done

alias zshconfig='nvim ~/.zshrc'
alias bashconfig='nvim ~/.bashrc'


# -----------------------------------------------------------------------
# PHASE 3 — POST LOAD
# -----------------------------------------------------------------------

# Zoxide (smart cd)
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# FZF integration
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# Powerlevel10k config
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# =======================================================================
# END OF FILE
# =======================================================================
