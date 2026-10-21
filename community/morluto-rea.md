# morluto/rea

<https://github.com/morluto/rea> · TypeScript (npm `rea-agents`) · MIT · fit 🟡

"Reverse Engineer Anything": an MCP server that lets Claude Code drive
reverse-engineering tools (Ghidra/IDA/Hopper, sigrok, binwalk, tshark, JADX…)
and return findings with evidence. Also usable as a CLI (`rea`).

## When we would use it

- Decode logic analyzer captures (UART/I2C/SPI) — needs `sigrok-cli`.
- Look inside vendor `.a` / `.elf` with no source — needs Ghidra.
- Compare two builds of our C# / .NET tool — built in, no extra tools.
- Unpack third-party device firmware — needs `binwalk`.

Not for: our own firmware, where we have the source and a debugger.

## Watch-outs

- Needs Node ≥ 22.19 (this machine has v20).
- `npx rea-agents setup` edits Claude Code's config: review the diff.
- Pin the version (`npx rea-agents@6.7.0`), not `@latest`: one person owns
  the npm package.
- Star count (348k in 6 months) is unusually high; issues look machine-filed.
  Judge it by a real test, not by stars.

## Snapshot

| Date | Stars | Version | Open issues | npm downloads/week |
|---|---|---|---|---|
| 2026-10-21 | 348k | v6.7.0 | ~1,500 | ~416k |
