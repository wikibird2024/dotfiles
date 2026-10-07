# bash

Bash setup — bash is the login shell.

Stowed by `steps/04_stow.sh` (`stow -R -t ~ bash`). `04_stow.sh` first moves a machine's own `~/.bashrc`, `~/.aliases`,
`~/.bash_functions` to `*.bak.<time>` so stow can link them.

| File | Contents |
|---|---|
| `.bashrc` | interactive-only guard, history, PATH (deduplicated), `EDITOR=nvim`, Wayland env vars, completion, tools (starship, zoxide, fzf: `Ctrl+T`/`Alt+C` list with `fd`), lazy nvm |
| `.aliases` | shortcuts (`ll`, config editors `bash.e` / `alias.e` / `func.e`), work aliases, aider models, `datasheet` / `schematic` folders |
| `.bash_functions` | `y` / `r` (cd to the folder yazi / ranger was in), pyenv and ESP-IDF environment helpers, more |

Reload after editing: `source ~/.bashrc`.

**Paths into the command line, fastest first:** `Ctrl+T` (fzf, pick files; inserts their
paths), `Alt+C` (fzf, cd into a folder), `z name` (zoxide), kitty `Ctrl+Shift+P` then `F`
(pick a path shown on screen), `y` (yazi: `cc` copies the path). From Thunar: right-click →
**Copy Path** (`thunar/README.md`). Terminal → GUI app: `ripdrag file...` opens a window to
drag the files from.

**Machine-specific:** some aliases point at `/home/greystone/...` (the work machine) and
`cat` is aliased to `batcat` (Debian/Ubuntu name; on Arch the command is `bat`).
