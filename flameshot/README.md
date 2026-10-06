# flameshot

Settings for [Flameshot](https://flameshot.org), the screenshot tool used in GNOME, i3 and niri.
On niri the keys call `niri/.config/niri/scripts/screenshot` (Print → `flameshot gui`,
Ctrl+Print → `flameshot full`, both with `-p ~/Pictures/Screenshots`).

Stowed by `steps/04_stow.sh` (`stow -R -t ~ flameshot`). → `~/.config/flameshot/flameshot.ini`

No tray icon, files named `YYYY-MM-DD_HH-MM-SS`, no welcome screen, no "Screenshot aborted"
pop-up. `useGrimAdapter=true` makes Flameshot capture with grim on niri instead of the
desktop portal (GNOME and i3 run on X11 and ignore it).

**Version:** niri needs Flameshot **13.x** (13.3.0): Ubuntu's 12.1 was built without grim mode
and 14.0+ removed it. `steps/02_tools.sh` (`install_flameshot13`) installs the 13.3.0 deb and
holds it so `apt upgrade` keeps it. Details: `niri/README.md` "Why Flameshot 13.3".

**Note:** Flameshot rewrites `flameshot.ini` when you change a setting in its window, which
replaces the stow link with a plain file. The niri script puts the grim settings back each
time; copy other changes back to this repo by hand.
