# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

Personal dotfiles managed with **GNU Stow**. Each top-level directory is a stow package whose internal structure mirrors `$HOME`. Running `stow <package>` from the repo root creates symlinks in `$HOME`.

The primary working directory when Claude Code is invoked is `nvim2/.config/` — the active Neovim configuration.

## Bootstrap & Setup

```bash
./bootstrap.sh              # Full setup on a new machine
./bootstrap.sh --only-stow  # Re-deploy configs after a pull (idempotent)
./bootstrap.sh --skip-fonts # Skip font download step
```

Bootstrap runs five ordered steps in `steps/`:
1. `01_packages.sh` — apt/pacman core packages
2. `02_tools.sh` — nvim, fzf, fd, starship, zoxide, TPM
3. `03_fonts.sh` — Nerd Fonts
4. `04_stow.sh` — symlink all packages
5. `05_shell.sh` — set zsh as default shell

All steps are idempotent.

## Stow Packages (active)

`nvim2`, `tmux`, `zsh`, `alacritty`, `kitty`, `starship`, `i3_wm_endervour`, `picom`, `zathura`, `flameshot`, `fontconfig`, `mods`, `clang`

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

Active for: **C/C++** (clangd), **Rust** (rust-analyzer via rustaceanvim), **Python** (pyright), **LaTeX** (texlab).

C/C++ requires `compile_commands.json` in the project root for clangd to index correctly. Generate with cmake (`-DCMAKE_EXPORT_COMPILE_COMMANDS=ON`) or `bear`.

## Formatters & Linters

Formatters run on save via conform.nvim:

| Language | Tool |
|---|---|
| C/C++ | clang-format (config: `clang/.clang-format`) |
| Rust | rustfmt |
| Python | black |
| Lua | stylua |
| Shell | shfmt |

Linters (nvim-lint, on save): flake8 (Python), cpplint (C/C++), luacheck (Lua), shellcheck (Shell).

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

Edit `nvim2/.config/nvim/lua/system/plugins/colorscheme.lua`, change `active_theme`. Available values: `gruvbox8` (default), `nord`, `catppuccin`, `everforest`, `tokyonight`, `kanagawa`, `nightfox`, `onedark`, `solarized`. After adding a new theme run `:Lazy sync` and restart nvim.

## External Tool Dependencies

Install missing tools before opening nvim for first time:
```bash
# Linters/formatters
pip install black flake8 cpplint debugpy
cargo install stylua
luarocks install luacheck
apt install shellcheck shfmt clang-format lazygit
```

DAP adapters: `codelldb` via `:MasonInstall codelldb`, `arm-none-eabi-gdb` via apt for embedded C.
