#!/usr/bin/env bash
# Git branch piece for the tmux pane header: " <branch>", or nothing
# outside a repo. Usage: pane_git_branch.sh <path>
branch=$(git -C "$1" branch --show-current 2>/dev/null)
[ -n "$branch" ] && printf '#[fg=#9ece6a] %s' "$branch"
