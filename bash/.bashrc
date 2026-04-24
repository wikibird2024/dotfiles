# ============================================================================
# UNIVERSAL • FAST • IDEMPOTENT BASH CONFIG (FIXED)
# ============================================================================

# 1. INTERACTIVE ONLY (MUST FIRST)
[[ $- != *i* ]] && return

# 2. CORE SHELL OPTIONS & HISTORY
shopt -s checkwinsize autocd cmdhist histappend

HISTCONTROL=ignoreboth:erasedups
HISTSIZE=5000
HISTFILESIZE=10000

# PROMPT_COMMAND SAFE
__history_append_cmd="history -a"
case "$PROMPT_COMMAND" in
*"$__history_append_cmd"*) ;;
*) PROMPT_COMMAND="${__history_append_cmd}${PROMPT_COMMAND:+; $PROMPT_COMMAND}" ;;
esac

# 3. PATH MANAGEMENT
path_prepend() {
    case ":$PATH:" in
    *":$1:"*) ;;
    *) [ -d "$1" ] && PATH="$1:$PATH" ;;
    esac
}

path_prepend "$HOME/.cargo/bin"
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/bin"
path_prepend "/usr/local/texlive/2025/bin/x86_64-linux"
export PATH

# 4. ENVIRONMENT
export EDITOR=nvim
export VISUAL=$EDITOR

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
fi

# Wayland (safe)
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM=wayland
    export SDL_VIDEODRIVER=wayland
fi

# 5. COMPLETION
if ! shopt -oq posix; then
    for f in /usr/share/bash-completion/bash_completion /etc/bash_completion; do
        [[ -f $f ]] && . "$f" && break
    done
fi

# 6. TOOLING
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"

# 7. NVM (SAFE LAZY)
export NVM_DIR="$HOME/.nvm"
nvm() {
    unset -f nvm node npm npx
    if [ -s "$NVM_DIR/nvm.sh" ]; then
        . "$NVM_DIR/nvm.sh"
        command nvm "$@"
    else
        echo "nvm not installed" >&2
        return 1
    fi
}

# 8. RUST & FZF
[[ -s "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"

fzf_paths=(
    "/usr/share/fzf/key-bindings.bash"
    "/usr/share/doc/fzf/examples/key-bindings.bash"
    "$HOME/.fzf.bash"
)
for f in "${fzf_paths[@]}"; do
    [ -f "$f" ] && . "$f" && break
done

# 9. ALIASES
[[ -f ~/.aliases ]] && . ~/.aliases

case "$OS" in
arch) alias pacs='sudo pacman -S' ;;
linuxmint | ubuntu | debian) alias apts='sudo apt install' ;;
esac

if command -v dircolors >/dev/null 2>&1; then
    eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
    alias ls='ls --color=auto'
fi

# 10. MODULAR EXTENSIONS
[[ -f ~/.functions ]] && . ~/.functions
[[ -f ~/.bash_local ]] && . ~/.bash_local

# 11. STARSHIP (MUST BE LAST)
if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi
