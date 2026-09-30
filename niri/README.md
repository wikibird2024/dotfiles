# niri desktop

Scrollable-tiling Wayland compositor ([niri](https://github.com/niri-wm/niri)) with the
[Noctalia](https://docs.noctalia.dev/) shell (bar, launcher, notifications, lock, wallpaper).
Where Noctalia is not installed (Ubuntu 24.04: no package) the same keys use waybar, fuzzel,
mako and swaylock instead, see "Ubuntu (no Noctalia)".
Built for a terminal-first embedded workflow: kitty + tmux + nvim, datasheets, KiCad, browser.

```
niri/.config/niri/
├── config.kdl              # everything: input, layout, workspaces, rules, Noctalia, binds
└── scripts/
    ├── shell               # bar, launcher, panels, lock, media keys: Noctalia or apt tools
    ├── waybar-workspaces   # workspace list for waybar (Ubuntu)
    ├── scratchpad          # Mod+`  toggle the serial console
    ├── serial-console      # what runs inside it (picocom, auto-reconnect)
    └── focus-or-launch     # Mod+B / Mod+P  jump to an app or start it
niri/.config/waybar/        # bar when Noctalia is missing (Ubuntu)
niri/.config/mako/          # notifications + volume/brightness OSD when Noctalia is missing
niri/.config/sfwbar/        # auto-hiding dock on the left edge when Noctalia is missing
niri/.config/satty/         # screenshot editor settings (Print)
noctalia/.config/noctalia/
└── bar.toml                # bar tweaks (workspace names as labels)
```

`Mod` = Super (Windows key). Full list of niri keys any time: **Mod + Shift + /**.

## The layers

Each layer has its own modifier and all of them use `h j k l`:

| Layer | Handles | Keys |
|---|---|---|
| niri | GUI windows and workspaces | `Mod + …` |
| tmux | terminal sessions, windows, panes (survive closing kitty) | prefix `Ctrl + a`, panes `Alt + hjkl` |
| nvim | editing | leader `Space` |
| tmux ↔ nvim | one grid across nvim splits and tmux panes | `Ctrl + hjkl` (vim-tmux-navigator) |

Rule of thumb: terminal things (build, flash, gdb, logs) go in a **tmux pane**; graphical
things (datasheet, browser, KiCad) are **niri windows**.

## Workspaces

| Key | Name | Opens there automatically |
|---|---|---|
| Mod + 1 | `1 Browser` | Firefox (maximized) |
| Mod + 2 | `2 Dev` | – (kitty/tmux/nvim; PDFs open here beside the code) |
| Mod + 3 | `3 design` | KiCad (eeschema, pcbnew, gerbview) |
| Mod + 4 | `4 Work Apps` | VS Code, Teams |
| Mod + 5 | `5 scratchpad` | where the hidden serial console is parked – don't use |

niri always keeps one extra empty workspace at the end. The number is part of the
name so the bar shows `1 Browser · 2 Dev …` (Noctalia can show either id or name, not both).

## Keys

**Windows and workspaces**

| Key | Action |
|---|---|
| Mod + H / L | focus column left / right |
| Mod + J / K | focus window down / up in the column, else workspace down / up |
| Mod + Shift + H J K L | move window (J/K: into the next workspace at the end) |
| Mod + 1…9 | go to workspace |
| Mod + Shift + 1…9 | move column to workspace |
| Mod + R | cycle column width (1/3, 1/2, 2/3) |
| Mod + F / Mod + Shift + F | maximize column / fullscreen |
| Mod + W | tabbed column (stack datasheets, flip with J/K) |
| Mod + [ / ] | pull neighbour window into this column / push out |
| Mod + C | center column |
| Mod + Shift + T | toggle floating |
| Mod + O / Mod + Tab | overview (zoomed out) |
| mouse into top-left corner | overview (hot corner) |
| scroll on the bar's workspace list | previous / next workspace (also Mod + wheel anywhere) |
| Mod + N | show the last notification again (bar bell: left click) |
| Mod + Shift + N | clear all notifications (bell: middle click) |
| Mod + Ctrl + N | do not disturb on/off, bell shows 󰂛 (bell: right click) |
| Mod + Q | close window |

**Apps**

| Key | Action |
|---|---|
| Mod + T / Mod + Enter | kitty |
| Mod + E | file manager (Thunar, same as Super+E in GNOME), floating 60% × 70% |
| Mod + D | app launcher |
| Mod + Space | input method: English ↔ Vietnamese (fcitx5 + Bamboo), same key as GNOME |
| **Mod + B** | Firefox: jump to it (again = next window) or start it |
| **Mod + P** | datasheet (Sioyek/zathura): jump to it or start Sioyek |
| **Mod + `** | serial console scratchpad (show / hide) |

**Noctalia panels**

| Key | Action |
|---|---|
| Mod + S | control center (Wi-Fi, Bluetooth, sound, media) |
| Mod + , | settings |
| Mod + V | clipboard history |
| Mod + Y | wallpaper picker |
| Mod + X | power menu |
| Mod + Alt + L | lock (closing the lid locks and suspends) |
| Alt + Tab | window switcher |
| Print | select an area (slurp) → edit in **satty** (arrows, boxes, text); `Esc`/`Enter` copy and close, `Ctrl+S` save to `~/Pictures/Screenshots` |
| Insert / Mod + Shift + S | same as Print. Insert is what this keyboard's PrtSc key sends without Fn (GNOME uses Insert too) |
| Ctrl + Print | full screen → edit in satty (same keys) |
| Alt + Print | niri's own window screenshot |
| Mod + Shift + D | GTK apps (Thunar, file dialogs) dark ↔ light (`theme gtk`) |
| Mod + Shift + C | pick a color on screen → its `#rrggbb` is copied (niri `pick-color`) |
| volume, brightness, media keys | work, with OSD |

**tmux project switching** ([tms](https://github.com/jrmoulton/tmux-sessionizer), config in `tmux/.config/tms/`)

| Key | Action |
|---|---|
| Ctrl + a, F | pick a git repo → switch to its session (created if missing) |
| Ctrl + a, f | switch between open sessions |

## Workflows

**Coding with a datasheet** – on `2 Dev`: `sioyek datasheet.pdf &` from a tmux pane. It
opens beside kitty at half width. `Mod + H / L` switches, `/REG_NAME` searches in Sioyek,
`t` = table of contents, `Backspace` = jump back.

**Quick look at the web or datasheet** – `Mod + B` (or `Mod + P`), look, `Mod + 1` back.

**Schematic next to the code** – on `3 design` focus KiCad, `Mod + Shift + 1` brings it
beside kitty; `Mod + Shift + 3` sends it back. Or plot the schematic to PDF and open it in
Sioyek, which can search net names.

**Serial output** – `Mod + \``. Connects picocom to the first `/dev/ttyACM*` or
`/dev/ttyUSB*` at 115200 (waits if none). Hiding does not disconnect.
Inside: `Ctrl + a`, `Ctrl + x` quits picocom, then Enter reconnects or `s` gives a shell;
`Ctrl + c` while waiting gives a shell. Other speed: `BAUD=9600 ~/.config/niri/scripts/serial-console`.

**Another project** – `Ctrl + a`, `F` in tmux, type part of the repo name.

## Changing things

- Edit `config.kdl`; niri reloads it on save. Check first with `niri validate`.
  A mistake keeps the old config and shows a red notice.
- App id of a window (for rules): `niri msg windows` while it is open.
- Noctalia: the Settings window (`Mod + ,`) writes `~/.local/state/noctalia/settings.toml`,
  which is **not** tracked and **overrides** `noctalia/.config/noctalia/*.toml`.
- Renaming a workspace while niri runs creates a new empty one; move windows with
  `Mod + Shift + <n>`, or log out and back in.

## Gotchas (why some lines exist)

- **Why satty, not Flameshot:** Flameshot captures through the desktop portal, and on niri that
  failed here: 12.1 read niri's screenshot file before it was fully written ("Screenshot
  aborted" on busy screens), and 14.0 closed its overlay at once. grim + slurp + satty is what
  niri users usually run (niri discussion #1737): the picture is taken before any window opens.
  satty is built with `cargo install satty --locked` (bootstrap does it) because its release
  binary needs a newer glibc than Ubuntu 24.04.

- The scratchpad runs in **foot**, not kitty: kitty sets its app id after the window
  opens, so the floating rule never matched.
- Sioyek restores its last window state (maximized); the PDF rule has
  `open-maximized false` and `open-maximized-to-edges false` to keep it at half width.
- Sioyek opens a new PDF in its existing window; `sioyek --new-window file.pdf` for more.
- Scaling: niri uses 1.25 on the laptop screen; the i3 session gets the same from
  `Xft.dpi: 120` in `Xresources/.Xresources`.

## Ubuntu (no Noctalia)

Noctalia's apt repo only has Ubuntu 26.04 packages and a source build needs newer
sdbus-c++ / WirePlumber than 24.04 has, so on 24.04 `scripts/shell` uses apt tools.
Every key in `config.kdl` calls `scripts/shell <command>`; it runs Noctalia when
`noctalia` is on `PATH`, so installing Noctalia later (e.g. after a 26.04 upgrade) needs
no config change.

| Key | Without Noctalia |
|---|---|
| bar | waybar (workspaces, clock, tray, sound, network, battery, power); click the network pill for Wi-Fi/VPN (GNOME Settings) |
| left screen edge | dock (sfwbar): Apps, Files, Browser, Terminal, Settings, open windows, Power. Hidden until the pointer touches the edge; tooltips name the key for each button, so guests need no shortcuts |
| Mod + D | fuzzel |
| Mod + S | GNOME Settings (Wi-Fi, Bluetooth, sound) |
| Mod + , | `config.kdl` in nvim |
| Mod + V | clipboard history (cliphist + fuzzel) |
| Mod + Y | pick a wallpaper from `~/Pictures/wallpaper` (swaybg) |
| Mod + X | power menu (fuzzel): lock, log out, suspend, reboot, power off, auto shutdown on/off |
| Mod + Alt + L | swaylock; auto-lock after 5 min, screens off after 6 min (swayidle) |
| Alt + Tab | window list (fuzzel) |
| volume / brightness / media keys | wpctl / brightnessctl / playerctl, OSD from mako |

Colors follow the `theme` profile (`theme <name>` recolors the bar, launcher,
notifications, lock screen and niri's focus ring live): `scripts/shell` builds
each tool's config from its repo file (`waybar/style.css`, `mako/config`, `fuzzel/fuzzel.ini`,
`sfwbar/dock.css`) plus the palette, in `~/.cache/niri-shell/`; the focus
ring comes from `colors.kdl` there, which `config.kdl` includes (niri reloads it by itself).
Edit the repo files, never the generated ones.

Look: the wallpaper (swaybg) stays still behind the workspaces in the overview; the
launcher has a shadow and a blurred background.
Notifications are hidden from screen shares and recordings (`block-out-from "screencast"`).

**Auto shutdown** (`~/.local/bin/auto-shutdown`, from `niri/.local/bin/`): powers the PC off
when you have been away and nothing is busy. **Off by default, and off again after every
reboot**, so it only runs on the evenings you turn it on. Switch it in the **power menu
(Mod+X)**: "Auto shutdown: turn on (after 30 min idle)" / "turn off". While it is on the bar
shows a yellow `󰐥 30m`; clicking it opens the power menu.

```
auto-shutdown on [minutes]    # other idle time than the menu's 30 min
auto-shutdown off
auto-shutdown status          # on/off and what keeps the PC busy
auto-shutdown busy make -j8   # the PC stays on until this command ends
```

- Idle = no keyboard/mouse (swayidle calls it after 1 min). A playing video blocks idle.
- Busy = any `systemd-inhibit` lock on idle: `auto-shutdown busy`, every Claude Code session
  that is working (hooks `UserPromptSubmit` / `Stop` / `SessionEnd` in `~/.claude/settings.json`,
  the lock also ends when that Claude exits), or a remote (ssh) login. Busy → check again every 5 min.
- Then a notification "Shutting down in 2 min"; any key or mouse move cancels it.
- Only under niri without Noctalia (swayidle runs from `scripts/shell start`).

Ubuntu's waybar package turns `waybar.service` on for every graphical session. It
crash-loops under GNOME/X11 and would give niri a second bar, so mask it for your user:
`systemctl --user mask waybar.service` (`scripts/shell` starts waybar itself). The same
script also starts the polkit agent (`policykit-1-gnome`), since its autostart entry only
runs under XFCE/Unity/Cinnamon.

**GNOME and niri side by side.** GDM shows every installed session under the ⚙ button on
the login screen, but it hides Wayland sessions (niri) while `/etc/gdm3/custom.conf` has
`WaylandEnable=false`. Comment that line out. To keep GNOME on X11 as before, set the
default session to `ubuntu-xorg` ("Ubuntu on Xorg"); with Wayland on, plain `ubuntu`
means GNOME on Wayland. Autologin always starts the last session, so turn it off
(`AutomaticLoginEnable=False`) to choose at every login.

## Install on a new machine

`./bootstrap.sh` installs `niri noctalia xwayland-satellite foot picocom jq` (Arch), or on
Ubuntu the tools in the table above plus `foot picocom jq` (niri and xwayland-satellite come
from [pacstall](https://pacstall.dev): `pacstall -I niri xwayland-satellite`), and stows `niri` and
`noctalia`. If niri already created `~/.config/niri`, `04_stow.sh` moves it to
`~/.config/niri.bak.*` first. Serial access needs the `uucp` group
(`sudo usermod -aG uucp $USER`).
