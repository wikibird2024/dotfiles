---
name: project-vim-mirrors-neovim
description: "vim/.vimrc is kept in step with the live neovim/ package (keys, servers, formatters); vim_light is the no-plugin version"
metadata:
  node_type: memory
  type: project
  originSessionId: 140a4fa9-31af-4d57-95b8-d8148a8eef6f
  modified: 2026-09-26T01:32:14.140Z
---

Since 2026-09-26 `vim/.vimrc` deliberately mirrors the **live** Neovim config (`neovim/`, not `nvim2/` — see [[project-dotfiles-stow-quirks]]): same leader keys, same language servers and formatters, and it runs those tools from Neovim's mason folder (`~/.local/share/nvim/mason/bin`, preferred over PATH). `vim_light/.vimrc` shares the core keys but uses no plugins.

**Why:** the user asked for Vim to behave like their current Neovim setup.

**How to apply:** when the user changes keys/tools in `neovim/`, offer to carry the change over to `vim/.vimrc` (and `vim/MANUAL.md`). `~/.local/bin/pyright-langserver` is a broken pip wrapper — don't let PATH lookups pick it over mason's copy.
