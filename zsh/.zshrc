
# =======================================================================
# ULTRA-FAST PROFESSIONAL ZSH CONFIGURATION
# Multi-device • No OMZ • Zinit-powered • P10k-optimized • Clean & Stable
# =======================================================================

# -----------------------------------------------------------------------
# 0. POWERLEVEL10K INSTANT PROMPT (MUST BE FIRST)
# -----------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -----------------------------------------------------------------------
# 1. BASE ENVIRONMENT
# -----------------------------------------------------------------------
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR="nvim"
export VISUAL="$EDITOR"

# PATH CLEAN
path=(
    $HOME/bin
    $HOME/.local/bin
    /usr/local/bin
    $path
)

# -----------------------------------------------------------------------
# 2. ZINIT — PLUGIN MANAGER
# -----------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

if [[ ! -f "$ZINIT_HOME/zinit.zsh" ]]; then
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone --depth 1 https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"

# -----------------------------------------------------------------------
# 3. LOAD CORE PLUGINS (STABLE & FAST)
# -----------------------------------------------------------------------
# Powerlevel10k
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Zsh enhancements
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-history-substring-search

# -----------------------------------------------------------------------
# 4. FZF & fzf-tab (LOAD ORDER FIX)
# -----------------------------------------------------------------------
# 4a. FZF core
if [ -f ~/.fzf.zsh ]; then
    source ~/.fzf.zsh      # load keybindings, widget, completion
fi

# 4b. fzf-tab must load AFTER fzf
zinit light Aloxaf/fzf-tab

# FZF defaults
if command -v fzf >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# -----------------------------------------------------------------------
# 5. COMPLETION SYSTEM INIT
# -----------------------------------------------------------------------
autoload -Uz compinit
compinit -u   # ignore broken cache

# -----------------------------------------------------------------------
# 6. SHELL OPTIONS & HISTORY
# -----------------------------------------------------------------------
setopt autocd
setopt interactivecomments
setopt histignorealldups sharehistory
setopt globdots extended_glob
unsetopt nomatch

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"

# -----------------------------------------------------------------------
# 7. CUSTOM ALIASES & FUNCTIONS
# -----------------------------------------------------------------------
for file in ~/.aliases ~/.alias ~/.zsh_aliases ~/.zsh_functions ~/.functions; do
    [[ -f "$file" ]] && source "$file"
done

# -----------------------------------------------------------------------
# 8. ZOXIDE INTEGRATION
# -----------------------------------------------------------------------
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# -----------------------------------------------------------------------
# 9. KEYBINDINGS (EMACS STYLE DEFAULT)
# -----------------------------------------------------------------------
bindkey -e

# History search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# FZF keybindings are loaded via ~/.fzf.zsh

# -----------------------------------------------------------------------
# 10. POWERLEVEL10K CONFIG
# -----------------------------------------------------------------------
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# -----------------------------------------------------------------------
# 11. TMUX AUTOLOAD (SAFE & FZF-INTEGRATED)
# -----------------------------------------------------------------------
if command -v tmux >/dev/null 2>&1; then
    if [[ -z "$TMUX" && -n "$PS1" ]]; then
        sessions=$(tmux ls 2>/dev/null | cut -d: -f1)
        count=$(echo "$sessions" | wc -l)
        if [[ "$count" -le 1 ]]; then
            tmux new-session -A -s main
        else
            chosen=$(echo "$sessions" | fzf --prompt="tmux session > ")
            if [ -n "$chosen" ]; then
                tmux attach -t "$chosen"
            else
                tmux new-session -A -s main
            fi
        fi
    fi
fi

# -----------------------------------------------------------------------
# 12. SAFE P10K WARNINGS SUPPRESSION
# -----------------------------------------------------------------------
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# =======================================================================
# END OF FILE — Modular, Stable, Fast, Multi-device
# =======================================================================
