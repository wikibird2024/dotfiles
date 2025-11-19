
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

# --- 1. Oh My Zsh core (không dùng theme của OMZ) ---
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""                       # Ngăn OMZ override Powerlevel10k
DISABLE_AUTO_UPDATE="true"
DISABLE_OMZ_DIAGNOSTIC="true"

if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  source "$ZSH/oh-my-zsh.sh"
fi


# --- 2. Zinit: Plugin Manager (install once, else skip) ---
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [[ ! -f "$ZINIT_HOME/zinit.zsh" ]]; then
  echo "Installing Zinit..."
  mkdir -p "$(dirname "$ZINIT_HOME")"
  git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"


# --- 3. Plugins: clean & fast ---
# Syntax & suggestions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# OMZ plugins via Zinit (plugin = pure script, no overhead)
zinit light "$ZSH/plugins/sudo"
zinit light "$ZSH/plugins/docker"
zinit light "$ZSH/plugins/docker-compose"
zinit light "$ZSH/plugins/history"
zinit light "$ZSH/plugins/fzf"

# Powerlevel10k
zinit ice wait lucid
zinit light romkatv/powerlevel10k


# -----------------------------------------------------------------------
# PHASE 2 — SHELL OPTIONS, PATH, ENVIRONMENT
# -----------------------------------------------------------------------

# --- 4. Core Zsh Options ---
setopt histignorealldups sharehistory autocd extended_glob correct \
       interactivecomments globdots

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"

unsetopt nomatch              # Không báo lỗi globbing rỗng


# --- 5. PATH ---
path=(
  $HOME/bin
  $HOME/.local/bin
  /usr/local/bin
  $path
)

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8


# --- 6. Editor ---
export EDITOR="nvim"
export VISUAL="$EDITOR"


# --- 7. Keybindings ---
bindkey -e       # Emacs-mode (default)
# bindkey -v     # Uncomment nếu muốn Vim-style


# --- 8. Custom Aliases & Functions ---
for file in ~/.aliases ~/.zsh_functions ~/.bash_functions; do
  [ -f "$file" ] && source "$file"
done

alias zshconfig='nvim ~/.zshrc'
alias bashconfig='nvim ~/.bashrc'


# --- 9. ESP-IDF / Extra Tools (tùy chọn) ---
# [ -f ~/esp/esp-idf/export.sh ] && source ~/esp/esp-idf/export.sh
# export TERM="alacritty"


# -----------------------------------------------------------------------
# PHASE 3 — POST-LOAD (Require plugins already loaded)
# -----------------------------------------------------------------------

# --- 10. Zoxide (smart cd) ---
if command -v zoxide >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# --- 11. FZF Integration ---
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --- 12. Powerlevel10k Config ---
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# =======================================================================
# END OF FILE
# =======================================================================
