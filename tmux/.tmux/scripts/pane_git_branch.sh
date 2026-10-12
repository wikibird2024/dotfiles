#!/usr/bin/env bash
# Git branch piece for the tmux pane header: " <branch>" (the header picks
# its color), or nothing outside a repo. Usage: pane_git_branch.sh <path>
branch=$(git -C "$1" branch --show-current 2>/dev/null)
[ -n "$branch" ] && printf ' %s' "$branch"
