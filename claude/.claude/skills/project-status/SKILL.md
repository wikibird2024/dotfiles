---
name: project-status
description: Report the current state of the git repo you are in - git state, whether it builds, whether tests pass, open work (TODOs, planned items in the docs) - and suggest what to work on next. Use when the user asks for repo status, project status, "where are we", "what's left", or "what should I work on next". Works in any repo.
argument-hint: "[quick] [detail] [page] [focus area]"
---

# Project status report

Give the user a short, honest picture of the repo they are in, and one
suggested next step. **Read only**: do not edit, commit, stash or clean
anything. Building and running tests is allowed (they only write build
output).

Arguments: `$ARGUMENTS`
- `quick` → skip the build and the tests (steps 3 and 4), say so in the report.
- `detail` → after the normal report, add the technical list (see "Detail
  section" below).
- `page` → also publish the report as a visual web page (see "Page version").
- Any other text is a focus area (a module, folder or topic): look at it
  closer and put it first in the report.

## 0. Pick the right repo

Report on the folder we are standing in now: run `pwd`, then
`git rev-parse --show-toplevel` to find the repo that contains it, and report
on that whole repo. If `pwd` is a sub-folder of the repo (for example the
app half of an app/boot repo), use that sub-folder's `CLAUDE.md`, build and
tests, and put it first in the report; mention the rest of the repo briefly.
If the folder is not inside a git repo, report on the
folder itself and mark "Saved in git" as ⚪ (not a git repo). If the user
named a path or project in the arguments, use that instead.

## 1. Learn the project

Read, if present: the repo's `CLAUDE.md` (and any in sub-folders you work in),
`README*`, and the docs index (`Docs/`, `docs/`). From them, note:
- the documented build command and test command,
- any plan / roadmap / phase list / "known issues" / "optimize later" list,
- limits worth checking (for example flash/RAM size on firmware).

If nothing is documented, find the build system yourself (`CMakePresets.json`,
`CMakeLists.txt`, `Makefile`, `Cargo.toml`, `package.json`, `pyproject.toml`,
`*.pro`, ...) and use its normal command.

## 2. Git state

- `git status --short` and the current branch
- `git log --oneline -10`
- commits not pushed: `git log --oneline @{u}..` (skip if there is no upstream)
- stashes: `git stash list`

## 3. Build (skip with `quick`)

Run the documented build command. Report pass/fail, the first real error if it
fails, and any size or memory summary it prints. Warn when a limit is above
90% used. If a build would take long or needs hardware or credentials, don't
run it: say so and give the command.

## 4. Tests (skip with `quick`)

Run the documented test command. Report counts and the names of failing
tests with the first line of each failure. If there are no tests, say so.

## 5. Open work

- Open items in the plan/roadmap lists found in step 1 (quote the item, link
  the file and line).
- `TODO`, `FIXME`, `HACK`, `XXX` in source (skip vendor, generated and
  build folders, and anything a `CLAUDE.md` marks as frozen or generated).
  Give the count and the most important few, not all of them.
- Uncommitted work from step 2 that looks unfinished.

## Report format

Write for a person who wants the picture in 30 seconds, not a log. Plain
words, short sentences, no raw command output, no long file lists. Say what a
thing *means* ("the vim changes are not saved in git yet"), not only what it
is (" M vim/.vimrc"). Technical names only where the user needs them to act.

Use this layout, in this order:

```
## <repo name> - <one-line verdict in plain words>
`<full path of the repo>` · branch `<branch>`

<one or two sentences: how the project is doing overall and why>

| | Area | In short |
|---|---|---|
| 🟢/🟡/🔴/⚪ | Build | ... |
| 🟢/🟡/🔴/⚪ | Tests | ... |
| 🟢/🟡/🔴/⚪ | Saved in git | ... |
| 🟢/🟡/🔴/⚪ | Open work | ... |

<only if the project has size/memory limits:>
Flash  ███████████████░░░░░  76%  (30.9 of 40 KB)
RAM    ██████████████░░░░░░  71%  (11.6 of 16 KB)

### What's going on
<2-4 bullets, plain words, one idea each: work in progress, what changed
lately, anything surprising>

### Next step
<one action, and one sentence on why it comes first>
```

Rules:
- Lights: 🟢 fine, 🟡 needs a look soon, 🔴 broken or blocking, ⚪ not checked
  (for example build and tests under `quick`). Never use 🟢 for something you
  did not check.
- Bars: 20 cells, `█` used and `░` free, rounded to the nearest 5%. Add
  ⚠️ after the bar when above 90%.
- When uncommitted work falls into separate topics, name the topics ("vim
  rework", "Claude setup"), not the files.
- Keep the whole report on one screen: about 25 lines.
- Link files as `path:line` only in the "Next step" and the detail section.

## Detail section (only with `detail`)

After the normal report, add `### Details` with the technical lists: changed
files per topic, recent commits, failing tests with their first error line,
TODO/FIXME count and top few with `path:line`, open plan items with
`path:line`.

## Page version (only with `page`)

Also publish the report as a page with the Artifact tool (load the
`artifact-design` skill first, as that tool requires). Same content and order
as the text report, drawn visually:
- a header with the repo name, branch, date and the one-line verdict,
- four status cards (Build, Tests, Saved in git, Open work) with the light
  colors,
- limit meters (flash/RAM or similar) as bars,
- uncommitted work as a small chart of changed files per topic,
- the "What's going on" bullets and the next step as a highlighted card.
Keep it private (the default), and put the text report in the reply too with
the page link.

Base the next step on what you found: a broken build or failing test first,
then unfinished uncommitted work, then the next item in the project's own plan.
If you did not run something, say so; never report a check as passing
without running it.
