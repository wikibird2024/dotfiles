---
name: feedback-prefers-bash-login-shell
description: "User uses bash only; zsh was fully removed from dotfiles and $HOME on 2026-10-06 — never propose zsh-based tooling or re-add zsh."
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 028ccd0b-6026-412c-82fb-98ed156aace4
  modified: 2026-10-06T06:54:49.003Z
---

User's shell is bash. On 2026-10-06 they said "I don't use zsh" and asked for zsh to be removed from the dotfiles entirely: the `zsh/` stow package, `steps/05_shell.sh`, the `--set-zsh-shell` bootstrap flag, `scripts/install_sh/zsh_install.sh`, zsh in package lists, and the `$HOME` leftovers (`~/.zshrc`, `~/.zsh-tools`, `~/.zshenv`, `~/.fzf.zsh`) are all gone. `~/.fzf.bash` now points at `~/.fzf/bin` (it used to point into `~/.zsh-tools/fzf/bin`, a duplicate fzf clone made by the old `.zshrc`).

**Why:** Earlier (2026-09-09) they confirmed "I prefer bash"; on 2026-10-06 they went further and removed zsh completely while fixing a tmux-popup fzf PATH bug.

**How to apply:** Don't flag `$SHELL=/bin/bash` as a bug, don't suggest zsh plugins/configs, and don't "restore" zsh bits if an old branch or doc mentions them. fzf's one true install is `~/.fzf/bin` (bootstrap `02_tools.sh`); scripts that need it outside an interactive shell add that dir to PATH themselves (see `theme pick`). Related: [[project_dotfiles_stow_quirks]].
