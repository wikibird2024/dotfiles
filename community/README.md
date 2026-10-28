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

## Try next

What to try soon, in order. Keep it to about 6 rows. When one is tried,
write a "Trial" section in its note (like archify's), set its fit light,
and remove the row here.

| # | Repo | Why now | Effort | Tried |
|---|---|---|---|---|
| 1 | [McuBuddy](embedded-cunjun-mcubuddy.md) vs [embedded-debugger-mcp](embedded-adancurusul-embedded-debugger-mcp.md) | Agent gets hands on the board: SVD registers, RTT, HardFault. `/scout check` both, then one bench board | ~1 h | ⚪ |
| 2 | [ternima](embedded-nimaltd-ternima.md) | RTT over ST-Link + Modbus tester, no vendor tools | 15 min | ⚪ |
| 3 | [security-audit-skill](workflow-cloudflare-security-audit-skill.md) | One full security pass on a PC tool or protocol parser | 1 run, many tokens | ⚪ |
| 4 | [BeautifulRust](workflow-morganlinton-beautifulrust.md) | Next time we write Rust | with Rust work | ⚪ |

## Index

### workflow-

| Fit | Repo | What it is | Last checked |
|---|---|---|---|
| 🟢 | [DietrichGebert/ponytail](workflow-dietrichgebert-ponytail.md) | "Lazy senior dev": least code, never skips checks; review/audit commands | 2026-10-24 |
| 🟢 | [cloudflare/security-audit-skill](workflow-cloudflare-security-audit-skill.md) | 6-phase security audit, each finding checked by a fresh agent | 2026-10-28 |
| 🟢 | [multica-ai/andrej-karpathy-skills](workflow-multica-ai-andrej-karpathy-skills.md) | One CLAUDE.md, 4 Karpathy rules; 4 taken into ours (tried) | 2026-10-28 |
| 🟡 | [addyosmani/agent-skills](workflow-addyosmani-agent-skills.md) | `/spec` → `/ship` skills, install one at a time | 2026-10-24 |
| 🟡 | [obra/superpowers](workflow-obra-superpowers.md) | Plan → TDD → subagent → verify pack; borrow ideas, plugin stays off | 2026-10-24 |
| 🟡 | [morganlinton/BeautifulRust](workflow-morganlinton-beautifulrust.md) | Idiomatic Rust skills: write, review, port + clippy config | 2026-10-28 |

### understand-

| Fit | Repo | What it is | Last checked |
|---|---|---|---|
| 🟢 | [tt-a1i/archify](understand-tt-a1i-archify.md) | Idea or repo → interactive HTML diagram / explainer page | 2026-10-24 |
| 🟡 | [Egonex-AI/Understand-Anything](understand-egonex-ai-understand-anything.md) | Whole-repo knowledge graph + dashboard; heavy on tokens | 2026-10-24 |
| 🟡 | [Graphify-Labs/graphify](understand-graphify-labs-graphify.md) | Code + docs + PDFs → knowledge graph to query; pushes paid cloud | 2026-10-28 |

### design-

| Fit | Repo | What it is | Last checked |
|---|---|---|---|
| 🟡 | [pbakaus/impeccable](design-pbakaus-impeccable.md) | Design taste skill, 24 commands, 62 "AI look" rules; first pick for web UI | 2026-10-24 |
| 🟡 | [nextlevelbuilder/ui-ux-pro-max-skill](design-nextlevelbuilder-ui-ux-pro-max-skill.md) | Generates a design system from a brief; landing pages | 2026-10-24 |

### agent-ops-

| Fit | Repo | What it is | Last checked |
|---|---|---|---|
| 🟢 | [ccusage/ccusage](agent-ops-ccusage-ccusage.md) | Token and cost report from local logs: `ccu monthly` (tried) | 2026-10-28 |
| 🟡 | [raine/workmux](agent-ops-raine-workmux.md) | Worktree + tmux window per agent task (Rust); if `claude --worktree` is not enough | 2026-10-23 |
| 🟡 | [agent-of-empires/agent-of-empires](agent-ops-agent-of-empires-agent-of-empires.md) | Agent manager: tmux sessions, worktrees, web view; overlaps our tmux bar | 2026-10-23 |
| 🟡 | [stablyai/orca](agent-ops-stablyai-orca.md) | Desktop app: agents side by side in worktrees, phone app | 2026-10-28 |

### agent-tools-

| Fit | Repo | What it is | Last checked |
|---|---|---|---|
| 🟡 | [morluto/rea](agent-tools-morluto-rea.md) | Reverse-engineering MCP: vendor libs, logic captures, .NET builds | 2026-10-21 |
| 🟡 | [lexmount/moli](agent-tools-lexmount-moli.md) | Headless browser for agents; only if Claude Code can't read JS-heavy pages | 2026-10-21 |
| 🟡 | [openqodex/openqodex](agent-tools-openqodex-openqodex.md) | Scanners + separate reviewer agent before `git push` | 2026-10-28 |
| 🟡 | [akitaonrails/ai-memory](agent-tools-akitaonrails-ai-memory.md) | Shared memory + handoff between agent CLIs (Rust) | 2026-10-28 |

### embedded-

| Fit | Repo | What it is | Last checked |
|---|---|---|---|
| 🟢 | [cunjun/McuBuddy](embedded-cunjun-mcubuddy.md) | Debug MCP: SVD registers, FreeRTOS tasks, RTT, HardFault; Keil-first | 2026-10-28 |
| 🟡 | [Adancurusul/embedded-debugger-mcp](embedded-adancurusul-embedded-debugger-mcp.md) | Probe-rs/OpenOCD debugger MCP: flash, RTT, HardFault triage | 2026-10-28 |
| 🟡 | [okhsunrog/flashprobe-mcp](embedded-okhsunrog-flashprobe-mcp.md) | Flash + bounded log capture MCP; very new, watch | 2026-10-23 |
| 🟡 | [Klievan/jlink-mcp](embedded-klievan-jlink-mcp.md) | J-Link/OpenOCD MCP, one-call crash report | 2026-10-28 |
| 🟡 | [nimaltd/ternima](embedded-nimaltd-ternima.md) | Serial/RTT/SWO terminal + Modbus tester (Rust); human tool | 2026-10-28 |

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

## Scan log

Written by `/scout` after each scan the user approves. "New since" for the
next scan of a topic is its last date here.

| Date | Topic | Level | Found | Notes added |
|---|---|---|---|---|
| 2026-10-28 | embedded | 2 | ~35 repos, 6 kept | McuBuddy, ternima, jlink-mcp |
| 2026-10-28 | agent | 1 | ~45 repos, 9 kept | security-audit-skill, andrej-karpathy-skills, BeautifulRust, openqodex, ai-memory, graphify, orca |
