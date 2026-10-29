---
name: project-niri-pacstall-mako-dep
description: "pacstall's niri package lists mako-notifier as a hard dependency — never apt-remove mako (it removes niri); check reverse deps before any apt remove"
metadata:
  node_type: memory
  type: project
  originSessionId: 23db5329-bf73-4f21-b076-c90c84d4575a
  modified: 2026-10-09T10:41:43.802Z
---

On Ubuntu 24.04, niri comes from pacstall, and the optional packages picked at `pacstall -I niri` become hard `Depends` of the deb (now: alacritty, mako-notifier, fuzzel, waybar, swaybg, swaylock, polkit-gnome, gnome-keyring, portals). On 2026-10-09 I told the user to run `sudo apt remove -y mako-notifier` after switching to swaync; apt also removed niri, the running session survived in memory, and the next login had no niri until `pacstall -I niri` rebuilt it (which brought mako back).

**Why:** a removed package that something depends on takes that package with it; `-y` hid the "also remove niri" line.

**How to apply:** before suggesting any `apt remove`, run `apt-get -s remove <pkg>` (simulate) and show what else goes. Keep mako installed with `mako.service` masked; swaync owns notifications under niri. Related: [[project-waybar-helper-scripts]]
