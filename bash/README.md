# bash

Bash setup — bash is the login shell (zsh is optional, see `zsh/`).

Stowed by `steps/04_stow.sh` (`stow -R -t ~ bash`). `04_stow.sh` first moves a machine's own `~/.bashrc`, `~/.aliases`,
`~/.bash_functions` to `*.bak.<time>` so stow can link them.

| File | Contents |
|---|---|
| `.bashrc` | interactive-only guard, history, PATH (deduplicated), `EDITOR=nvim`, Wayland env vars, completion, tools (starship, zoxide, fzf), lazy nvm |
| `.aliases` | shortcuts (`ll`, config editors `bash.e` / `alias.e` / `func.e`), work aliases, aider models, `datasheet` / `schematic` folders |
| `.bash_functions` | `y` / `r` (cd to the folder yazi / ranger was in), pyenv and ESP-IDF environment helpers, more |

Reload after editing: `source ~/.bashrc`.

**Machine-specific:** some aliases point at `/home/greystone/...` (the work machine) and
`cat` is aliased to `batcat` (Debian/Ubuntu name; on Arch the command is `bat`).
