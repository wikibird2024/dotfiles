# ============================================================================
# MINIMAL • IDEMPOTENT • FAST BASH CONFIG (STARSHIP-READY)
# ============================================================================

# ────────────────────────────────────────────────────────────────────────────
# 0. INTERACTIVE GUARD (SAFE)
# ────────────────────────────────────────────────────────────────────────────
[[ $- != *i* ]] && return 2>/dev/null

# ────────────────────────────────────────────────────────────────────────────
# 1. CORE SHELL OPTIONS
# ────────────────────────────────────────────────────────────────────────────
shopt -s checkwinsize autocd cmdhist histappend

# ────────────────────────────────────────────────────────────────────────────
# 2. HISTORY (SAFE + NON-DUPLICATE PROMPT_COMMAND)
# ────────────────────────────────────────────────────────────────────────────
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=5000
HISTFILESIZE=10000

# Prevent PROMPT_COMMAND duplication
__history_append_cmd="history -a"
case "$PROMPT_COMMAND" in
*"$__history_append_cmd"*) ;;
*) PROMPT_COMMAND="${__history_append_cmd}${PROMPT_COMMAND:+; $PROMPT_COMMAND}" ;;
esac

# ────────────────────────────────────────────────────────────────────────────
# 3. PATH MANAGEMENT (IDEMPOTENT)
# ────────────────────────────────────────────────────────────────────────────
path_prepend() {
    case ":$PATH:" in
    *":$1:"*) ;;
    *) PATH="$1:$PATH" ;;
    esac
}

path_prepend "$HOME/.local/bin"
path_prepend "$HOME/bin"
path_prepend "/usr/local/texlive/2025/bin/x86_64-linux"
export PATH

# ────────────────────────────────────────────────────────────────────────────
# 4. ENVIRONMENT
# ────────────────────────────────────────────────────────────────────────────
export EDITOR=nvim
export VISUAL=$EDITOR

# Wayland detection (single source of truth)
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM="wayland;xcb"
    export SDL_VIDEODRIVER=wayland
    export _JAVA_AWT_WM_NONREPARENTING=1
fi

# ────────────────────────────────────────────────────────────────────────────
# 5. COMPLETION SYSTEM
# ────────────────────────────────────────────────────────────────────────────
if ! shopt -oq posix; then
    for f in \
        /usr/share/bash-completion/bash_completion \
        /etc/bash_completion; do
        [[ -f $f ]] && . "$f" && break
    done
fi

# ────────────────────────────────────────────────────────────────────────────
# 6. TOOLING (LAZY / CONDITIONAL LOAD)
# ────────────────────────────────────────────────────────────────────────────

# ZOXIDE
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi

# RUST
[[ -s "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

# NVM (LAZY LOAD — ZERO STARTUP COST)
export NVM_DIR="$HOME/.nvm"
nvm() {
    unset -f nvm node npm npx
    [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
    nvm "$@"
}

# ────────────────────────────────────────────────────────────────────────────
# 7. PROMPT (STARSHIP ONLY)
# ────────────────────────────────────────────────────────────────────────────
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

# ────────────────────────────────────────────────────────────────────────────
# 8. FZF (PORTABLE)
# ────────────────────────────────────────────────────────────────────────────
[[ -f ~/.fzf.bash ]] && . ~/.fzf.bash

# ────────────────────────────────────────────────────────────────────────────
# 9. COLORS + LS
# ────────────────────────────────────────────────────────────────────────────
if command -v dircolors >/dev/null 2>&1; then
    eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
    alias ls='ls --color=auto'
fi

# ────────────────────────────────────────────────────────────────────────────
# 10. MODULAR EXTENSIONS
# ────────────────────────────────────────────────────────────────────────────
[[ -f ~/.aliases ]] && . ~/.aliases
[[ -f ~/.functions ]] && . ~/.functions
[[ -f ~/.bash_local ]] && . ~/.bash_local
