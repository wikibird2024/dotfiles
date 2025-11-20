
# =======================================================================
# ULTRA-FAST PROFESSIONAL ZSH CONFIGURATION
# For multi-device dotfiles • No OMZ • Zinit-powered • P10k-optimized
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
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh


# =======================================================================
# END OF FILE — Optimized for speed, portability, dotfiles use
# =======================================================================
