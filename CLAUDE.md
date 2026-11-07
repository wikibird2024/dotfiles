# CLAUDE.md

Personal dotfiles managed with **GNU Stow**: each top-level directory is a
package that mirrors `$HOME`. The packages that get stowed are listed in
`STOW_PKGS` in `steps/04_stow.sh`; everything else (`neovim_light`, `nvim2`,
`vim_light`, ...) is not stowed.

## Commands

```bash
./bootstrap.sh               # new machine: steps/01..04, all idempotent
./bootstrap.sh --only-stow   # re-link configs after a pull
stow -R -t "$HOME" <pkg>     # re-link one package after editing it
```

## Rules

- **Public repo.** Never commit keys: they go in `~/.secrets`. The
  `.githooks/pre-commit` hook runs `ripsecrets`. Name, email and work-only git
  settings live in the untracked `~/.gitconfig.local`.
- **Every tool works without the `theme` command.** Profile files are
  optional, and each tool keeps its own fallback (kitty `theme.conf`, `@thm_*`
  defaults in `.tmux.conf`, `fallback` in `colorscheme.lua`). After adding a
  theme to the `colorscheme.lua` registry, run `:Lazy sync`.
- `vim/.vimrc` follows `neovim/` (same keys and tools); update both.

## On purpose (don't "fix" these)

- Alacritty keeps its fixed xfce4-terminal colors; the `theme` command skips it.
- No C/C++ linter in nvim-lint: clang-format owns the style, and clang-tidy
  runs inside clangd (checks are set per project in `.clangd`).
- CSharpier formats only in projects with a `.csharpierrc`.
- `rust-analyzer` comes from rustaceanvim, not Mason.

## Gotchas

- Thunar rewrites `uca.xml` from its GUI, which replaces the stow link.
- Noctalia GUI changes go to `~/.local/state/noctalia/settings.toml` and
  override `noctalia/` files.
- kanata needs one-time root setup (uinput group, udev rule) done by
  `04_stow.sh`; re-login once. Emergency stop: `LCtrl+Space+Esc`.

## Docs

Keys and workflow: `neovim/MANUAL.md`, `niri/README.md`, `theme/README.md`,
`tmux/README.md`.
