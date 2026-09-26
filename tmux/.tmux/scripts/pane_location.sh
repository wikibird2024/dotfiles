#!/usr/bin/env bash
# Folder name for the tmux pane header: "<repo>/<sub/folder>" inside a git
# repo (so the repo name stays visible after a cd), else the folder name.
# Usage: pane_location.sh <path>
root=$(git -C "$1" rev-parse --show-toplevel 2>/dev/null)
if [ -n "$root" ]; then
	printf '%s%s' "$(basename "$root")" "${1#"$root"}"
else
	basename "$1"
fi
