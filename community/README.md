# Community repos to watch

Open-source repos worth checking from time to time: tools we may use, or
ideas to borrow before building our own. One short note per repo.

Maintained by Hao Tran. Not a stow package (not linked into `$HOME`).

## How it is organised

One flat folder. Each file name starts with its category, so `ls` groups
them: `<category>-<owner>-<repo>.md`.

| Prefix | What goes there |
|---|---|
| `workflow-` | skill packs that change how the agent works |
| `understand-` | read, map or draw a codebase |
| `design-` | UI / frontend design skills |
| `agent-ops-` | run, track and pay for many agents |
| `agent-tools-` | give the agent a new ability (browser, reverse engineering) |
| `embedded-` | flash, debug and read logs on real boards |
| `lists-` | curated lists and tip collections |

- **Category = file name prefix.** A repo's category rarely changes, so its
  name stays.
- **Priority = fit light** in the tables below, sorted 🟢 → 🟡 → 🔴 inside
  each category. Change the light and move the row; never rename the file.
- New category only when 3+ repos would go in it; until then use the
  closest one.

Fit: 🟢 use now · 🟡 may need it, watch · 🔴 not for us, kept for reference

## Index

### workflow-

| Fit | Repo | What it is | Last checked |
|---|---|---|---|
| 🟢 | [DietrichGebert/ponytail](workflow-dietrichgebert-ponytail.md) | "Lazy senior dev": least code, never skips checks; review/audit commands | 2026-10-24 |
| 🟡 | [addyosmani/agent-skills](workflow-addyosmani-agent-skills.md) | `/spec` → `/ship` skills, install one at a time | 2026-10-24 |
| 🟡 | [obra/superpowers](workflow-obra-superpowers.md) | Plan → TDD → subagent → verify pack; borrow ideas, plugin stays off | 2026-10-24 |

### understand-

| Fit | Repo | What it is | Last checked |
|---|---|---|---|
| 🟢 | [tt-a1i/archify](understand-tt-a1i-archify.md) | Idea or repo → interactive HTML diagram / explainer page | 2026-10-24 |
| 🟡 | [Egonex-AI/Understand-Anything](understand-egonex-ai-understand-anything.md) | Whole-repo knowledge graph + dashboard; heavy on tokens | 2026-10-24 |

### design-

| Fit | Repo | What it is | Last checked |
|---|---|---|---|
| 🟡 | [pbakaus/impeccable](design-pbakaus-impeccable.md) | Design taste skill, 24 commands, 62 "AI look" rules; first pick for web UI | 2026-10-24 |
| 🟡 | [nextlevelbuilder/ui-ux-pro-max-skill](design-nextlevelbuilder-ui-ux-pro-max-skill.md) | Generates a design system from a brief; landing pages | 2026-10-24 |

### agent-ops-

| Fit | Repo | What it is | Last checked |
|---|---|---|---|
| 🟢 | [ccusage/ccusage](agent-ops-ccusage-ccusage.md) | Token and cost report from local logs: `npx ccusage@latest` | 2026-10-23 |
| 🟡 | [raine/workmux](agent-ops-raine-workmux.md) | Worktree + tmux window per agent task (Rust); if `claude --worktree` is not enough | 2026-10-23 |
| 🟡 | [agent-of-empires/agent-of-empires](agent-ops-agent-of-empires-agent-of-empires.md) | Agent manager: tmux sessions, worktrees, web view; overlaps our tmux bar | 2026-10-23 |

### agent-tools-

| Fit | Repo | What it is | Last checked |
|---|---|---|---|
| 🟡 | [morluto/rea](agent-tools-morluto-rea.md) | Reverse-engineering MCP: vendor libs, logic captures, .NET builds | 2026-10-21 |
| 🟡 | [lexmount/moli](agent-tools-lexmount-moli.md) | Headless browser for agents; only if Claude Code can't read JS-heavy pages | 2026-10-21 |

### embedded-

| Fit | Repo | What it is | Last checked |
|---|---|---|---|
| 🟡 | [Adancurusul/embedded-debugger-mcp](embedded-adancurusul-embedded-debugger-mcp.md) | Probe-rs/OpenOCD debugger MCP: flash, RTT, HardFault triage | 2026-10-23 |
| 🟡 | [okhsunrog/flashprobe-mcp](embedded-okhsunrog-flashprobe-mcp.md) | Flash + bounded log capture MCP; very new, watch | 2026-10-23 |

### lists-

| Fit | Repo | What it is | Last checked |
|---|---|---|---|
| 🟢 | [hesreallyhim/awesome-claude-code](lists-hesreallyhim-awesome-claude-code.md) | Biggest curated Claude Code list; first stop | 2026-10-23 |
| 🟢 | [shanraisshan/claude-code-best-practice](lists-shanraisshan-claude-code-best-practice.md) | Collected Claude Code tips | 2026-10-23 |
| 🟡 | [ComposioHQ/awesome-claude-skills](lists-composiohq-awesome-claude-skills.md) | 1000+ skills list, part advert for Composio | 2026-10-24 |

## Note format

Each `<category>-<owner>-<repo>.md` has: what it is, when we would use it,
watch-outs, and a dated snapshot (stars, version) so the next check shows the
trend. Add a new snapshot row on each check; don't overwrite the old one.

Quick re-check of a repo:

```bash
gh repo view <owner>/<repo> --json stargazerCount,pushedAt
gh release list -R <owner>/<repo> -L 1
```
