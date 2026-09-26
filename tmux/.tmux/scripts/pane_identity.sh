#!/usr/bin/env bash
# Prints "user@ip" of this machine for the tmux status bar. The ssh target of
# a pane is shown separately by pane_ssh_target.sh.

echo "$(whoami)@$(hostname -I | awk '{print $1}')"
