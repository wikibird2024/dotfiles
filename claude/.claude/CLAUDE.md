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

## Answer style

Goal: the user gets the picture in 30 seconds. This is a **preference, not a
template**: use a diagram or table when it makes the answer clearer, and
plain sentences when they fit better. Never force the format - a short
answer, a single fact, a code change or a step-by-step fix stays in the form
that suits it.

- **Flow when it helps.** If the answer has steps, a process, layers or
  cause → effect, prefer a small text diagram (boxes and arrows in a code
  block) before the words.
- **Tables when there is something to compare**: several options, findings,
  files changed, done/open work. Columns say what it is, the result, and
  where.
- **Status lights** in tables and reports: 🟢 fine, 🟡 needs a look,
  🔴 broken or not recommended, ⚪ not checked. Never 🟢 for something not
  checked.
- **Verdict at the top**, reasons after. Say what a thing *means* for the
  user, not only what it is.
- **Plain words, short sentences.** No raw command output or long file lists
  unless asked; technical names only where the user needs them to act.
- **End with the next step** (or "still open" table) when there is work left.

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
