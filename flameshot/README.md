# flameshot

Settings for [Flameshot](https://flameshot.org), the screenshot tool used in the i3 session
and the niri session (Print → `flameshot gui`, Ctrl+Print → `flameshot full`, bound in
`niri/.config/niri/config.kdl`). On niri it captures through the desktop portal — see the
screenshot note in `niri/README.md` if it hangs.

Stowed by `steps/04_stow.sh` (`stow -R -t ~ flameshot`). → `~/.config/flameshot/flameshot.ini`

No tray icon, files named `YYYY-MM-DD_HH-MM-SS`, copy to clipboard after saving, no welcome screen.

**Note:** `savePath=/home/user/Pictures/Screenshots` uses a placeholder user name. The niri binds
pass `-p ~/Pictures/Screenshots` so they don't depend on it; fix it if you save from other places.
