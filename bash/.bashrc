
# ~/.bashrc — Ginko Pro Clean Edition
# Only for interactive shells
case $- in *i*) ;; *) return ;; esac

# ─── History Settings ─────────────────────────────────────────────────────────
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=5000
HISTFILESIZE=10000
shopt -s histappend
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# ─── Shell Options ───────────────────────────────────────────────────────────
shopt -s checkwinsize autocd cmdhist nocaseglob

# ─── Prompt Configuration ────────────────────────────────────────────────────
force_color_prompt=yes
if [ -n "$force_color_prompt" ] && tput setaf 1 &>/dev/null; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# ─── LS Colors & Aliases ──────────────────────────────────────────────────────
if command -v dircolors >/dev/null 2>&1; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" \
        || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
fi

# ─── Load Bash Aliases ────────────────────────────────────────────────────────
[ -f ~/.bash_aliases ] && . ~/.bash_aliases

# ─── Bash Completion Setup ───────────────────────────────────────────────────
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
    elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# ─── FZF Integration ──────────────────────────────────────────────────────────
if [ -f ~/.fzf.bash ]; then
    . ~/.fzf.bash
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
    export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'
fi

# ─── Load Custom Shell Functions (pyenv & ESP-IDF helpers) ───────────────────
if [ -f ~/.bash_functions ]; then
    . ~/.bash_functions
fi


# ─── Load Local Overrides ─────────────────────────────────────────────────────
[ -f ~/.bash_local ] && . ~/.bash_local

#------------- echo / nvm / cargo ----------------

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
. "$HOME/.cargo/env"

# Only run setterm --blength on real consoles, not GUI terminals
if [[ $(tty) == /dev/tty* ]]; then
    setterm --blength 0
fi

#------------------latexmk------------------
export PATH=/usr/local/texlive/2025/bin/x86_64-linux:$PATH
