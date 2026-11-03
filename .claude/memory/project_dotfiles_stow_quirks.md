---
name: project-dotfiles-stow-quirks
description: Known Stow gotchas in this dotfiles repo — bogus BUG warnings and a copilot-auth conflict
metadata: 
  node_type: memory
  type: project
  originSessionId: e00bb92d-4f1a-4ded-b02a-dc6e1d64e047
  modified: 2026-09-23T08:39:03.711Z
---

`stow -D`/`stow` runs in this repo print harmless `BUG in find_stowed_path? Absolute/relative mismatch` warnings.

**Why:** `~/Downloads`, `~/Documents`, and `~/storage` are absolute symlinks to `/mnt/storage/...` (unrelated to dotfiles). Stow's traversal of `$HOME` walks into them and its internal relative-vs-absolute path check trips (known upstream bug, aspiers/stow#95). The actual stow/unstow operation still completes correctly — verify by checking the real symlink targets, not by trusting the BUG text as fatal.

There are **two separate nvim stow packages**: `nvim2` (the "active" one per CLAUDE.md) and `neovim` (a different config, also targets `.config/nvim`). Only one should be stowed at a time — stowing both causes conflicts. As of 2026-08-19, `neovim` is stowed (not `nvim2`), per user's explicit switch — still true 2026-09-23. The two have diverged (e.g. `neovim` has nvim-dap-cortex-debug + overseer-as-dap-dependency; `nvim2` doesn't), so reading `nvim2` gives wrong answers about the live setup. Check `readlink ~/.config/nvim/init.lua` BEFORE reading/explaining nvim config, not after.

**How to apply:** Before running stow for nvim packages, check which of `nvim2`/`neovim` is currently linked (`readlink ~/.config/nvim/init.lua`) to avoid assuming CLAUDE.md's "nvim2 is active" is still accurate — the user switches between them.

Also: `neovim/.config/github-copilot/` previously accumulated the user's **live** GitHub Copilot auth db (auth.db, auth.db-shm/-wal, versions.json) as a side effect of stowing — Copilot wrote its session files straight through the stow symlink into the repo's working tree. These were untracked (never committed) and were deleted + gitignored (`neovim/.config/github-copilot/` added to `.gitignore`) on 2026-08-19. If this path reappears with live-looking auth files, do not stow/commit it — flag it as a credential-leak risk again.

`~/MANUAL.md` is symlinked to `vim/MANUAL.md` (user's explicit choice) even though `neovim` package also ships a `MANUAL.md` — that file is excluded via `stow --ignore='^MANUAL\.md$'` when stowing `neovim`.
