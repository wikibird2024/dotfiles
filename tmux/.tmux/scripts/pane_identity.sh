#!/usr/bin/env bash
# Prints "user@host" for a tmux pane: the ssh target if the pane's
# foreground process is `ssh`, otherwise this machine's own user@ip.

pane_tty="$1"

ssh_args=$(ps -t "$pane_tty" -o comm=,args= 2>/dev/null | awk '$1 == "ssh" { $1=""; print }')

if [ -n "$ssh_args" ]; then
    target=""
    # ssh options that consume a following argument
    optspec="46AaCfGgKkMNnqsTtVvXxYyb:c:D:e:F:I:i:J:L:l:m:O:o:p:Q:R:S:W:w:B:E:"
    set -- $ssh_args
    OPTIND=1
    while getopts "$optspec" opt 2>/dev/null; do :; done
    shift $((OPTIND - 1))
    target="$1"

    if [ -n "$target" ]; then
        case "$target" in
            *@*) echo "$target" ;;
            *)   echo "$(whoami)@$target" ;;
        esac
        exit 0
    fi
fi

echo "$(whoami)@$(hostname -I | awk '{print $1}')"
