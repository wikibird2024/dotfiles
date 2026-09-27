# kitty

Config for [kitty](https://sw.kovidgoyal.net/kitty/), the main terminal.

Stowed by `steps/04_stow.sh` (`stow -R -t ~ kitty`). → `~/.config/kitty/`

| File | Contents |
|---|---|
| `kitty.conf` | fonts (JetBrainsMono NF 10), padding, scrollback 20000, no bell, remote control via socket (used by `theme`) |
| `theme.conf` | base colors, loaded first |
| `keybindings.conf` | placeholder — no custom keys (tmux and Neovim handle splits and navigation) |

The active colors come from `~/.local/state/theme/current/palette.conf` (included after
`theme.conf`), so `theme <name>` recolors every open kitty window live. See `theme/README.md`.
Reload by hand: `Ctrl+Shift+F5`.
