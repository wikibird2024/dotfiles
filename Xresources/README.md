# Xresources

`.Xresources` for X11 apps: Bibata cursor (size 24), font anti-aliasing and hinting, and
**`Xft.dpi: 120`** — 1.25× scaling, the same scale niri uses on the laptop screen.

Stowed by `04_stow.sh` (separately from the main list) → `~/.Xresources`.
LightDM loads it at login; after editing run `xrdb -merge ~/.Xresources` and restart the app
(or i3 with `Mod+Shift+r`). Check: `xrdb -query | grep dpi`.
