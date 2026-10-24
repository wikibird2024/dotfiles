# Adancurusul/embedded-debugger-mcp

<https://github.com/Adancurusul/embedded-debugger-mcp> · Rust · MIT · fit 🟡

MCP server + CLI + Claude Code skill for on-target debugging over probe-rs or
OpenOCD: probe discovery, connect, halt/run, memory read/write, breakpoints,
flash, RTT, and HardFault ("crash") diagnosis. ARM Cortex-M, RISC-V, ESP32.
Release checks include an STM32 demo board.

## When we would use it

- Let Claude flash the board, read RTT logs and registers itself, so it can
  check a firmware change on the bench instead of asking us.
- HardFault triage: read fault registers and the stack after a crash.

## Watch-outs

- Build from source (`cargo build --release`); review the code first: it
  drives a real probe attached to real hardware.
- Writes to flash and memory: keep it for bench boards, not machines in use.
- Small project (one main author, last release 2026-07).
- Check it works with our ST-Link and with OpenOCD for STM32F7.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-23 | 207 | v0.3.0 | 3 |
