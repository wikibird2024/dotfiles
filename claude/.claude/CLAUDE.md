# Global rules for all projects

These rules apply to every project. A project's own `CLAUDE.md` adds project
facts (pins, protocol, build commands) and its casing style; it does not
replace these rules unless it says so explicitly.

## Naming and wording

Goal: a name should be clear to a new reader without asking. "Good enough and
clear" beats "clever and short". Applies to code names, UI text, log messages,
comments and docs. New code follows it; existing code is renamed only when
the user asks.

- **Plain words, little jargon.** Prefer the everyday word (`stop`, `start`,
  `end`, `find`) over a fancy one (`terminate`, `initiate`, `destination`,
  `locate`). Use a technical term only when it is the normal name in the
  field (`encoder`, `checksum`, `debounce`, `payload`) - don't stack them.
- **Say what it is or does.** Avoid empty names: `data`, `info`, `value`,
  `handle`, `process`, `manage`, `flag`, `tmp`, `misc`.
- **Common short forms only.** `id`, `min`, `max`, `ms`, `usb`, `gpio`,
  `rx`/`tx` and similar are fine. Don't invent new ones (`op`, `req`, `tgt`,
  `spd`); write the word.
- **Booleans read as yes/no**: `isHomed`, `hasTray`.
- **Units in the name** when a number has one: `timeoutMs`, `speedSps`.
- **One word per idea**, the same in firmware, PC tool, spec and UI.
- Names from outside the code (HAL, datasheets, registers) keep their own
  spelling.
