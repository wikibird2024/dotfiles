# niri desktop

Scrollable-tiling Wayland compositor ([niri](https://github.com/niri-wm/niri)) with the
[Noctalia](https://docs.noctalia.dev/) shell (bar, launcher, notifications, lock, wallpaper).
Built for a terminal-first embedded workflow: kitty + tmux + nvim, datasheets, KiCad, browser.

```
niri/.config/niri/
├── config.kdl              # everything: input, layout, workspaces, rules, Noctalia, binds
└── scripts/
    ├── scratchpad          # Mod+`  toggle the serial console
    ├── serial-console      # what runs inside it (picocom, auto-reconnect)
    └── focus-or-launch     # Mod+B / Mod+P  jump to an app or start it
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
| Mod + 1 | `1 term` | – (kitty/tmux/nvim; PDFs open here beside the code) |
| Mod + 2 | `2 web` | Firefox (maximized) |
| Mod + 3 | `3 design` | KiCad (eeschema, pcbnew, gerbview) |
| Mod + 4 | `4 teams` | VS Code, Teams |
| Mod + 5 | `5 scratchpad` | where the hidden serial console is parked – don't use |

niri always keeps one extra empty workspace at the end. The number is part of the
name so the bar shows `1 term · 2 web …` (Noctalia can show either id or name, not both).

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
| Mod + Q | close window |

**Apps**

| Key | Action |
|---|---|
| Mod + T / Mod + Enter | kitty |
| Mod + Space / Mod + D | app launcher |
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
| Print / Ctrl + Print / Alt + Print | screenshot region / screen / window |
| volume, brightness, media keys | work, with OSD |

**tmux project switching** ([tms](https://github.com/jrmoulton/tmux-sessionizer), config in `tmux/.config/tms/`)

| Key | Action |
|---|---|
| Ctrl + a, F | pick a git repo → switch to its session (created if missing) |
| Ctrl + a, f | switch between open sessions |

## Workflows

**Coding with a datasheet** – on `1 term`: `sioyek datasheet.pdf &` from a tmux pane. It
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

- The scratchpad runs in **foot**, not kitty: kitty sets its app id after the window
  opens, so the floating rule never matched.
- Sioyek restores its last window state (maximized); the PDF rule has
  `open-maximized false` and `open-maximized-to-edges false` to keep it at half width.
- Sioyek opens a new PDF in its existing window; `sioyek --new-window file.pdf` for more.
- Scaling: niri uses 1.25 on the laptop screen; the i3 session gets the same from
  `Xft.dpi: 120` in `Xresources/.Xresources`.

## Install on a new machine

`./bootstrap.sh` installs `niri noctalia xwayland-satellite foot picocom jq` (Arch) and stows `niri` and
`noctalia`. If niri already created `~/.config/niri`, `04_stow.sh` moves it to
`~/.config/niri.bak.*` first. Serial access needs the `uucp` group
(`sudo usermod -aG uucp $USER`).
