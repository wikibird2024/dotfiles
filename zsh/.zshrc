

# =======================================================================
<<<<<<< HEAD
# ULTRA-FAST PROFESSIONAL ZSH CONFIGURATION
# For multi-device dotfiles • No OMZ • Zinit-powered • P10k-optimized
=======
# PROFESSIONAL ZSH CONFIGURATION - PORTABLE & CLEAN
# Fast • Stable • Zinit-powered • P10k-ready • Dotfile-friendly
>>>>>>> 5a6b8f4cb26924c132ed8a62a2167cab4492cf1e
# =======================================================================

# -----------------------------------------------------------------------
# 0. POWERLEVEL10K INSTANT PROMPT (MUST BE FIRST)
# -----------------------------------------------------------------------
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -----------------------------------------------------------------------
# 1. BASE ENVIRONMENT
# -----------------------------------------------------------------------
<<<<<<< HEAD
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR="nvim"
export VISUAL="$EDITOR"

# Clean PATH setup
=======
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

>>>>>>> 5a6b8f4cb26924c132ed8a62a2167cab4492cf1e
path=(
    $HOME/bin
    $HOME/.local/bin
    /usr/local/bin
    $path
)

<<<<<<< HEAD

# -----------------------------------------------------------------------
# 2. ZINIT — PLUGIN MANAGER
# -----------------------------------------------------------------------
ZINIT_HOME="${XDG_DATA_HOME:-$HOME/.local/share}/zinit/zinit.git"

# Auto-install if missing (new device friendly)
if [[ ! -f "$ZINIT_HOME/zinit.zsh" ]]; then
    echo "[Zinit] Installing..."
    mkdir -p "$(dirname "$ZINIT_HOME")"
    git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

source "$ZINIT_HOME/zinit.zsh"


# -----------------------------------------------------------------------
# 3. ESSENTIAL PLUGINS (FAST • STABLE • MUST-HAVE)
# -----------------------------------------------------------------------

# Powerlevel10k (must load early; no wait!)
zinit ice depth=1
zinit light romkatv/powerlevel10k

# Completion system extended
zinit light zsh-users/zsh-completions

# Suggestions & syntax highlight
zinit light zsh-users/zsh-autosuggestions
zinit light zsh-users/zsh-syntax-highlighting

# Better completion UI (FZF-like)
zinit light Aloxaf/fzf-tab

# History substring search (fast search ↑↓)
zinit light zsh-users/zsh-history-substring-search


# -----------------------------------------------------------------------
# 4. SHELL OPTIONS & BEHAVIOR
# -----------------------------------------------------------------------
setopt autocd
setopt interactivecomments
setopt histignorealldups sharehistory
setopt globdots extended_glob

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"

unsetopt nomatch


# -----------------------------------------------------------------------
# 5. INCLUDE CUSTOM ALIASES & FUNCTIONS (DOTFILES)
# -----------------------------------------------------------------------
# Bạn đã lưu alias + function trong file riêng → chỉ include

for file in ~/.aliases ~/.alias ~/.zsh_aliases ~/.zsh_functions ~/.functions; do
    [[ -f "$file" ]] && source "$file"
done


# -----------------------------------------------------------------------
# 6. OPTIONAL TOOLS (LIGHT INTEGRATION ONLY)
# -----------------------------------------------------------------------

# Zoxide (smart cd) — fast, no overhead
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# fzf integration (if installed system-wide)
if command -v fzf >/dev/null 2>&1; then
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
fi


# -----------------------------------------------------------------------
# 7. KEYBINDINGS
# -----------------------------------------------------------------------
bindkey -e      # Emacs-style
# bindkey -v    # Vim-style (tùy chọn)

# History substring search keys
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down


# -----------------------------------------------------------------------
# 8. POWERLEVEL10K CONFIG
# -----------------------------------------------------------------------
=======
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
>>>>>>> 5a6b8f4cb26924c132ed8a62a2167cab4492cf1e
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


# =======================================================================
# END OF FILE — Optimized for speed, portability, dotfiles use
# =======================================================================
