# Community repos to watch

Open-source repos worth checking from time to time: tools we may use, or
ideas to borrow before building our own. One short note per repo.

Maintained by Hao Tran. Not a stow package (not linked into `$HOME`).

## Index

| Repo | What it is | Fit for us | Last checked |
|---|---|---|---|
| [lexmount/moli](lexmount-moli.md) | Headless browser for AI agents (Rust) | 🟡 only if Claude Code can't read JS-heavy pages | 2026-10-21 |
| [morluto/rea](morluto-rea.md) | Reverse-engineering MCP for agents (TypeScript) | 🟡 for code with no source: vendor libs, logic captures, .NET builds | 2026-10-21 |
| [raine/workmux](raine-workmux.md) | Worktree + tmux window per agent task (Rust) | 🟡 if built-in `claude --worktree` is not enough | 2026-10-23 |
| [agent-of-empires/agent-of-empires](agent-of-empires-agent-of-empires.md) | Agent manager: tmux sessions, worktrees, web view (Rust) | 🟡 heavier; overlaps our tmux bar | 2026-10-23 |
| [Adancurusul/embedded-debugger-mcp](adancurusul-embedded-debugger-mcp.md) | Probe-rs/OpenOCD debugger MCP + skill (Rust) | 🟡 let Claude flash, read RTT, triage HardFaults | 2026-10-23 |
| [okhsunrog/flashprobe-mcp](okhsunrog-flashprobe-mcp.md) | Flash + bounded log capture MCP (Rust) | 🟡 very new, watch | 2026-10-23 |
| [ccusage/ccusage](ccusage-ccusage.md) | Token and cost report from local logs | 🟢 `npx ccusage@latest` | 2026-10-23 |
| [obra/superpowers](obra-superpowers.md) | Plan → TDD → subagent → verify skill pack | 🟡 borrow ideas; plugin stays off | 2026-10-23 |
| [hesreallyhim/awesome-claude-code](hesreallyhim-awesome-claude-code.md) | Biggest curated Claude Code list | 🟢 reference | 2026-10-23 |
| [shanraisshan/claude-code-best-practice](shanraisshan-claude-code-best-practice.md) | Collected Claude Code tips | 🟢 reference | 2026-10-23 |

Fit: 🟢 use now · 🟡 may need it, watch · 🔴 not for us, kept for reference

## Note format

Each `<owner>-<repo>.md` has: what it is, when we would use it, watch-outs,
and a dated snapshot (stars, version) so the next check shows the trend.

Quick re-check of a repo:

```bash
gh repo view <owner>/<repo> --json stargazerCount,pushedAt
gh release list -R <owner>/<repo> -L 1
```
