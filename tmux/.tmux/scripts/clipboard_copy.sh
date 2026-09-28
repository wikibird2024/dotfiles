#!/usr/bin/env bash
# Copy stdin to the system clipboard with the tool that fits the current
# desktop session: wl-copy under Wayland (niri), xclip under X11 (GNOME on
# Xorg, i3). Used by tmux-yank (@override_copy_command).
# The tmux server outlives a logout, so the check runs at copy time;
# update-environment in .tmux.conf keeps WAYLAND_DISPLAY current per attach.
if [ -n "${WAYLAND_DISPLAY:-}" ] && command -v wl-copy >/dev/null; then
    exec wl-copy
elif [ -n "${DISPLAY:-}" ] && command -v xclip >/dev/null; then
    exec xclip -selection clipboard
else
    # no desktop (ssh, text console): tmux's own buffer and OSC 52 still work
    cat >/dev/null
fi
