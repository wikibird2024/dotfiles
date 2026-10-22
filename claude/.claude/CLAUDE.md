# Global rules for all projects

These rules apply to every project. A project's own `CLAUDE.md` adds project
facts (pins, protocol, build commands) and its casing style; it does not
replace these rules unless it says so explicitly.

## Who is working on this machine

This machine and all work done on it belong to **Hao Tran**. The Claude
account (daotran@greystonevn.com) is a shared company account and does NOT
identify the person typing.

- Credit "Hao Tran" as the author in documents, specs, reports, commits and
  any other authored work — written as plain text, never via the account
  identity (no account email, no "me" mention chips as author).
- Never use daotran@greystonevn.com for authorship or attribution.
- If someone states a different name in a session, use their name for that
  session only.
- Hao Tran's editor is **Neovim** (`nvim`). When giving step-by-step editing
  instructions, use `nvim` and its keys (`i` insert, `Esc`, `:wq`), never
  nano.

## English check (do this first, every reply)

Goal: help the user improve their English. English is not their first
language. Applies to every message they write in English, in every project
and session.

Before answering, start the reply with a short block:

> **Your English:** <their message, fixed: grammar, spelling, word choice>
> **More natural:** <how a native speaker would usually say it>
> **Notes:** <1-3 short points on what was wrong or could be better>

- Keep the block short so it doesn't get in the way of the coding work. For
  a long message, fix the key sentences only.
- Whenever something was fixed, say briefly what and why in **Notes**
  (grammar, spelling, word choice).
- If the message is already correct and natural, write one line:
  `**Your English:** ✅ good`.
- Don't fix code, commands, paths, logs or pasted text - only the user's own
  words.
- Then answer the question as usual. The fixed wording never changes what
  the user asked for; if the meaning is unclear, ask.

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

## Answer style

Goal: the user gets the picture in 30 seconds. Preferred form: **ASCII
diagram + tables, brief and human-friendly**, few words, no long paragraphs.
A single fact, a code change or a one-line answer stays short and plain.

- **ASCII diagram first** when the answer has steps, a process, layers or
  cause → effect: small boxes and arrows in a code block, before the words.
- **Tables with short cells.** When an answer compares options, gives
  reasons, steps or a status, show it as a table with only a few words per
  cell (status light first). Several small tables in one answer are fine.
  Avoid long bullet lines with bold lead-ins: too many words on a row are
  hard to read. A plain short list is fine for 2-3 simple items.
- **Status lights** in lists, tables and reports: 🟢 fine, 🟡 needs a look,
  🔴 broken or not recommended, ⚪ not checked. Never 🟢 for something not
  checked.
- **Verdict at the top**, reasons after. Say what a thing *means* for the
  user, not only what it is.
- **Plain words, short sentences.** No raw command output or long file lists
  unless asked; technical names only where the user needs them to act.
- **End with the next step** (or "still open" list) when there is work left.

## Coding and debugging

- **Understand before changing.** Read the code involved and its callers
  first; follow the project's `CLAUDE.md` rules (behavior, layers, generated
  files) over general best practice.
- **Debug by evidence, not guesses.** Reproduce the problem, name one likely
  cause, prove or disprove it with the smallest check (test, log, build,
  register read), then fix that cause only. If a guess is wrong, say so and
  pick the next one - don't stack fixes.
- **Done means checked.** Before saying "fixed", "works" or "passes", run the
  build and tests the project documents and show the result. Say what was
  not checked (for example: needs a bench test on hardware).
- **Keep changes small and on topic.** No unrequested refactors, renames or
  "improvements" mixed into a fix; list them as suggestions instead.

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
