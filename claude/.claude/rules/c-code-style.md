---
paths:
  - "**/*.{c,h}"
---

# C code style (firmware)

Default style for the team's own C code in every firmware project. A
project's own `CODE_STYLE.md` or `CLAUDE.md` wins where it differs (folder
layout, its own words, known exceptions). C++ (Qt PC tools) keeps Qt's own
style (camelCase). Generated code (CubeMX) keeps its style; only `USER CODE`
blocks are ours, and they follow the comment rules below.

Layout (braces, indent, line length, alignment) is decided by `.clang-format`
and names are checked by `.clang-tidy` (`readability-identifier-naming`, shown
live by clangd). Both come from `dotfiles/templates/embedded-firmware/`. Run
them; don't argue with them.

## File layout

- No file header banner (no copyright box, no "File Name:").
- Header guard: the file name in capitals, `STEP_GEN_H`.
- Own header first, then project headers, then standard headers.
  `SortIncludes` is off, so the order is kept by hand.
- Static helpers before the public functions that use them.

## Naming

One style for every name we write: **snake_case**, except the public
function (`Module_Verb()`) and constants (capitals). The prefix of a public
function is the module, so a reader sees at once where it lives.

| Kind | Pattern | Example |
|---|---|---|
| Public function | `Module_Verb()` | `Settings_Get()`, `Update_IsActive()` |
| Static function | `snake_case` | `pop_byte()`, `find_index()` |
| Static variable | `s_` + snake_case | `s_rx_head`, `s_is_active` |
| Global variable | `g_` + snake_case (rare) | `g_fw_ver`, `g_serial_number` |
| Local variable, parameter, struct field | snake_case | `timeout_ms`, `step_channel` |
| Type | snake_case + `_t` | `uart_ring_t`, `update_status_t` |
| Macro, enum value | `MODULE_` + capitals | `FLASH_APP_START_ADDR`, `SETTINGS_STORE_SAVE` |
| Protocol opcode | `PROTO_CMD_` + capitals, same name in firmware and PC tool | `PROTO_CMD_GET_VERSION` |
| File | `lower_snake_case.c/.h` | `step_gen.c` |
| Lib folder | `PascalCase` | `Libs/StepGen`, `Libs/PCA9535` |

Why one style and not "camelCase in Libs, snake_case elsewhere": a Module
uses a Lib's struct (`ring->rx_head`) in its own code, so a split mixes both
styles in one file, and moving a file between `Libs/` and `Modules/` would
force a rename.

- Say what it is: no `data`, `info`, `tmp`, `flag` alone.
- Units in the name: `timeout_ms`, `speed_um_per_s`, `PROCESS_TICK_MS`.
- Booleans read as yes/no: `is_homed`, `has_tray`.
- A pointer to an item is named after the item:
  `axis_t *axis = &s_axis[id];`, never `a` or `p`.
- Only common short forms (`id`, `len`, `max`, `ms`, `rx`, `tx`, `crc`);
  plain loop counters may be `i` / `j`.
- One meaning per word, the same in firmware, PC tool, spec and UI. A
  position or speed always carries its unit: `get_position_steps` /
  `get_position_um`. A project lists its own words in its `CODE_STYLE.md`.
- Names from outside (HAL, registers, datasheet, schematic nets) keep their
  own spelling.

## Code

- Braces always, also for a one-line `if` (`InsertBraces` adds them).
- 4 spaces, no tabs. CubeMX files keep their 2 spaces.
- Unsigned literals carry `U`: `0U`, `128U * 1024U`.
- `bool` / `true` / `false` from `<stdbool.h>`.
- Fixed-size types from `<stdint.h>`, never plain `int`.
- Frames and records on the wire or in flash: packed structs with a
  `_Static_assert` on the size, so a moved field breaks the build.
- No magic numbers in code: give the value a `#define` with its unit.
- A value written by one task and read by another has one writer; say which
  in a comment next to it.

## Comments

- `/* */` only, no `//` (also `/* clang-format off */`).
- New comments in English, plain words, short sentences. Vietnamese comments
  already in a file stay; match the file you edit.
- Several lines: text lines indented 3 spaces, no `*` column.

  ```c
  /* Erases the app info sector, then writes size, CRC32 and the checksum
     byte in that order. The checksum goes last, so a power cut while writing
     leaves a record that cannot pass validation. */
  ```

- Say **why** and the limits (a concurrency rule, a unit, a hardware quirk),
  not what the line already says. One or two lines, not a paragraph.
- A public function gets its comment in the `.h` (what it does, what it
  needs, what it blocks). The `.c` comments only the steps that are not
  obvious.
- No history ("was removed", "old version did"): git keeps that.
- No Doxygen tags (`@brief`, `@param`).
