# akitaonrails/ai-memory

<https://github.com/akitaonrails/ai-memory> · Rust · MIT · fit 🟡

Shared long-term memory for 20+ agent CLIs (Claude Code, Codex, Cursor,
Gemini CLI, OpenCode, ...). Quit one agent mid-task, start another in the
same folder, and it gets a handoff: where you stopped, what failed, what is
open. `ai-memory run <agent>` also carries the session history. A small
"how I work" profile reaches every new repo.

## When we would use it

- Only if we start using a second agent CLI next to Claude Code. Today
  Claude Code's own memory covers us.

## Watch-outs

- Has a server part ("the remote server receives only the harness and
  session identity"): check where the memory is stored before use ⚪.
- Overlaps Claude Code's built-in memory and our CLAUDE.md files.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-28 | 14k | v3.2.9 | 14 |
