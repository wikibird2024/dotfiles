
# ~/.bashrc — Ginko Pro Clean Edition
# Author: Ginko
# Purpose: Clean, modular, and environment-safe shell setup for developers.

# ──────────────────────────────────────────────────────────────────────────────
# Load only for interactive shells
# ──────────────────────────────────────────────────────────────────────────────
# The "case" statement checks if the shell is interactive (has 'i' in $-).
# This prevents the file from running when scripts are executed in non-interactive mode.
case $- in *i*) ;; *) return ;; esac


# ──────────────────────────────────────────────────────────────────────────────
# HISTORY SETTINGS
# ──────────────────────────────────────────────────────────────────────────────
# Control how command history behaves.
HISTCONTROL=ignoreboth:erasedups     # Ignore duplicates and commands starting with space
HISTSIZE=5000                        # Number of commands to keep in memory
HISTFILESIZE=10000                   # Number of commands to keep in ~/.bash_history
shopt -s histappend                  # Append history instead of overwriting
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"  # Save command immediately to history file


# ──────────────────────────────────────────────────────────────────────────────
# SHELL OPTIONS
# ──────────────────────────────────────────────────────────────────────────────
# Improve usability and navigation.
shopt -s checkwinsize autocd cmdhist nocaseglob
# - checkwinsize: auto update LINES & COLUMNS
# - autocd: allows typing a directory name to cd into it
# - cmdhist: combine multiline commands in one history entry
# - nocaseglob: case-insensitive file matching


# ──────────────────────────────────────────────────────────────────────────────
# PROMPT CONFIGURATION
# ──────────────────────────────────────────────────────────────────────────────
# Enables colored prompt if terminal supports it.
force_color_prompt=yes
if [ -n "$force_color_prompt" ] && tput setaf 1 &>/dev/null; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt


# ──────────────────────────────────────────────────────────────────────────────
# LS COLORS & BASIC ALIASES
# ──────────────────────────────────────────────────────────────────────────────
# Configure colored ls output if dircolors exists.
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
# Load your personal alias definitions if present.
[ -f ~/.bash_aliases ] && . ~/.bash_aliases


# ──────────────────────────────────────────────────────────────────────────────
# BASH COMPLETION
# ──────────────────────────────────────────────────────────────────────────────
# Load bash-completion to enable autocompletion for many commands.
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
# FZF = command-line fuzzy finder.
# These settings ensure fast, colorful, and hidden-file-capable search.
if [ -f ~/.fzf.bash ]; then
    . ~/.fzf.bash
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
fi

# ~/.bashrc hoặc ~/.bash_profile
if [[ -f /usr/share/fzf/key-bindings.bash ]]; then
    source /usr/share/fzf/key-bindings.bash
fi

if [[ -f /usr/share/fzf/completion.bash ]]; then
    source /usr/share/fzf/completion.bash
fi

# ──────────────────────────────────────────────────────────────────────────────
# Load only for interactive shells
# ──────────────────────────────────────────────────────────────────────────────
# The "case" statement checks if the shell is interactive (has 'i' in $-).
# This prevents the file from running when scripts are executed in non-interactive mode.
case $- in *i*) ;; *) return ;; esac


# ──────────────────────────────────────────────────────────────────────────────
# HISTORY SETTINGS
# ──────────────────────────────────────────────────────────────────────────────
# Control how command history behaves.
HISTCONTROL=ignoreboth:erasedups     # Ignore duplicates and commands starting with space
HISTSIZE=5000                        # Number of commands to keep in memory
HISTFILESIZE=10000                   # Number of commands to keep in ~/.bash_history
shopt -s histappend                  # Append history instead of overwriting
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"  # Save command immediately to history file


# ──────────────────────────────────────────────────────────────────────────────
# SHELL OPTIONS
# ──────────────────────────────────────────────────────────────────────────────
# Improve usability and navigation.
shopt -s checkwinsize autocd cmdhist nocaseglob
# - checkwinsize: auto update LINES & COLUMNS
# - autocd: allows typing a directory name to cd into it
# - cmdhist: combine multiline commands in one history entry
# - nocaseglob: case-insensitive file matching


# ──────────────────────────────────────────────────────────────────────────────
# PROMPT CONFIGURATION
# ──────────────────────────────────────────────────────────────────────────────
# Enables colored prompt if terminal supports it.
force_color_prompt=yes
if [ -n "$force_color_prompt" ] && tput setaf 1 &>/dev/null; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt


# ──────────────────────────────────────────────────────────────────────────────
# LS COLORS & BASIC ALIASES
# ──────────────────────────────────────────────────────────────────────────────
# Configure colored ls output if dircolors exists.
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
# Load your personal alias definitions if present.
[ -f ~/.bash_aliases ] && . ~/.bash_aliases


# ──────────────────────────────────────────────────────────────────────────────
# BASH COMPLETION
# ──────────────────────────────────────────────────────────────────────────────
# Load bash-completion to enable autocompletion for many commands.
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
# FZF = command-line fuzzy finder.
# These settings ensure fast, colorful, and hidden-file-capable search.
if [ -f ~/.fzf.bash ]; then
    . ~/.fzf.bash
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
fi


