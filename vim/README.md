# vim

Full Vim setup (plugins via vim-plug) for machines or moments without Neovim.
Neovim is the main editor — see `neovim/`.

Stowed by `steps/04_stow.sh` (`stow -R -t ~ vim`). → `~/.vimrc`. `04_stow.sh` moves an existing real `~/.vimrc` to
`~/.vimrc.bak.<time>` first, then runs `:PlugInstall` so the first start has every plugin.

Needs a clipboard-enabled Vim (`gvim` on Arch, `vim-gtk3` on Debian/Ubuntu) and nodejs (coc.nvim) —
both installed by `steps/01_packages.sh`. Keys and features: `MANUAL.md`.
`.stow-local-ignore` keeps `README.md` and `MANUAL.md` out of `~`.
