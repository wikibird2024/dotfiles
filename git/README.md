# git

Shared git settings, linked by stow:

| File | Links to | What |
|---|---|---|
| `.gitconfig` | `~/.gitconfig` | default branch, delta as pager, zdiff3 conflicts |
| `.config/git/ignore` | `~/.config/git/ignore` | files ignored in every repo |

Per machine, not tracked: `~/.gitconfig.local` holds your name, email and
work-only settings (like a CA certificate for a work server). `.gitconfig`
includes it last, so it can override anything. Start from
[`.gitconfig.local.example`](.gitconfig.local.example).

`04_stow.sh` moves an existing real `~/.gitconfig` to `~/.gitconfig.local`
(if that does not exist yet), so name and email are kept.

Needs `delta` (`cargo install git-delta`, done by `02_tools.sh`).

## Secret check before commit

This repo has a `pre-commit` hook in `.githooks/` that runs
[ripsecrets](https://github.com/sirwart/ripsecrets) on the staged files and
stops the commit if it finds an API key or token. `04_stow.sh` turns it on
with `git config core.hooksPath .githooks`.

- False alarm: add the line or path to `.secretsignore` in the repo root.
- Skip once: `git commit --no-verify`.
