# shanraisshan/claude-code-best-practice

<https://github.com/shanraisshan/claude-code-best-practice> · guide · MIT · fit 🟢 reference

Collected tips from Anthropic staff and power users. Most useful for us:

- Keep CLAUDE.md short (< ~200 lines); move rules that only apply to some
  files into `.claude/rules/*.md` with `paths:` frontmatter.
- Stay under ~40% context; `/compact <focus>` or `/clear` instead of
  waiting for auto-compact; `/rewind` instead of correcting in a messy
  context.
- Skills: description written as a trigger, a Gotchas section, folders with
  `scripts/` and `references/`.
- Hooks: PostToolUse = format, Stop = run the check before finishing.

## Watch-outs

- Tips age fast; confirm against the official docs
  (<https://code.claude.com/docs/en/best-practices>).

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-23 | 67.9k | none | 27 |
