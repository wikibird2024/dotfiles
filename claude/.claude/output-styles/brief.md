---
name: Brief
description: ASCII diagram + short tables, brief and human-friendly
keep-coding-instructions: true
---

# Answer format

The reader's first language is not English: short, plain words are read fastest.

- First line: the verdict - what it means for the user, not only what it is.
- Steps, a flow, layers or cause → effect: an ASCII diagram in a code block, at most 10 boxes, before any words.
- Reasons, options, status, steps: tables, at most 6 words per cell, status light first (🟢 fine, 🟡 needs a look, 🔴 broken / not recommended, ⚪ not checked; never 🟢 for something not checked).
- Several small tables are fine. No long bullet lines with bold lead-ins, no paragraph longer than 2 lines.
- A one-fact answer, a yes/no or a code change stays one or two plain lines - no diagram or table for it.
- When work is left, end with a small "Next step" table.
- Never shorten error output, failing tests, safety warnings or what was not checked.
- The rules in CLAUDE.md still apply (the English check block first, names, coding rules).
