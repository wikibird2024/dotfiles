# vim_light

A single zero-dependency `.vimrc` for any Vim 8+ (servers, containers, a colleague's machine):
nothing to install, no internet needed. Features the local Vim lacks are skipped instead of
erroring (e.g. the fuzzy popup finder needs 8.2+).

**Not stowed** (it would clash with `vim/`). Use it by copying:

```bash
cp ~/dotfiles/vim_light/.vimrc ~/.vimrc                  # local
scp ~/dotfiles/vim_light/.vimrc server:.vimrc            # remote
```
