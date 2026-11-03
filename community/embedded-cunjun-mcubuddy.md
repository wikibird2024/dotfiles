# cunjun/McuBuddy

<https://github.com/cunjun/McuBuddy> · Python · MIT · fit 🟢

MCP server for board-level MCU debugging: ST-Link, J-Link and CMSIS-DAP
probes (pyOCD, J-Link, probe-rs experimental), run control, memory,
breakpoints, ELF/DWARF symbols for HardFault and stack overflow triage,
**CMSIS-SVD peripheral registers by name**, **FreeRTOS tasks and stack
use**, UART/RTT/SWO logs, flash. Tools come in groups you switch on
(`MCUBUDDY_TOOLSETS=probe,diagnose`); 19 tools by default.

## When we would use it

- HardFault or "peripheral not doing anything": the agent reads `RCC`,
  `TIM`, `USART` registers by name instead of raw addresses.
- FreeRTOS firmware: task states and stack high-water marks without a GDB
  session.
- Compare with embedded-debugger-mcp (Rust, probe-rs) before picking one.

## Watch-outs

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

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-28 | 9 | v0.6.1 | 0 |
| 2026-11-03 | 9 | v0.6.1 | 0 |
