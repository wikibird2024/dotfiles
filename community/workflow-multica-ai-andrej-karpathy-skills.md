# multica-ai/andrej-karpathy-skills

<https://github.com/multica-ai/andrej-karpathy-skills> · Markdown · **no license** · fit 🟢

One `CLAUDE.md` with 4 rules taken from Andrej Karpathy's post on LLM
coding mistakes: think before coding (say assumptions, ask, push back),
simplicity first, surgical changes (don't touch unrelated code or
comments), goal-driven work (tests first, checkable success).

## When we would use it

- Read it once and diff it against our `~/.claude/CLAUDE.md`: most of it is
  already there ("How I work", "Keep changes small"). Copy only the missing
  lines, in our own words.

## Watch-outs

- No license: don't copy its text verbatim into the public dotfiles.
- README advertises the author's own product (Multica).
- Last push 2026-04-20: finished, not maintained.

## Trial 2026-10-28

Read its `CLAUDE.md` (65 lines) and diffed it against our global
`claude/.claude/CLAUDE.md`.

| | Rule | Result |
|---|---|---|
| 🟢 | Two or more readings of a request: list them, don't pick silently | Added, own words |
| 🟢 | Remove only what your change made unused; mention old dead code | Added, own words |
| 🟢 | Every changed line traces to the request | Added, own words |
| 🟢 | Each plan step names its check | Added, own words |
| ⚪ | Think first, simplicity, surgical edits, match style | Already in ours (How I work, Coding) and ponytail |
| 🔴 | "Bias toward caution over speed" | Skipped: clashes with our speed-first rule |
| 🔴 | "No error handling for impossible scenarios" | Skipped: firmware fault and safety checks must stay |

Verdict: done. Nothing to install; re-read only if the file changes.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-28 | 225k | none | 138 |
