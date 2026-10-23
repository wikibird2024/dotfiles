---
paths:
  - "**/*.ioc"
  - "**/*.{c,h,s}"
  - "**/*.ld"
  - "**/CMakeLists.txt"
  - "**/*.cmake"
---

## STM32CubeMX projects (any project with a `.ioc`)

Goal: the `.ioc` stays the only source of truth for hardware setup, so a
regenerate never loses or fights hand-made code. Strict: applies to the AI
and to code the user asks for.

- **If CubeMX can set it, CubeMX sets it.** Pins and User Labels, GPIO mode,
  clock tree, peripheral settings (UART, TIM, I2C, SPI, ADC, DMA...), NVIC
  enable and priority, FreeRTOS/USB/other middleware config, HAL module
  enables, `MX_*_Init`, MSP init, startup and linker files.
- **Never write that by hand**, not in generated files and not as a copy
  elsewhere: no `HAL_NVIC_SetPriority`, `HAL_GPIO_Init`, peripheral `Init`
  structs or register set-up in user code; no `GPIO_PIN_x` / `GPIOx` outside
  the generated `main.h` names; no hand edits of the `.ioc` text.
- **When a change needs CubeMX:** stop, tell the user exactly what to set in
  the CubeMX GUI (page → setting → value), let them regenerate, then check
  `git diff` and build. Don't work around it in code.
- **Allowed:** code inside the `USER CODE BEGIN/END` blocks CubeMX already
  emits (never invent a new block name), and hand edits a project's
  `CLAUDE.md` lists by name. Any new exception must be added to that list.
- **Found existing hand-made set-up code?** Report it with `file:line` and
  what CubeMX setting should replace it; don't move it unasked.
