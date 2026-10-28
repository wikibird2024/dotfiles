# cloudflare/security-audit-skill

<https://github.com/cloudflare/security-audit-skill> · JavaScript/Markdown · MIT · fit 🟢

Skill that turns the agent into a security auditor in 6 phases: map the
architecture and attack surface, hunters per area, a fresh verifier tries
to disprove each finding, findings as checked JSON (`confirmed`,
`needs_validation`, `rejected`), a second independent check, then a report.
Has hunting guides per area, including memory safety for native code
(C/C++) and supply chain. Runs add up: the next run targets gaps.

## When we would use it

- PC tools (C#/Python) and firmware with a USB/UART protocol parser: the
  native memory-safety guide fits C firmware.
- Compare with `/ponytail-audit` (quality) and `/security-review` (diff
  only): this one is a full, slow, many-agent security pass.

## Watch-outs

- Starts many subagents: costly in tokens. Run it on one repo, not often.
- Writes ledger and report files into the repo: run on a branch.
- Last push 2026-09-14; 99 open issues.
- ⚪ Code not read.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-28 | 50k | none (no releases) | 99 |
