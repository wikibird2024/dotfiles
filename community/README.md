# Community repos to watch

Open-source repos worth checking from time to time: tools we may use, or
ideas to borrow before building our own. One short note per repo.

Maintained by Hao Tran. Not a stow package (not linked into `$HOME`).

## Index

| Repo | What it is | Fit for us | Last checked |
|---|---|---|---|
| [lexmount/moli](lexmount-moli.md) | Headless browser for AI agents (Rust) | 🟡 only if Claude Code can't read JS-heavy pages | 2026-10-21 |
| [morluto/rea](morluto-rea.md) | Reverse-engineering MCP for agents (TypeScript) | 🟡 for code with no source: vendor libs, logic captures, .NET builds | 2026-10-21 |

Fit: 🟢 use now · 🟡 may need it, watch · 🔴 not for us, kept for reference

## Note format

Each `<owner>-<repo>.md` has: what it is, when we would use it, watch-outs,
and a dated snapshot (stars, version) so the next check shows the trend.

Quick re-check of a repo:

```bash
gh repo view <owner>/<repo> --json stargazerCount,pushedAt
gh release list -R <owner>/<repo> -L 1
```
