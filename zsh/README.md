# zsh

Optional zsh setup — bash stays the login shell unless `./bootstrap.sh --set-zsh-shell`.

Stowed by `steps/04_stow.sh` (`stow -R -t ~ zsh`). → `~/.zshrc`

Portable config: UTF-8 locale, `EDITOR=nvim`, deduplicated PATH, starship prompt, zoxide, fzf,
autosuggestions and syntax highlighting (`load_plugin` clones them from GitHub on the first start).
Start it any time with `zsh`.
