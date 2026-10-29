# tt-a1i/archify

<https://github.com/tt-a1i/archify> · JavaScript · MIT · fit 🟢

Agent skill that turns an idea, a plan or a repo into one interactive HTML
diagram, or an "explainer" page (answer first, one panel per question, steps
next to the diagram, sources pinned to a commit). Light/dark themes, export
to PNG/PDF.

## When we would use it

- Firmware flows (ISR → task → state machine) as a picture to share with
  the team. Compare with our own `flow-map` skill before switching.
- One-page answers for a design question or a bug write-up.

## Watch-outs

- `npx skills add tt-a1i/archify -g` installs globally.
- README is full of sponsors (API resellers); ignore those links.
- Check how it reads C / CubeMX code: the demos are web stacks.
- Alternative: [QingYunA/answer-me-with-html](https://github.com/QingYunA/answer-me-with-html)
  (MIT, 4.6k stars, 2026-10-29) does explainer pages with the agent writing
  only Markdown; a bundled Node CLI draws the page (~8× fewer output tokens,
  its own bench). Compare if archify's page cost hurts. Its suggested install
  ("paste this URL into your agent and follow it") is a red flag: install by
  hand.

## Our install

Installed 2026-10-24 at commit `25cf370` (v3.2.0, code read first):

```bash
git clone --depth 1 https://github.com/tt-a1i/archify ~/.local/share/claude-skills/archify
ln -s ~/.local/share/claude-skills/archify/archify ~/.claude-personal/skills/archify
ln -s ~/.local/share/claude-skills/archify/archify ~/.claude/skills/archify
```

Update: `git -C ~/.local/share/claude-skills/archify pull` (read the diff
first). Remove: delete the two links and the folder.

## Trial 2026-10-24 (v3.2.0)

Task: workflow diagram of `theme <name>` (theme/.local/bin/theme `switch`).

| | Check | Result |
|---|---|---|
| 🟢 | Load | `ln -s ~/try/archify/archify ~/.claude-personal/skills/archify`; seen live, no restart |
| 🟢 | Correct | Every node cites file:line; steps match the script |
| 🟢 | Checks | validate, deliver, check passed on the first draft |
| 🟡 | Browser check | Needs Chrome/Chromium (`ARCHIFY_CHROME`); only Firefox here |
| 🟡 | Node `tag` | Not drawn on the box: fallback notes were hidden |
| 🟡 | Legend | Generic names ("Agent logic", "Policy") unless `meta.legend` is set |
| 🟡 | Effort | ~500 lines of rules and schema read before the first draft |

Verdict: good for diagrams to share; for a quick look in the terminal,
`flow-map` is faster.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-24 | 88k | v3.2.0 | 289 |
