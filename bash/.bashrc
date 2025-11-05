
# ~/.bashrc — Ginko Pro Clean Edition v2
# Author: Ginko
# Purpose: Modular, environment-safe Bash setup for development (ESP32, pyenv, etc.)

# ──────────────────────────────────────────────────────────────────────────────
# Load only for interactive shells
# ──────────────────────────────────────────────────────────────────────────────
case $- in *i*) ;; *) return ;; esac

# ──────────────────────────────────────────────────────────────────────────────
# HISTORY SETTINGS
# ──────────────────────────────────────────────────────────────────────────────
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=5000
HISTFILESIZE=10000
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# ──────────────────────────────────────────────────────────────────────────────
# SHELL OPTIONS
# ──────────────────────────────────────────────────────────────────────────────
shopt -s checkwinsize autocd cmdhist nocaseglob

# ──────────────────────────────────────────────────────────────────────────────
# PROMPT CONFIGURATION
# ──────────────────────────────────────────────────────────────────────────────
force_color_prompt=yes
if [ -n "$force_color_prompt" ] && tput setaf 1 &>/dev/null; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset force_color_prompt

# ──────────────────────────────────────────────────────────────────────────────
# LS COLORS & BASIC ALIASES
# ──────────────────────────────────────────────────────────────────────────────
if command -v dircolors >/dev/null 2>&1; then
    if [ -r ~/.dircolors ]; then
        eval "$(dircolors -b ~/.dircolors)"
    else
        eval "$(dircolors -b)"
    fi
    alias ls='ls --color=auto'
fi

# ──────────────────────────────────────────────────────────────────────────────
# LOAD USER ALIASES
# ──────────────────────────────────────────────────────────────────────────────
[ -f ~/.aliases ] && . ~/.aliases

# ──────────────────────────────────────────────────────────────────────────────
# BASH COMPLETION
# ──────────────────────────────────────────────────────────────────────────────
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# ──────────────────────────────────────────────────────────────────────────────
# FZF INTEGRATION
# ──────────────────────────────────────────────────────────────────────────────
if [ -f ~/.fzf.bash ]; then
    . ~/.fzf.bash
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
fi
[[ -f /usr/share/fzf/key-bindings.bash ]] && source /usr/share/fzf/key-bindings.bash
[[ -f /usr/share/fzf/completion.bash ]] && source /usr/share/fzf/completion.bash

# ──────────────────────────────────────────────────────────────────────────────
# CUSTOM SHELL FUNCTIONS (pyenv, ESP-IDF helpers, etc.)
# ──────────────────────────────────────────────────────────────────────────────
[ -f ~/.bash_functions ] && . ~/.bash_functions

# ──────────────────────────────────────────────────────────────────────────────
# LOCAL OVERRIDES
# ──────────────────────────────────────────────────────────────────────────────
[ -f ~/.bash_local ] && . ~/.bash_local

# ──────────────────────────────────────────────────────────────────────────────
# NVM / CARGO INITIALIZATION
# ──────────────────────────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# ──────────────────────────────────────────────────────────────────────────────
# TERMINAL BELL CONTROL — SAFE VERSION
# ──────────────────────────────────────────────────────────────────────────────
if [[ "$(tty)" =~ ^/dev/tty[0-9]+$ ]] && [[ -z "$TMUX" ]] && [[ -z "$SSH_TTY" ]]; then
    setterm --blength 0 2>/dev/null || true
fi

# ──────────────────────────────────────────────────────────────────────────────
# LATEXMK PATH (TEXLIVE)
# ──────────────────────────────────────────────────────────────────────────────
export PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"

# ──────────────────────────────────────────────────────────────────────────────
# DEFAULT EDITOR
# ──────────────────────────────────────────────────────────────────────────────
export EDITOR=vim
export VISUAL=vim

# ──────────────────────────────────────────────────────────────────────────────
# ZOXIDE — SMART CD REPLACEMENT
# ──────────────────────────────────────────────────────────────────────────────
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi

# ──────────────────────────────────────────────────────────────────────────────
# ADDITIONAL PATHS
# ──────────────────────────────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$HOME/bin:$PATH"
