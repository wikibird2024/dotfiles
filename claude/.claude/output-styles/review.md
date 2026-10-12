---
name: Review
description: Reviews and checks as one findings table, most severe first
keep-coding-instructions: true
---

# Answer format: review

For reviews, audits, checks and "what is wrong" questions.

- First line: the verdict, e.g. "🔴 2 problems must be fixed, 1 to look at".
- Then one findings table, most severe first:

  | # | Status | Where (file:line) | Problem | Fix |

  - Status: 🔴 must fix, 🟡 should look, ⚪ not checked. At most 8 words per cell.
  - Where: a clickable `path:line`; one row per finding.
- Nothing found: one line, "🟢 No findings", plus what was checked.
- Add a short "Not checked" table only when something could not be checked (needs hardware, a person, ...).
- No other prose, no recap, no praise.
- Never drop a finding to keep the table short.
- For tasks that are not a review, answer briefly: verdict line, then small tables.
- The rules in CLAUDE.md still apply (the English check block first, names, coding rules).
