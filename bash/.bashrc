# ============================================================================
# UNIVERSAL • FAST • IDEMPOTENT BASH CONFIG
# ============================================================================

# 1. GUARDS: RECURSION & INTERACTIVE ONLY
# Prevents infinite loops and unnecessary loading for non-interactive scripts
if [ -z "$__BASHRC_LOADED" ]; then export __BASHRC_LOADED=1; else return; fi
[[ $- != *i* ]] && return 2>/dev/null

# 2. CORE SHELL OPTIONS & HISTORY
shopt -s checkwinsize autocd cmdhist histappend
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=5000
HISTFILESIZE=10000

# Prevent PROMPT_COMMAND duplication for history syncing
__history_append_cmd="history -a"
case "$PROMPT_COMMAND" in
    *"$__history_append_cmd"*) ;;
    *) PROMPT_COMMAND="${__history_append_cmd}${PROMPT_COMMAND:+; $PROMPT_COMMAND}" ;;
esac

# 3. PATH MANAGEMENT (IDEMPOTENT)
# Ensures paths aren't added multiple times if bash is re-sourced
path_prepend() {
    if [ -d "$1" ]; then
        case ":$PATH:" in
            *":$1:"*) ;;
            *) PATH="$1:$PATH" ;;
        esac
    fi
}

path_prepend "$HOME/.cargo/bin"
path_prepend "$HOME/.local/bin"
path_prepend "$HOME/bin"
path_prepend "/usr/local/texlive/2025/bin/x86_64-linux"
export PATH

# 4. ENVIRONMENT & OS DETECTION
export EDITOR=nvim
export VISUAL=$EDITOR

if [ -f /etc/os-release ]; then
    . /etc/os-release
    OS=$ID
fi

# Wayland-specific optimization
if [[ "$XDG_SESSION_TYPE" == "wayland" ]]; then
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM="wayland;xcb"
    export SDL_VIDEODRIVER=wayland
fi

# 5. COMPLETION SYSTEM
if ! shopt -oq posix; then
    for f in /usr/share/bash-completion/bash_completion /etc/bash_completion; do
        [[ -f $f ]] && . "$f" && break
    done
fi

# 6. TOOLING (ZOXIDE & STARSHIP)
command -v zoxide >/dev/null 2>&1 && eval "$(zoxide init bash)"
command -v starship >/dev/null 2>&1 && eval "$(starship init bash)"

# 7. NVM (LAZY LOAD — ZERO STARTUP DELAY)
export NVM_DIR="$HOME/.nvm"
nvm() {
    unset -f nvm node npm npx
    [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
    nvm "$@"
}

# 8. RUST & FZF
[[ -s "$HOME/.cargo/env" ]] && . "$HOME/.cargo/env"
fzf_paths=("/usr/share/fzf/key-bindings.bash" "/usr/share/doc/fzf/examples/key-bindings.bash" "$HOME/.fzf.bash")
for f in "${fzf_paths[@]}"; do [ -f "$f" ] && . "$f" && break; done

# 9. ALIASES & DISTRO CUSTOMIZATION
[[ -f ~/.aliases ]] && . ~/.aliases

case "$OS" in
    arch)                          alias pacs='sudo pacman -S' ;;
    linuxmint|ubuntu|debian)       alias apts='sudo apt install' ;;
esac

if command -v dircolors >/dev/null 2>&1; then
    eval "$(dircolors -b ~/.dircolors 2>/dev/null || dircolors -b)"
    alias ls='ls --color=auto'
fi

# 10. MODULAR EXTENSIONS
[[ -f ~/.functions ]] && . ~/.functions
[[ -f ~/.bash_local ]] && . ~/.bash_local
