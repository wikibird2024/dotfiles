# raine/workmux

<https://github.com/raine/workmux> · Rust · MIT · fit 🟡

One command per task: `workmux add <branch>` makes a git worktree, a tmux
window (prefix `wm-`) and starts the agent in it; `workmux merge` merges the
branch back and removes the worktree, window and branch. Shows agent state
(working / waiting / done) as icons in the window name, from Claude Code
hooks (`workmux setup` installs them).

## When we would use it

- Two or more Claude sessions on the same repo at once, so they stop editing
  the same checkout.
- Per-project `.workmux.yaml`: pane layout, files to copy into each worktree,
  setup commands.

## Watch-outs

- Its status icons and hooks overlap tmux-agent-signal (our bar, click jump,
  `prefix + N`): pick one owner for agent state, don't run both.
- Worktrees live in a sibling `<project>__worktrees/` folder: CubeMX builds
  and `compile_commands.json` must be made per worktree.
- kitty backend exists; sidebar and session mode are tmux-only.
- Try the built-in `claude --worktree` / `claude agents` first: it may be
  enough without a new tool.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-23 | 2.9k | v0.1.276 | 68 |
