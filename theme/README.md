# theme

One command to switch the colors of kitty, alacritty, tmux and Neovim together, live
(no restarts). Starship follows by itself.

Stowed by `steps/04_stow.sh` → `~/.local/bin/theme`, `~/.config/theme/themes/`.
A new machine starts on the `ubuntu` profile; after that your choice is kept.

## Use

```bash
theme                       # list profiles, * = active
theme gruvbox-classic       # switch everything to that profile
theme pick                  # choose with fzf + color preview   (in tmux: prefix + T)
theme new mytheme [from]    # new profile as a copy of [from] (default: the active one)
theme check                 # find mistakes in every profile
theme --help
```

## Profiles

| Profile | Terminal | Neovim | Notes |
|---|---|---|---|
| `ubuntu` | aubergine `#300a24` | `onedark` | the original kitty colors — default |
| `gruvbox-classic` | `#282828`, green cursor | `gruvbox:medium` | the original alacritty colors |
| `catppuccin` | `#1e1e2e` | `catppuccin` | |
| `onedark` | `#1f2329` | `onedark` | |
| `apple` | Xcode dark `#292a30` | `xcode` (xcodedark) | macOS dark-mode system colors |
| `rose-pine` | `#191724` | `rose_pine:main` | dusty rose, gold, lavender; foam stands in for green |

## How it works

```
~/.config/theme/themes/<name>/      ← profiles (in this repo)
    palette.conf   terminal colors, kitty syntax
    tmux.conf      @thm_* color roles for the tmux bar
    nvim           theme name from colorscheme.lua, optional variant ("gruvbox:medium")

~/.local/state/theme/               ← runtime state, outside the repo (switching leaves no git diff)
    current        → symlink to the active profile folder
    alacritty.toml   generated from current/palette.conf
```

| Tool | Reads | How a switch reaches running windows |
|---|---|---|
| kitty | `current/palette.conf` (included after `kitty/theme.conf`) | `kitty @ set-colors` on every kitty socket |
| alacritty | generated `alacritty.toml`, imported after `colors-fallback.toml` | touches its config → live reload |
| tmux | `current/tmux.conf`; `.tmux.conf` styles use `#{@thm_*}` roles | `tmux source-file` |
| Neovim | `current/nvim` → key in `neovim/.config/nvim/lua/system/plugins/colorscheme.lua` | `SIGUSR1` → reloads the theme |
| lualine | the colorscheme's colors | rebuilds on the `ColorScheme` event |
| starship | nothing — uses ANSI color names | follows the terminal palette |

## Fallbacks — nothing breaks

Every profile file is optional, and every tool keeps its own colors, so any single config
still works when copied to another machine without this package:

| Missing | Tool uses |
|---|---|
| `palette.conf` / no package | kitty: `kitty/theme.conf` · alacritty: `alacritty/colors-fallback.toml` |
| `tmux.conf` / no package | the default `@thm_*` values inside `.tmux.conf` (the original bar colors) |
| `nvim`, unknown name, bad variant | `onedark`; if its plugin isn't installed yet, Neovim's built-in `habamax`, then the real theme once lazy.nvim installs it |

`theme` prints which tools are on their fallback after a switch.

## Add or change a profile

```bash
theme new mytheme gruvbox-classic  # copy gruvbox-classic as a start
# edit ~/.config/theme/themes/mytheme/:
#   palette.conf → terminal colors (alacritty's file is generated from it)
#   tmux.conf    → bar colors; names are roles (what a color is for), not hues
#   nvim         → any key of colorscheme.lua, e.g. "kanagawa" or "gruvbox:soft"
theme check
theme mytheme
```

`~/.config/theme` links into this repo, so new profiles land in git. To recolor one tool only,
edit just that file (e.g. `@thm_session` in `tmux.conf` for the tmux session pill).
Neovim variants: the part after `:` is passed to that theme's `setup(variant)` — gruvbox (`soft`,
`medium`, `hard`) and rose_pine (`main`, `moon`, `dawn`) use it. A new Neovim theme is added to the registry in `colorscheme.lua`,
then `:Lazy sync`.

## Not themed (still hard-coded)

lualine's accent violet `#9085e9` (on purpose), twilight / smear-cursor colors in Neovim, and the
niri desktop (Noctalia has its own theme settings, `Mod+,`).
