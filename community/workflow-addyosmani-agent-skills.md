# addyosmani/agent-skills

<https://github.com/addyosmani/agent-skills> · Markdown/JavaScript · MIT · fit 🟡

25 engineering skills plus 9 commands along the dev cycle: `/spec`
`/plan` `/build` `/test` `/constraints` `/review` `/webperf`
`/code-simplify` `/ship`. Same idea as Superpowers, but lighter, and you
can install one skill at a time.

## When we would use it

- Pick single skills instead of the whole pack:
  `npx skills add addyosmani/agent-skills --skill interview-me`
  (asks one requirement question at a time), `code-review-and-quality`,
  `test-driven-development`.
- Ideas for our own skills: quality gates, spec before code.

## Watch-outs

- `/review` clashes with the built-in command: use `/agent-skills:review`.
- Installing one skill leaves out the shared `references/` checklists (#361).
- Web-focused (`/webperf`, frontend skills); little for firmware.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-24 | 110k | 0.6.13 | 161 |