# ──────────────────────────────────────────────────────────────────────────────
# CUSTOM SHELL FUNCTIONS (pyenv, ESP-IDF helpers, etc.)
# ──────────────────────────────────────────────────────────────────────────────
# Load your own reusable bash functions (project setup, IDF shortcuts, etc.)
[ -f ~/.bash_functions ] && . ~/.bash_functions


# ──────────────────────────────────────────────────────────────────────────────
# LOCAL OVERRIDES
# ──────────────────────────────────────────────────────────────────────────────
# Load ~/.bash_local for machine-specific overrides.
# (used when multiple systems share the same dotfiles)
[ -f ~/.bash_local ] && . ~/.bash_local


# ──────────────────────────────────────────────────────────────────────────────
# NVM / CARGO INITIALIZATION
# ──────────────────────────────────────────────────────────────────────────────
# Initialize Node Version Manager and Rust Cargo environment if available.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"


# ──────────────────────────────────────────────────────────────────────────────
# TERMINAL BELL CONTROL — SAFE VERSION
# ──────────────────────────────────────────────────────────────────────────────
# "setterm --blength 0" disables the terminal bell (beep).
# However, it only works on *real console TTYs* (like /dev/tty1),
# not inside tmux, SSH, or GUI terminals.
# The following ensures it only runs where safe.
if [[ "$(tty)" =~ ^/dev/tty[0-9]+$ ]] && [[ -z "$TMUX" ]] && [[ -z "$SSH_TTY" ]]; then
    setterm --blength 0 2>/dev/null || true
fi


# ──────────────────────────────────────────────────────────────────────────────
# LATEXMK PATH (TEXLIVE)
# ──────────────────────────────────────────────────────────────────────────────
# Add LaTeX binaries to PATH for latexmk, pdflatex, etc.
export PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"


# ──────────────────────────────────────────────────────────────────────────────
# DEFAULT EDITOR
# ──────────────────────────────────────────────────────────────────────────────
# Set system-wide default text editor.
export EDITOR=vim
export VISUAL=vim


# ──────────────────────────────────────────────────────────────────────────────
# ZOXIDE — SMART CD REPLACEMENT
# ──────────────────────────────────────────────────────────────────────────────
# Zoxide learns your most used directories for faster navigation.
# Safe check ensures it doesn’t break if zoxide isn’t installed.
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# ──────────────────────────────────────────────────────────────────────────────
# CUSTOM SHELL FUNCTIONS (pyenv, ESP-IDF helpers, etc.)
# ──────────────────────────────────────────────────────────────────────────────
# Load your own reusable bash functions (project setup, IDF shortcuts, etc.)
[ -f ~/.bash_functions ] && . ~/.bash_functions


# ──────────────────────────────────────────────────────────────────────────────
# LOCAL OVERRIDES
# ──────────────────────────────────────────────────────────────────────────────
# Load ~/.bash_local for machine-specific overrides.
# (used when multiple systems share the same dotfiles)
[ -f ~/.bash_local ] && . ~/.bash_local


# ──────────────────────────────────────────────────────────────────────────────
# NVM / CARGO INITIALIZATION
# ──────────────────────────────────────────────────────────────────────────────
# Initialize Node Version Manager and Rust Cargo environment if available.
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
[ -s "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"


# ──────────────────────────────────────────────────────────────────────────────
# TERMINAL BELL CONTROL — SAFE VERSION
# ──────────────────────────────────────────────────────────────────────────────
# "setterm --blength 0" disables the terminal bell (beep).
# However, it only works on *real console TTYs* (like /dev/tty1),
# not inside tmux, SSH, or GUI terminals.
# The following ensures it only runs where safe.
if [[ "$(tty)" =~ ^/dev/tty[0-9]+$ ]] && [[ -z "$TMUX" ]] && [[ -z "$SSH_TTY" ]]; then
    setterm --blength 0 2>/dev/null || true
fi


# ──────────────────────────────────────────────────────────────────────────────
# LATEXMK PATH (TEXLIVE)
# ──────────────────────────────────────────────────────────────────────────────
# Add LaTeX binaries to PATH for latexmk, pdflatex, etc.
export PATH="/usr/local/texlive/2025/bin/x86_64-linux:$PATH"


# ──────────────────────────────────────────────────────────────────────────────
# DEFAULT EDITOR
# ──────────────────────────────────────────────────────────────────────────────
# Set system-wide default text editor.
export EDITOR=vim
export VISUAL=vim


# ──────────────────────────────────────────────────────────────────────────────
# ZOXIDE — SMART CD REPLACEMENT
# ──────────────────────────────────────────────────────────────────────────────
# Zoxide learns your most used directories for faster navigation.
# Safe check ensures it doesn’t break if zoxide isn’t installed.
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

#---------------------------------
# Thêm ~/.local/bin vào PATH nếu nó chưa có
export PATH="$HOME/.local/bin:$PATH"
