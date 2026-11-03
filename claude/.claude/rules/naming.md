---
paths:
  - "**/*.{c,h,s,cpp,hpp}"
  - "**/*.{py,rs,lua,sh,cs,axaml,js,ts}"
---

# Naming and wording

Goal: a name should be clear to a new reader without asking. "Good enough and
clear" beats "clever and short". Applies to code names, UI text, log messages,
comments and docs. New code follows it; existing code is renamed only when
the user asks.

- **Plain words, little jargon.** Prefer the everyday word (`stop`, `start`,
  `end`, `find`) over a fancy one (`terminate`, `initiate`, `utilize`,
  `locate`). Use a technical term only when it is the normal name in the
  field (`encoder`, `checksum`, `debounce`, `payload`) - don't stack them.
- **Say what it is or does.** Avoid empty names: `data`, `info`, `value`,
  `handle`, `process`, `manage`, `flag`, `tmp`, `misc`.
- **Common short forms only.** `id`, `min`, `max`, `ms`, `usb`, `gpio`,
  `rx`/`tx` and similar are fine. Don't invent new ones (`op`, `req`, `tgt`,
  `spd`); write the word.
- **No one- or two-letter names** for pointers, locals or parameters (a
  mentor and senior found `a->motion`, `h->ch`, `p->...` hard to follow).
  Name a pointer to an item after the item: `SprayAxis_t *axis = &s_axis[id];`
  then `axis->motion`; `Conveyor_t *conveyor`, `Station_t *station`. A
  parameter that picks an item uses its typed id (`SprayAxisId_t id`), not a
  bare `uint32_t i`. Only plain loop counters keep `i` / `j` (BARR-C: names
  of 3+ characters that say what they hold).
- **Booleans read as yes/no**: `isHomed`, `hasTray`.
- **Units in the name** when a number has one: `timeoutMs`, `speedSps`.
- **One word per idea**, the same in firmware, PC tool, spec and UI.
- Names from outside the code (HAL, datasheets, registers) keep their own
  spelling.
