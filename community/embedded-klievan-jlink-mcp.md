# Klievan/jlink-mcp

<https://github.com/Klievan/jlink-mcp> · TypeScript · MIT · fit 🟡

MCP server for SEGGER J-Link, OpenOCD and Black Magic probes: flash, halt,
memory, RTT. Its `diagnose_crash` tool decodes fault registers
(CFSR/HFSR), unwinds the exception frame, names the faulting PC and pulls
the matching RTT log lines, all in one call. Demo runs on an nRF52840-DK.

## When we would use it

- Only if we use J-Link probes, or if its one-call crash report beats
  McuBuddy and embedded-debugger-mcp. OpenOCD support covers ST-Link ⚪.

## Watch-outs

- Same job as embedded-debugger-mcp (Rust) and McuBuddy: pick one MCP.
- Node.js runtime.
- Writes flash: bench boards only.
- ⚪ Code not read.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-28 | 39 | v0.8.0 | 3 |
