# luongnv89/claude-howto

<https://github.com/luongnv89/claude-howto> · guide (Markdown) · MIT · fit 🟡 learn from

A free Claude Code course: 10 modules, from slash commands to plugins and
agent teams, with diagrams, copy-paste templates and a learning roadmap.
It is updated with each Claude Code release. It installs nothing. The
Vietnamese version (`vi/`) is only a stub; read the English modules.

## When we would use it

We already cover modules 01–03, 05, 06 and most of 09 (memory, skills,
hooks, MCP, auto mode, status line, output styles). Learn only the gaps:

| # | Learn now | Why for us | Time |
|---|---|---|---|
| 1 | `04-subagents/` | We have no agents of our own; a read-only firmware reviewer with our rules keeps the main session's context free | 1.5 h |
| 2 | `09-advanced-features/` → Sandboxing | We run without a sandbox; it limits what Bash can touch | 30 min |
| 3 | `09-advanced-features/` → Git Worktrees, Background Tasks | The built-in feature may make worktrunk unnecessary (Try next #3) | 30 min |

Later: Headless mode (`claude -p`) for scripted runs, `07-plugins/` if the
team shares our setup, `10-cli/` as a lookup.

## Watch-outs

- The templates are for web and devops work (API docs, CI/CD, data
  scientist), not STM32. Take the ideas, not the files.
- `06-hooks/notify-team.sh` posts to Slack/Discord webhooks; don't copy it
  as is.
- The README praises itself ("#1 trending", "production-ready"); when the
  official docs disagree, the docs win.
- The only `curl | sh` is the official Claude installer.

## Snapshot

| Date | Stars | Version | Open issues | Commit read |
|---|---|---|---|---|
| 2026-11-14 | 47.2k | v2.1.322 | 39 | 7af3b2f |
