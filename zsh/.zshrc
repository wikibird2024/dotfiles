

# =======================================================================
# ULTRA-FAST PROFESSIONAL ZSH CONFIGURATION
# Multi-device • No OMZ • Zinit-powered • P10k-optimized
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

# Clean PATH setup
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
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
    # Không echo gì ra để tránh P10k instant prompt warning
fi

source "$ZINIT_HOME/zinit.zsh"

# -----------------------------------------------------------------------
# 3. LOAD PLUGINS (FAST & STABLE)
# -----------------------------------------------------------------------
zinit ice depth=1
zinit light romkatv/powerlevel10k           # Powerlevel10k (theme)

zinit light zsh-users/zsh-completions       # Extended completions
zinit light zsh-users/zsh-autosuggestions   # Command suggestions
zinit light zsh-users/zsh-syntax-highlighting  # Syntax highlighting
zinit light Aloxaf/fzf-tab                  # Better tab completion
zinit light zsh-users/zsh-history-substring-search  # ↑↓ search

# -----------------------------------------------------------------------
# 4. COMPLINIT — INIT COMPLETION SYSTEM
# -----------------------------------------------------------------------
autoload -Uz compinit
compinit -u   # bỏ qua cache hỏng
# Xóa compdump nếu muốn đảm bảo hoàn toàn sạch: rm -f ~/.zcompdump*

# -----------------------------------------------------------------------
# 5. SHELL OPTIONS & HISTORY
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
# 6. INCLUDE CUSTOM ALIASES & FUNCTIONS (DOTFILES)
# -----------------------------------------------------------------------
for file in ~/.aliases ~/.alias ~/.zsh_aliases ~/.zsh_functions ~/.functions; do
    [[ -f "$file" ]] && source "$file"
done

# -----------------------------------------------------------------------
# 7. ZOXIDE & FZF INTEGRATION
# -----------------------------------------------------------------------
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

if command -v fzf >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
fi

# -----------------------------------------------------------------------
# 8. KEYBINDINGS
# -----------------------------------------------------------------------
bindkey -e   # Emacs-style
# bindkey -v # Vim-style nếu muốn

bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# -----------------------------------------------------------------------
# 9. POWERLEVEL10K CONFIG
# -----------------------------------------------------------------------
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# -----------------------------------------------------------------------
# 10. AUTO LOAD TMUX
# -----------------------------------------------------------------------
if command -v tmux >/dev/null 2>&1; then
    if [[ -z "$TMUX" && -n "$PS1" ]]; then
        sessions=$(tmux ls 2>/dev/null | cut -d: -f1)
        count=$(echo "$sessions" | wc -l)
        if [[ "$count" -le 1 ]]; then
            tmux new-session -A -s main
        else
            chosen=$(echo "$sessions" | fzf --prompt="tmux session > ")
            [ -n "$chosen" ] && tmux attach -t "$chosen" || tmux new-session -A -s main
        fi
    fi
fi

# -----------------------------------------------------------------------
# 11. INSTANT PROMPT WARNINGS FIX
# -----------------------------------------------------------------------
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet   # tắt cảnh báo console output

# =======================================================================
# END OF FILE — Optimized for speed, portability, dotfiles-ready
# =======================================================================
