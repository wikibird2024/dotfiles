# =======================================================================
# ULTRA-FAST PROFESSIONAL ZSH CONFIGURATION (REFACTORED)
# Zinit-powered • P10k-optimized • Enhanced Usability
# =======================================================================

# -----------------------------------------------------------------------
# 0. POWERLEVEL10K INSTANT PROMPT (MUST BE FIRST)
# -----------------------------------------------------------------------
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# -----------------------------------------------------------------------
# 1. BASE ENVIRONMENT & PATH
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
    source ~/.fzf.zsh       # load keybindings, widget, completion
fi

# 4b. fzf-tab must load AFTER fzf
zinit light Aloxaf/fzf-tab

# FZF defaults
if command -v fzf >/dev/null 2>&1; then
    # Sử dụng fd (fastfind) thay thế find
    export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
    export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# -----------------------------------------------------------------------
# 5. COMPLETION SYSTEM INIT (Thêm list-colors từ config cũ)
# -----------------------------------------------------------------------
autoload -Uz compinit
compinit -u      # ignore broken cache

# Tận dụng list-colors từ cấu hình cũ (nếu LS_COLORS được thiết lập)
if [ -n "$LS_COLORS" ]; then
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

# -----------------------------------------------------------------------
# 6. SHELL OPTIONS & HISTORY (Tận dụng hist_verify, numericglobsort)
# -----------------------------------------------------------------------
setopt autocd
setopt interactivecomments
setopt histignorealldups sharehistory
setopt globdots extended_glob
unsetopt nomatch

# Tận dụng các tùy chọn tinh chỉnh từ cấu hình cũ
setopt numericglobsort
setopt hist_verify        # show command with history expansion to user before running it

HISTSIZE=10000
SAVEHIST=10000
HISTFILE="$HOME/.zsh_history"

# Cấu hình định dạng TIME (Tận dụng từ cấu hình cũ)
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# -----------------------------------------------------------------------
# 7. ZOXIDE INTEGRATION
# -----------------------------------------------------------------------
if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

# -----------------------------------------------------------------------
# 8. TÙY CHỈNH HIỂN THỊ (COLORS, LESS, LS)
# -----------------------------------------------------------------------
# Kích hoạt dircolors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    # Tận dụng fix ls color cho folders với 777 permissions từ cấu hình cũ
    export LS_COLORS="$LS_COLORS:ow=30;44:"
fi

# Tận dụng màu sắc cho LESS (man pages, file lớn) từ cấu hình cũ
export LESS_TERMCAP_mb=$'\E[1;31m'       # begin blink
export LESS_TERMCAP_md=$'\E[1;36m'       # begin bold
export LESS_TERMCAP_me=$'\E[0m'          # reset bold/blink
export LESS_TERMCAP_so=$'\E[01;33m'      # begin reverse video
export LESS_TERMCAP_se=$'\E[0m'          # reset reverse video
export LESS_TERMCAP_us=$'\E[1;32m'       # begin underline
export LESS_TERMCAP_ue=$'\E[0m'          # reset underline

# Cài đặt tiêu đề Terminal (Tận dụng từ cấu hình cũ)
case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty)
    TERM_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%n@%m: %~\a'
    ;;
*)
    ;;
esac

# Tận dụng logic precmd để in tiêu đề và thêm dòng trống (Giúp giao diện sạch hơn)
NEWLINE_BEFORE_PROMPT=yes # Biến tận dụng từ cấu hình Kali cũ
precmd() {
    # Print the previously configured title
    print -Pnr -- "$TERM_TITLE"

    # Print a new line before the prompt, but only if it is not the first line
    if [ "$NEWLINE_BEFORE_PROMPT" = yes ]; then
        if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
            _NEW_LINE_BEFORE_PROMPT=1
        else
            print ""
        fi
    fi
}


# -----------------------------------------------------------------------
# 9. KEYBINDINGS (EMACS STYLE DEFAULT + CUSTOM ENHANCEMENTS)
# -----------------------------------------------------------------------
bindkey -e

# Tận dụng các phím tắt chi tiết từ cấu hình cũ
bindkey ' ' magic-space                          # do history expansion on space
bindkey '^U' backward-kill-line                  # ctrl + U: delete to beginning of line
bindkey '^[[3;5~' kill-word                      # ctrl + Supr: delete next word
bindkey '^[[3~' delete-char                      # delete
bindkey '^[[1;5C' forward-word                   # ctrl + ->
bindkey '^[[1;5D' backward-word                  # ctrl + <-
bindkey '^[[H' beginning-of-line                 # home
bindkey '^[[F' end-of-line                       # end
bindkey '^[[Z' undo                              # shift + tab undo last action

# History search (Cần phải đặt sau các phím tắt custom)
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# FZF keybindings are loaded via ~/.fzf.zsh

# -----------------------------------------------------------------------
# 10. CUSTOM ALIASES & FUNCTIONS
# -----------------------------------------------------------------------
for file in ~/.aliases ~/.alias ~/.zsh_aliases ~/.zsh_functions ~/.functions; do
    [[ -f "$file" ]] && source "$file"
done

# Tận dụng các alias ls cơ bản từ cấu hình cũ
alias ll='ls -l'
alias la='ls -A'
alias l='ls -CF'

# -----------------------------------------------------------------------
# 11. POWERLEVEL10K CONFIG
# -----------------------------------------------------------------------
[[ -f ~/.p10k.zsh ]] && source ~/.p10k.zsh

# -----------------------------------------------------------------------
# 12. TMUX AUTOLOAD (SAFE & FZF-INTEGRATED)
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
# 13. SAFE P10K WARNINGS SUPPRESSION
# -----------------------------------------------------------------------
typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

# =======================================================================
# END OF FILE
# =======================================================================
