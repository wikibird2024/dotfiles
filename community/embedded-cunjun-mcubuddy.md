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
- ⚪ Code not read yet: run `/scout check cunjun/McuBuddy` first.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-28 | 9 | v0.6.1 | 0 |
