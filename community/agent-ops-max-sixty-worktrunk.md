# max-sixty/worktrunk

<https://github.com/max-sixty/worktrunk> · Rust · MIT or Apache-2.0 · fit 🟡

Git worktree CLI for parallel agent work. `wt switch --create <branch>` makes a
branch and a worktree and moves there, `wt list` shows them all with status,
`wt remove` deletes one. It also has merge, hooks and LLM commit messages.

## Ready to use (installed 2026-11-06)

`wt` is in `~/.local/bin`; `bash/.bashrc` loads its shell function, so `wt switch`
changes folder in new shells.

```bash
wt switch --create my-branch        # new branch + worktree, moves there
wt list
wt remove my-branch                 # removes the worktree and a merged branch
```

Install again: `cargo install worktrunk --locked`, or the release archive.

## When we would use it

- Two or more Claude sessions on the same repo, so they stop editing one checkout.
- Compare with `claude --worktree` and [workmux](agent-ops-raine-workmux.md) first.

## Watch-outs

- Each worktree needs its own CubeMX output and build folder: more builds at once
  use more memory, and builds are the main suspect for our out-of-memory logouts.
- Worktrees go in a sibling folder (`repo.branch`), which may surprise CMake paths.
- Its Claude plugin and hooks are **not installed**: they would overlap
  tmux-agent-signal. Pick one owner for agent state.
- Busy repo: fast releases, 48 open issues and PRs.

## Check (2026-11-06, commit d022f76; installed binary v0.81.0)

Read: license, README, the Claude plugin hooks, a search for telemetry and network
libraries. Not all the code.

- GitHub shows license "NOASSERTION", but `LICENSE` and `Cargo.toml` say MIT or Apache-2.0.
- No telemetry found by search; it can call `gh` for CI status in `wt list`.
- Binary checksum matched the release. Built by the project, not from the commit read.
- Tested on a throwaway repo: create, list, remove all worked; wrote no config.
- ⚪ Not tried on a real firmware repo or with Claude sessions yet.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-11-06 | 11.5k | v0.81.0 | 48 |
