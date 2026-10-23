# okhsunrog/flashprobe-mcp

<https://github.com/okhsunrog/flashprobe-mcp> · Rust · MIT · fit 🟡

Smaller MCP server: flash and capture logs only. probe-rs (SWD/JTAG + RTT,
defmt-aware) or espflash (UART). Log capture is bounded, so a chatty board
does not flood Claude's context.

## When we would use it

- If embedded-debugger-mcp is too much: just "flash, then show me the first
  N lines of log" as the agent's check step.

## Watch-outs

- Very new (created 2026-05, no release yet, 5 stars).
- Needs the probe-rs udev rules and the user in `dialout` for serial.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-23 | 5 | none | 0 |
