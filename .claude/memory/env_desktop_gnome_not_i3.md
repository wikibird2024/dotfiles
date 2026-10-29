---
name: env-desktop-gnome-not-i3
description: "User runs Ubuntu 24.04 with GNOME (X11) and niri (Wayland) side by side, never i3; check XDG_CURRENT_DESKTOP each time before WM-level fixes."
metadata: 
  node_type: memory
  type: user
  originSessionId: 9b9226b6-26bc-4986-ba44-7db6e7721660
---

The dotfiles repo includes an `i3_wm_endervour` stow package with i3 config, but the user's actual active session (verified via `XDG_CURRENT_DESKTOP=ubuntu:GNOME`, `gnome-shell`/`mutter-x11-frames` processes) is stock Ubuntu GNOME, not i3.

**Why:** Diagnosed a "lost window border" bug in Alacritty by editing i3's `hide_edge_borders` setting first, which turned out to be inactive/irrelevant — the real cause was GNOME/Mutter fully honoring Alacritty's `decorations = "none"` hint (Mutter has no independent WM-drawn border like i3's `default_border`, and Linux Alacritty only supports `"full"`/`"none"`, no middle ground).

**How to apply:** Before diagnosing window-manager-level behavior (borders, decorations, gaps, window rules, keybindings routed through the WM), confirm which WM/DE is actually active rather than assuming from which stow packages exist in the repo. Check with `echo $XDG_CURRENT_DESKTOP` or `ps -e | grep -E "i3|gnome-shell|mutter"`. i3 config changes only take effect if the user later switches their session to i3.

Update 2026-09-29: the user now also logs into **niri** (Wayland, same machine, picked at GDM) and uses it day to day; GNOME/X11 is still installed. Processes started under one session (tmux server, apps launched before a niri config change) keep that session's environment, e.g. Firefox kept `GTK_IM_MODULE=ibus` and could not type Vietnamese until restarted. When an app misbehaves only in niri, compare `/proc/<pid>/environ` with niri's `environment {}` block first.
