# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles managed with **GNU Stow**. Each top-level directory is a stow package whose internal structure mirrors `$HOME`. Running `stow <package>` from the repo root creates symlinks in `$HOME`.

The primary working directory when Claude Code is invoked is `neovim/.config/` — the active Neovim configuration.

## Bootstrap & Setup

```bash
./bootstrap.sh                  # Full setup on a new machine (bash stays the login shell)
./bootstrap.sh --only-stow      # Re-deploy configs after a pull (idempotent)
./bootstrap.sh --skip-fonts     # Skip font download step
./bootstrap.sh --set-zsh-shell  # Also chsh to zsh (opt-in — off by default)
```

Bootstrap runs five ordered steps in `steps/`:
1. `01_packages.sh` — apt/pacman core packages, neovim formatter/linter deps (shellcheck, shfmt, clang-format, bear, luarocks, cpplint, debugpy), and desktop apps for the i3/picom/zathura/flameshot/kitty/alacritty stow packages
2. `02_tools.sh` — nvim, fzf, fd, starship, zoxide, TPM, rustup, stylua, luacheck, lazygit
3. `03_fonts.sh` — Nerd Fonts
4. `04_stow.sh` — symlink all packages
5. `05_shell.sh` — set zsh as default shell (skipped unless `--set-zsh-shell` is passed — bash is the preferred login shell; zsh config/plugins still work when launched manually)

All steps are idempotent.

## Stow Packages (active)

`neovim`, `bash`, `tmux`, `zsh`, `alacritty`, `kitty`, `starship`, `i3_wm_endervour`, `picom`, `zathura`, `flameshot`, `fontconfig`, `mods`, `clang`, `claude`, `vim`, `niri`, `noctalia`, `theme`

`niri/` is the niri config: one `config.kdl` that starts the desktop shell and binds its panels through `scripts/shell`, which runs Noctalia when installed and otherwise waybar/fuzzel/mako/swaylock (Ubuntu 24.04 has no Noctalia package; their configs are in `niri/.config/waybar` and `niri/.config/mako`). Keys, workspaces, scripts and workflow: `niri/README.md`.

`theme/` holds the shared color profiles (`.config/theme/themes/<name>/`: `palette.conf` for kitty/alacritty, `tmux.conf` with `@thm_*` roles for `.tmux.conf`, `nvim` naming a `colorscheme.lua` theme) and the `theme` command (`.local/bin/theme`: `theme <name>`, `theme pick` (fzf, also tmux `prefix + T`), `theme new <name> [from]`, `theme check`) that switches all of them live (and, under niri without Noctalia, the bar/launcher/notifications/lock via `niri/.config/niri/scripts/shell colors`), plus `hexcolor` (paints `#rrggbb` codes in their color in the terminal, like nvim-colorizer; kitty `Ctrl+Shift+I` shows the screen through it). The active profile is a symlink in `~/.local/state/theme/current` (outside the repo). Every profile file is optional, and every tool keeps its own fallback so its package works without `theme`: kitty `theme.conf`, alacritty `colors-fallback.toml`, the `@thm_*` defaults in `.tmux.conf`, and `fallback` (then built-in `habamax`) in `colorscheme.lua`, which also never errors when a theme plugin is not installed. Starship uses ANSI color names, so it follows the terminal palette.

`noctalia/` holds hand-written Noctalia config (`bar.toml`). Settings changed in the Noctalia GUI go to `~/.local/state/noctalia/settings.toml` (not tracked) and override these files.

> `neovim/` is the active Neovim config. `neovim_light/` (a lighter variant) is not stowed.

To re-stow a single package after editing:
```bash
stow -R -t "$HOME" neovim
```

## Neovim Config Architecture (`neovim/.config/nvim/`)

Entry point: `init.lua` loads three namespaces in order:

```
system.kernel   — options, keymaps, autocommands (no plugins)
system.plugins  — lazy.nvim plugin specs (one file/dir per concern)
system.runtime  — LSP on_attach logic shared across servers
```

Plugin specs live under `lua/system/plugins/` and are organised by concern:

