# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles managed with **GNU Stow**. Each top-level directory is a stow package whose internal structure mirrors `$HOME`. Running `stow <package>` from the repo root creates symlinks in `$HOME`.

The primary working directory when Claude Code is invoked is `nvim2/.config/` — the active Neovim configuration.

## Bootstrap & Setup

```bash
./bootstrap.sh                  # Full setup on a new machine (bash stays the login shell)
./bootstrap.sh --only-stow      # Re-deploy configs after a pull (idempotent)
./bootstrap.sh --skip-fonts     # Skip font download step
./bootstrap.sh --set-zsh-shell  # Also chsh to zsh (opt-in — off by default)
```

Bootstrap runs five ordered steps in `steps/`:
1. `01_packages.sh` — apt/pacman core packages, nvim2 formatter/linter deps (shellcheck, shfmt, clang-format, bear, luarocks, cpplint, debugpy), and desktop apps for the i3/picom/zathura/flameshot/kitty/alacritty stow packages
2. `02_tools.sh` — nvim, fzf, fd, starship, zoxide, TPM, rustup, stylua, luacheck, lazygit
3. `03_fonts.sh` — Nerd Fonts
4. `04_stow.sh` — symlink all packages
5. `05_shell.sh` — set zsh as default shell (skipped unless `--set-zsh-shell` is passed — bash is the preferred login shell; zsh config/plugins still work when launched manually)

All steps are idempotent.

## Stow Packages (active)

`nvim2`, `tmux`, `zsh`, `alacritty`, `kitty`, `starship`, `i3_wm_endervour`, `picom`, `zathura`, `flameshot`, `fontconfig`, `mods`, `clang`, `claude`, `vim`

> `nvim/` (old config) is intentionally excluded from stow. `nvim2/` is the active Neovim config.

To re-stow a single package after editing:
```bash
stow -R -t "$HOME" nvim2
```

## Neovim Config Architecture (`nvim2/.config/nvim/`)

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
| `colorscheme.lua` | Theme selection — change `active_theme` variable here |

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

Leader key: `Space`. Full manual in `nvim2/MANUAL.md`.

Essential groups:
- `<leader>f*` — fzf-lua (files, grep, history, buffers)
- `<leader>l*` — LSP (rename, actions, format, hover, info)
- `<leader>g*` — Git (gitsigns hunks + lazygit `<leader>gg`)
- `<leader>d*` — DAP debugger
- `<leader>t*` — toggleterm terminals
- `<leader>w*` — window splits

## Colorscheme

Edit `nvim2/.config/nvim/lua/system/plugins/colorscheme.lua`, change `active_theme`. Available values: `gruvbox8` (default), `nord`, `catppuccin`, `everforest`, `tokyonight`, `kanagawa`, `nightfox`, `onedark`, `solarized`, `abyss`. After adding a new theme run `:Lazy sync` and restart nvim.

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
