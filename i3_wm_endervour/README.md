# i3_wm_endervour

[i3](https://i3wm.org) X11 session (based on EndeavourOS's i3 setup), with i3status-rust bar,
picom, dunst, rofi. The niri session is in `niri/`.

Stowed by `steps/04_stow.sh` (`stow -R -t ~ i3_wm_endervour`). → `~/.config/i3/`, `~/.config/i3status-rust/`, `~/.config/autostart/`

| Path | Contents |
|---|---|
| `.config/i3/config` | entry point: variables, workspace names, includes the files below |
| `conf.d/theme.conf` | fonts (titles 11, bar 11), borders, gaps, colors, bar |
| `conf.d/keys.conf` | all keybindings and resize mode |
| `conf.d/rules.conf` | workspace assignments, floating windows |
| `conf.d/autostart.conf` | programs started at login (picom, dunst, flameshot, polkit, xss-lock...) |
| `local.conf.example` | per-machine settings (monitors, wallpaper) — copy to `local.conf`, which is git-ignored |
| `scripts/` | bar blocks and helpers: volume, battery, cpu, powermenu, blur-lock, keyhint... |
| `i3blocks.conf` | fallback bar where i3status-rust is not packaged (Debian/Ubuntu) |
| `.config/i3status-rust/config.toml` | the main bar |
| `.config/autostart/` | nm-applet, blueman tray icons |

Workflow: edit → `i3 -C` (check) → `Mod+Shift+c` (reload), or `Mod+Shift+r` for bar/exec changes.
Window class for rules: `xprop | grep WM_CLASS`.

**Clean-up candidate:** `keybindings` looks unused since `conf.d/keys.conf`.
