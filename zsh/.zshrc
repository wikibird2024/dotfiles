
# =======================================================================
# PROFESSIONAL ZSH CONFIGURATION - PORTABLE & CLEAN
# Fast • Stable • Zinit-powered • P10k-ready • Dotfile-friendly
# =======================================================================

# -----------------------------------------------------------------------
# 0. POWERLEVEL10K INSTANT PROMPT (MUST BE FIRST)
# -----------------------------------------------------------------------
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -----------------------------------------------------------------------
# PHASE 1 — BOOTSTRAP ENVIRONMENT
# -----------------------------------------------------------------------
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
DISABLE_AUTO_UPDATE="true"
DISABLE_OMZ_DIAGNOSTIC="true"
[[ -f "$ZSH/oh-my-zsh.sh" ]] && source "$ZSH/oh-my-zsh.sh"

# Zinit Plugin Manager
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"
[[ ! -f "$ZINIT_HOME/zinit.zsh" ]] && {
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
}
source "$ZINIT_HOME/zinit.zsh"

# -----------------------------------------------------------------------
# PHASE 2 — UNSET POTENTIAL CONFLICTING ALIASES
# -----------------------------------------------------------------------
# Unset alias `zi` (FZF, user aliases, etc.) để không xung đột với function
unalias zi 2>/dev/null
# Thêm nếu cần unset alias phổ biến xung đột khác
unalias zshconfig 2>/dev/null
unalias bashconfig 2>/dev/null

# -----------------------------------------------------------------------
# PHASE 3 — LOAD USER ALIASES & FUNCTIONS
# -----------------------------------------------------------------------
for file in ~/.aliases ~/.zsh_functions ~/.bash_functions; do
    [[ -f "$file" ]] && source "$file"
done

# -----------------------------------------------------------------------
# PHASE 4 — LOAD PLUGINS
# -----------------------------------------------------------------------
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit snippet OMZ::plugins/sudo
zinit snippet OMZ::plugins/docker
zinit snippet OMZ::plugins/docker-compose
zinit snippet OMZ::plugins/history
zinit snippet OMZ::plugins/fzf
zinit light romkatv/powerlevel10k
zinit light zsh-users/zsh-completions

# -----------------------------------------------------------------------
# PHASE 5 — SHELL OPTIONS & ENVIRONMENT
# -----------------------------------------------------------------------
setopt histignorealldups sharehistory autocd extended_glob correct interactivecomments globdots
HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"
unsetopt nomatch

path=(
    $HOME/bin
    $HOME/.local/bin
    /usr/local/bin
    $path
)

export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR="nvim"
export VISUAL="$EDITOR"
bindkey -e

# -----------------------------------------------------------------------
# PHASE 6 — POST LOAD
# -----------------------------------------------------------------------
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init zsh)"
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# =======================================================================
# END OF FILE
# =======================================================================
