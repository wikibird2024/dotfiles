# cunjun/McuBuddy

<https://github.com/cunjun/McuBuddy> · Python · MIT · fit 🟢

MCP server for board-level MCU debugging: ST-Link, J-Link and CMSIS-DAP
probes (pyOCD, J-Link, probe-rs experimental), run control, memory,
breakpoints, ELF/DWARF symbols for HardFault and stack overflow triage,
**CMSIS-SVD peripheral registers by name**, **FreeRTOS tasks and stack
use**, UART/RTT/SWO logs, flash. Tools come in groups you switch on
(`MCUBUDDY_TOOLSETS=probe,diagnose`); 19 tools by default.

## Ready to use (installed 2026-11-06)

1. Plug in a **bench board only**: no motors or machine powered.
2. Run `claude-board` instead of `claude`. Only that session starts McuBuddy.
3. Ask, for example: "connect and diagnose this HardFault".

Files: `claude/.claude/board-mcp.json` (server, toolsets, flash off),
`claude/.claude/board-settings.json` (blocked tools), alias in `bash/.aliases`.
Not global on purpose: each session would start its own 115 MB tool.
Install again: `uv tool install <mcubuddy-0.6.1 wheel from the release>`.

## When we would use it

- HardFault or "peripheral not doing anything": the agent reads `RCC`,
  `TIM`, `USART` registers by name instead of raw addresses.
- FreeRTOS firmware: task states and stack high-water marks without a GDB
  session.
- Compare with embedded-debugger-mcp (Rust, probe-rs) before picking one.

## Watch-outs

- **Its "memory write off" setting is not read-only (read in v0.6.1).** Only
  `probe_write_memory` checks it. `write_symbol_value`, `svd_write_register` and
  `svd_write_field` need just `confirm=true`, which the agent can send itself.
  `claude-board` blocks those, `set_local` and the `uart_*` senders in Claude Code.
- Halt, step and reset stay allowed: debugging needs them. Halting firmware stops
  its control loops with outputs as they are, so never use it on a powered machine.
- The block covers McuBuddy only: the agent's shell can still run `probe-rs` or
  `openocd`, the same as in any session.
- With our toolsets it offers 96 tools (88 after the block), not the default 19.
- Keil-first: build/download goes through `UV4.exe` (Windows). Our CubeMX +
  CMake builds don't use that part. ⚪ Linux support not checked.
- Writes flash and memory: bench boards only, never a machine in use.
- Very young (9 stars), one author; last push 2026-08-17.
- Flash **program is on** by default (memory write and flash erase are off):
  set `flash.allow_program = false` for a read-only first try.
- Its SKILL.md tells the agent to run `setup codex --repair --confirm` when
  tools are missing (self-install, Codex only). Use the MCP server, not the skill.
- Fork of SolarWang233/mcudbg (0 stars); last push 2026-08-17, near stale.

## Check (2026-11-03, commit 85d7f9a = v0.6.1)

Read: safety guards, config defaults, network and subprocess calls, install
paths, SKILL.md. Not every one of the 16k lines.

- No telemetry. Only network call: a Puya PY32 pack download, behind `confirm=true`.
- No `shell=True`; starts GDB server, probe-rs sidecar, Keil (Windows), `codex`.
- Writes `~/.mcubuddy/installations.json`; `~/.claude/skills/` only via its skill installer.
- Bench try: `MCUBUDDY_TOOLSETS=probe,diagnose,rtos,logs`, flash program off,
  MCP server only, bench board only.

## Check (2026-11-06, install)

- Release wheel matches tag v0.6.1 (commit 85d7f9a), plus its skill files.
- Tested in a Claude session with no board: server connects, blocked tools are gone.
- ⚪ Not tried on a real board or with our CMake builds yet. Linux probe use unproven.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-28 | 9 | v0.6.1 | 0 |
| 2026-11-03 | 9 | v0.6.1 | 0 |
| 2026-11-06 | 9 | v0.6.1 | 0 |
