# agent-of-empires/agent-of-empires

<https://github.com/agent-of-empires/agent-of-empires> · Rust · MIT · fit 🟡

`aoe`: a TUI (plus web view for phone) that runs each agent (Claude Code,
Codex, Gemini CLI, ...) in its own tmux session, with optional git worktree
and Docker/Podman sandbox. Shows state, sends notifications, has diff review.

## When we would use it

- Checking agents from the phone while away from the desk.
- Running an agent inside a container for risky jobs.

## Watch-outs

- Heavier than what we need: our tmux bar already shows and jumps to agents.
- Adds its own status layer next to tmux-agent-signal.
- Young and busy (created 2026-01, 256 open issues): expect changes.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-23 | 3.4k | v1.21.0 | 256 |
