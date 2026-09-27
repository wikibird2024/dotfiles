# theme

One command to switch the colors of kitty, alacritty, tmux and Neovim together, live.

Stowed by `steps/04_stow.sh` (`stow -R -t ~ theme`). → `~/.local/bin/theme`, `~/.config/theme/themes/`

```bash
theme              # list profiles, * = active
theme gruvbox      # switch everything to gruvbox
```

Profiles: `catppuccin`, `gruvbox`, `gruvbox-classic`, `onedark`, `tokyonight` (default on a new machine),
`ubuntu`. Each is a folder in `.config/theme/themes/<name>/`:

| File | Used by |
|---|---|
| `palette.conf` | kitty (included directly); alacritty's `alacritty.toml` is generated from it |
| `tmux.conf` | `@thm_*` color roles read by `~/.tmux.conf` |
| `nvim` | name of a theme in `neovim/.config/nvim/lua/system/plugins/colorscheme.lua` (optionally `name:variant`) |

The active profile is a symlink in `~/.local/state/theme/current` — outside the repo, so switching
never shows up in `git status`. New profile: copy a folder, edit the three files, `theme <new>`.
Starship and the shells use ANSI color names, so they follow automatically.
