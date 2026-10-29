# theme

One command to switch the colors of kitty, tmux and Neovim together, live
(no restarts). Starship follows by itself. Alacritty is left out on purpose: it keeps
its own xfce4-terminal colors (`alacritty/colors.toml`). GTK apps (Nautilus, file dialogs) switch to
dark or light to match the palette background (`gsettings` color-scheme, and the
`-dark` GTK theme such as `Yaru-dark` when installed).

Stowed by `steps/04_stow.sh` → `~/.local/bin/theme`, `~/.config/theme/themes/`.
A new machine starts on the `ubuntu` profile; after that your choice is kept.

## Use

```bash
theme                       # list profiles, * = active
theme gruvbox-classic       # switch everything to that profile
theme pick                  # choose with fzf + color preview   (in tmux: prefix + T)
theme new mytheme [from]    # new profile as a copy of [from] (default: the active one)
theme check                 # find mistakes in every profile
theme gtk [dark|light]      # GTK apps only; no argument = toggle (niri: Mod+Shift+D)
theme --help
```

## Profiles

Neovim always sits one step **lighter** than the terminal, in the same color
family, so an editor pane never looks like a shell or Claude pane. Themes with
a lighter variant use it (`gruvbox:soft`); the others get a lighter background
from `raise_background()` in `colorscheme.lua`.

| Profile | Terminal | Neovim | Notes |
|---|---|---|---|
| `ubuntu` | aubergine `#300a24` | `onedark` (darker, `#1f2329`) | the original kitty colors — default |
| `gruvbox-classic` | `#282828`, green cursor | `gruvbox:soft` (`#32302f`) | the old alacritty colors |
| `catppuccin` | mocha `#1e1e2e` | `catppuccin:macchiato` (`#24273a`) | |
| `onedark` | darker `#1f2329` | `onedark:dark` (`#282c34`) | |
| `rose-pine` | main `#191724` | `rose_pine:moon` (`#232136`) | dusty rose, gold, lavender; foam stands in for green |
| `carbonfox` | near-black `#161616` | `nightfox` (carbonfox, raised to `#222222`) | IBM Carbon hues, high contrast; no yellow (teal instead) |
| `kanagawa-dragon` | warm ink `#181616` | `kanagawa:wave` (`#1f1f28`) | muted, low saturation; Neovim uses the bluer wave |
| `moonfly` | charcoal `#080808` | `moonfly` (raised to `#262626`) | calm hues, still readable (code 6.6–12:1) |
| `abyss` | navy black `#000c18` | `abyss` (boreal, raised to `#0b1b2f`) | deep navy, blue text |
| `xfce` | pure black `#000000`, red cursor | `dracula` (its own `#282a36`, cream text) | the xfce4-terminal look alacritty keeps: cream text, Dracula accents |

## How it works

```
~/.config/theme/themes/<name>/      ← profiles (in this repo)
    palette.conf   terminal colors, kitty syntax
    tmux.conf      @thm_* color roles for the tmux bar
    nvim           theme name from colorscheme.lua, optional variant ("gruvbox:medium")

~/.local/state/theme/               ← runtime state, outside the repo (switching leaves no git diff)
    current        → symlink to the active profile folder
```

| Tool | Reads | How a switch reaches running windows |
|---|---|---|
| kitty | `current/palette.conf` (included after `kitty/theme.conf`) | `kitty @ set-colors` on every kitty socket |
| tmux | `current/tmux.conf`; `.tmux.conf` styles use `#{@thm_*}` roles | `tmux source-file` |
| Neovim | `current/nvim` → key in `neovim/.config/nvim/lua/system/plugins/colorscheme.lua` | `SIGUSR1` → reloads the theme |
| lualine | the colorscheme's colors | rebuilds on the `ColorScheme` event |
| starship | nothing — uses ANSI color names | follows the terminal palette |

## Fallbacks — nothing breaks

Every profile file is optional, and every tool keeps its own colors, so any single config
still works when copied to another machine without this package:

| Missing | Tool uses |
|---|---|
| `palette.conf` / no package | kitty: `kitty/theme.conf` |
| `tmux.conf` / no package | the default `@thm_*` values inside `.tmux.conf` (the original bar colors) |
| `nvim`, unknown name, bad variant | `onedark`; if its plugin isn't installed yet, Neovim's built-in `habamax`, then the real theme once lazy.nvim installs it |

`theme` prints which tools are on their fallback after a switch.

## Add or change a profile

```bash
theme new mytheme gruvbox-classic  # copy gruvbox-classic as a start
# edit ~/.config/theme/themes/mytheme/:
#   palette.conf → terminal colors (kitty)
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

lualine's accent violet `#9085e9` (on purpose), smear-cursor colors in Neovim, and the
niri desktop (Noctalia has its own theme settings, `Mod+,`).
