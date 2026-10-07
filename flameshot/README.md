# flameshot

Settings for [Flameshot](https://flameshot.org), the screenshot tool in GNOME, i3 (X11) and
niri. On niri, Print runs `niri/.config/niri/scripts/screenshot`: Flameshot copies
(`flameshot gui --raw` → `wl-copy`, finished with Enter). Saving on niri is niri's own
screenshot tool (Mod+Insert). It needs Flameshot **13.3** (grim mode), installed and held by
`steps/02_tools.sh` — see `niri/README.md` "Flameshot on niri".

Stowed by `steps/04_stow.sh` (`stow -R -t ~ flameshot`). → `~/.config/flameshot/flameshot.ini`

No tray icon, files named `YYYY-MM-DD_HH-MM-SS`, no welcome screen, no "Screenshot aborted"
pop-up. `useGrimAdapter=true` makes it capture with grim on niri (ignored on X11).

**Note:** Flameshot rewrites `flameshot.ini` when you change a setting in its window, which
replaces the stow link with a plain file. Copy changes you want to keep back to this repo
by hand, then `stow -R -t ~ flameshot`.
