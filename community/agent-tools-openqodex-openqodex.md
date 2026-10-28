# openqodex/openqodex

<https://github.com/openqodex/openqodex> · TypeScript · Apache-2.0 · fit 🟡

Code review before `git push`: first runs scanners that fit the changed
files (gitleaks, semgrep, ...), then starts separate Claude Code or Codex
reviewer processes on your own login (the agent that wrote the code does not
review it by default). Report page with findings; optional push gate hook.
Also builds a code graph for the agent.

## When we would use it

- If `/code-review` and `/ponytail-review` miss things: a reviewer that
  doesn't share the writer's context.

## Watch-outs

- `npx openqodex init` writes hooks and files for every agent it finds and
  downloads scanners: read the file list it shows before saying yes.
- Push gate overlaps our `ripsecrets` pre-commit hook (gitleaks does the
  same job).
- Uses our Claude quota for each review.
- Node 22+; no Windows tests. 78 open issues, young (2026-10-02).
- ⚪ Code not read.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-28 | 919 | 0.15.0 | 78 |
