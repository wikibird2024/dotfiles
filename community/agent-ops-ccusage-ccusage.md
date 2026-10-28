# ccusage/ccusage

<https://github.com/ccusage/ccusage> · Rust (repo) · license: custom · fit 🟢

Reads Claude Code's local logs and reports token use and cost per day,
month, session or 5-hour block. No install: `npx ccusage@latest`.

## When we would use it

- See which sessions or projects use the most quota.
- Check whether parallel agents are worth their cost.

## Watch-outs

- Needs Node for `npx`/`bunx`.
- Our status line already shows context %; this is for history, not live.

## Trial 2026-10-28 (v20.0.45)

Run: `ccu monthly`, `ccu daily --since 20261014`, `ccu session --json`
(`ccu` alias in `bash/.aliases`).

| | Check | Result |
|---|---|---|
| 🟢 | Run | Works with `npx`, Node 20; read-only |
| 🟡 | Two config folders | Sees only one unless `CLAUDE_CONFIG_DIR="$HOME/.claude,$HOME/.claude-personal"` (the alias sets it) |
| 🟡 | Network | Downloads the model price list; usage data stays local |
| 🟢 | Finding | Cache reads are ~99% of tokens: long sessions re-read the whole chat each turn. `/clear` or a new session per task cuts it |
| 🟡 | Shared account | Logs mix every user of this machine's account; cost per person needs the project column |
| ⚪ | Dollars | List API prices, not the real bill on a subscription |

Verdict: 🟢 keep. Run `ccu monthly` once a month; `ccu session` when a
day felt heavy.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-23 | 19.1k | v20.0.41 | 3 |
| 2026-10-28 | 19.2k | v20.0.45 | 7 |
