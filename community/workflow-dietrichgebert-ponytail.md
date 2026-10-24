# DietrichGebert/ponytail

<https://github.com/DietrichGebert/ponytail> · JavaScript/Markdown · MIT · fit 🟢

"The laziest senior dev": one skill prompt that makes the agent write only
what the task needs: reuse what the repo already has, no new libraries
without reason. It never cuts validation, error handling, security or
accessibility. Risky logic (branches, parsers, money, security) leaves one
small test. Every reply ends with what was skipped or not checked.

## When we would use it

- Matches our global rules (small changes, done means checked): try it to
  see if it adds anything on top.
- `/ponytail-review` (diff review, reads the code around it) and
  `/ponytail-audit` (whole repo, ranked).
- No plugin needed: copy `AGENTS.md` or `skills/ponytail/SKILL.md` and read it.

## Watch-outs

- The plugin is on in every session and adds a "band" above the prompt and
  hooks; it could clash with our status line.
- Writes `shortcut:` comments into code unless told not to in CLAUDE.md.
- Benchmark numbers (-53% code, -26% cost) are the author's own.
- Only install from `DietrichGebert/ponytail` (the author warns about fake copies).

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-24 | 175k | v5.3.2 | 109 |
