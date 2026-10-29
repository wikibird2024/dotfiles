---
paths:
  - "**/*.{c,h,s}"
  - "**/*.{cpp,hpp}"
---

## Firmware checks (reviews and changes in embedded C/C++)

When writing or reviewing firmware, look for these on top of normal bugs:

- data shared by an ISR and the main loop or a task with no `volatile`, or a
  multi-byte value read with no critical section
- a blocking call (`HAL_Delay`, `printf`, `malloc`, a wait loop) in an ISR or
  a high-priority task; a wait with no timeout
- tick math that breaks on wrap (use `now - start >= timeoutMs`)
- a buffer index from received bytes not checked against the size
- the watchdog fed while the real work is stuck
- CubeMX-generated code edited outside `USER CODE` blocks (lost on regenerate)
- a safety limit removed or weakened (emergency stop, stall or travel limit,
  link watchdog, safe outputs on a fault): always a must-fix finding