| Directory/File | Contents |
|---|---|
| `lsp/` | mason-lspconfig setup; per-server configs in `lsp/servers/` |
| `lsp/rust.lua` | rustaceanvim (replaces plain lspconfig for Rust) |
| `cmp/` | nvim-cmp completion + source priority |
| `ui/` | neo-tree, bufferline, lualine, aerial, trouble, whichkey |
| `tools/` | fzf-lua, nvim-dap, toggleterm, gitsigns, grug-far, surround, etc. |
| `constitution/` | Shared LSP capabilities and UI helpers imported by lsp/ |
| `format.lua` | conform.nvim (auto-format on save) |
| `lint.lua` | nvim-lint (runs on save / InsertLeave) |
| `treesitter.lua` | Treesitter parsers + text objects + selection expansion |
| `colorscheme.lua` | Theme registry; the active one comes from the `theme` profile (`fallback` if none) |

**Plugin manager:** lazy.nvim (auto-bootstrapped; all plugins default `lazy = true`).

## LSP Servers

Active for: **C/C++** (clangd), **Rust** (rust-analyzer via rustaceanvim), **Python** (pyright + ruff), **LaTeX** (texlab), **Lua** (lua_ls, paired with lazydev.nvim for Neovim API/plugin awareness), **Shell** (bashls), **TOML** (taplo), plus **typos_lsp** (spell-checking) across all filetypes.

`clangd`, `pyright`, `texlab`, `lua_ls` (`lua-language-server`), `bashls` (`bash-language-server`), `ruff`, `typos_lsp` (`typos-lsp`), `taplo`, and the `codelldb` DAP adapter are installed automatically via `mason-tool-installer` on first launch — no manual install needed for these. `rust-analyzer` is managed by rustaceanvim itself, not mason.

`ruff`, `typos-lsp`, and `taplo` are all written in Rust.

C/C++ requires `compile_commands.json` in the project root for clangd to index correctly. Generate with cmake (`-DCMAKE_EXPORT_COMPILE_COMMANDS=ON`) or `bear`.

## Formatters & Linters

Formatters run on save via conform.nvim:

| Language | Tool |
|---|---|
| C/C++ | clang-format (config: `clang/.clang-format`) |
| Rust | rustfmt |
| Python | ruff (organize-imports + format) |
| Lua | stylua |
| Shell | shfmt |
| TOML | taplo |

Linters (nvim-lint, on save): luacheck (Lua), shellcheck (Shell). No C/C++ linter: cpplint only checks Google style, which clashes with project `.clang-format` files; clang-format owns C/C++ style. C/C++ bug checks come from clang-tidy run inside clangd (`--clang-tidy` in `lsp/servers/clangd.lua`); which checks run is set per project in its `.clangd` (`Diagnostics: ClangTidy:`) — see MANUAL.md "C/C++ bug checks". Python linting comes from the `ruff` LSP server instead (see LSP Servers above), not nvim-lint.

## Key Bindings Reference

Leader key: `Space`. Full manual in `neovim/MANUAL.md`.

Essential groups:
- `<leader>f*` — fzf-lua (files, grep, history, buffers)
- `<leader>l*` — LSP (rename, actions, format, hover, info)
- `<leader>g*` — Git (gitsigns hunks + lazygit `<leader>gg`)
- `<leader>d*` — DAP debugger
- `<leader>t*` — toggleterm terminals
- `<leader>w*` — window splits

## Colorscheme

Colors are picked per profile with `theme <name>` (the `theme` package), which switches kitty, alacritty, tmux and Neovim together, live. A profile's `nvim` file names a key of the registry in `neovim/.config/nvim/lua/system/plugins/colorscheme.lua`, optionally with a variant passed to that theme's `setup(variant)` (e.g. `gruvbox:medium`). Without a profile Neovim uses `fallback` (`onedark`). Every registered theme is installed; after adding one to the registry run `:Lazy sync`.

## External Tool Dependencies

`./bootstrap.sh` installs all of these (`01_packages.sh` + `02_tools.sh`) — this list is for a manual install or when a step is skipped:
```bash
# Linters/formatters (black/flake8 no longer needed -- replaced by mason-managed ruff)
pip install --user --break-system-packages cpplint debugpy
cargo install stylua
luarocks install luacheck
apt install shellcheck shfmt clang-format bear
```
`lazygit` isn't reliably in apt across distros, so bootstrap fetches the binary release directly instead.

DAP adapters: `codelldb` is auto-installed by `mason-tool-installer` (see LSP Servers above); `arm-none-eabi-gdb` via apt for embedded C.
