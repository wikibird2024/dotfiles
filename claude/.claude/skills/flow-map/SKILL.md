---
name: flow-map
description: Explain how a program or system runs as a picture the user can keep in their head - who runs (interrupts, threads, tasks, event loops, processes, services), the nested layers and state machines inside, how the parts talk, and one real example traced end to end with file:line. Use for "how does it run", "explain the flow", "mental model", "threads / tasks / processes", "nested flow", "who calls what", "trace X from A to B", "draw the architecture" - in any repo and language: firmware, desktop app, web tool, server, script, or a monorepo with several programs.
argument-hint: "[what to trace: a command, button, request, event] [scope: a program, folder or module]"
---

# Flow map

A way to present how software runs: the same pictures, in the same order, for
any kind of program. The user should be able to draw it from memory afterwards.

Arguments: `$ARGUMENTS`
- Something to trace (a command code, a button, a URL, a CLI command, an
  event) → it is the example in part 6, and the answer uses **trace mode**
  (see "Size").
- A scope (a program, folder or module) → map only that, but show where it
  sits in the whole (one line).
- Nothing → map the program the user is standing in and trace its most
  typical job. Say which job you picked.
- The named thing does not exist → pick the closest real one and say so in
  the first line. The same job has two entry paths (GUI and CLI, button and
  API) → trace one, name the other in one line.

## Rules

- **Read only.** No edits, builds, runs or commits.
- **Every name, period, priority and line number comes from reading the code
  in this session.** Not found → ⚪ "not checked". Never guess a line number.
  Get line numbers with `grep -n` or one file per `cat -n` / read, so
  `file:line` is exact.
- **Periods and timeouts come from the code; how long things really take
  usually does not** → ⚪, unless the code measures or logs it (point there).
- **Library and framework internals** (the RTOS kernel, Qt, uvicorn, the
  browser) are not read: draw them as one box marked ⚪ "framework".
- **Another program** (the other end of a wire): one hop only — the handler
  it reaches, with `file:line`. No inner map of it.
- **Show the code's real order**, not a tidier one.
- **Use the system's own words** (task, thread, slot, coroutine, worker,
  ISR) and the project's names; add a plain word in brackets when a term is
  not obvious.
- Follow the user's answer style if their `CLAUDE.md` gives one; it overrides
  the format below where they differ.

## Steps

### 1. Learn the project
Read `CLAUDE.md` / `README*` / an architecture doc if present. Note the
programs in the repo, their layer rules and any ownership rule ("only X
writes Y"). Decide the scope (arguments, or the program you stand in).

### 2. Find who runs
List every **execution context** in scope: hardware interrupts, signal
handlers, OS threads, RTOS tasks, event loops, async tasks / coroutines,
worker pools, child processes, other programs. For each: what starts it,
what wakes it (a period, an event, bytes, a click), its priority if it has
one. Platform hints and concurrency traps:
[references/where-to-look.md](references/where-to-look.md).

### 3. Read the backbone
For each context, open its entry point and list what it does in **code
order**: the loop body, the tick, the event dispatch, the handler chain.
This is the spine of picture 3.

### 4. Find the nesting
Nest by **who calls whom**, top to bottom. Common shapes:

| Kind | Typical levels |
|---|---|
| Machine / firmware | decider (top state machine) → units (stations, axes) → leaf drivers → ISR / hardware |
| Desktop / GUI | event source (click, timer) → controller / poller → worker → transport → fan-out to views |
| Server / web tool | request or job → handler → service / runner → session / repository → wire or database |

For each state machine: its states, its sub-steps (mini steps, phases) and
who writes them. No real state machine → nest by call depth and list the
state flags (busy, connected, mode) in one line.

### 5. Find how they talk, and trace one example
- Down: direct calls, requests, commands.
- Up: return values, getters, callbacks, signals, report structs, a
  "version" counter a UI polls.
- Across contexts: queues, channels, rings, atomics, locks, queued signals,
  IPC, sockets, HTTP, files.
- A value written by two contexts is a finding only if it is really unsafe
  for that platform (see the traps in the reference: e.g. Python `+=` is
  unsafe, a plain assignment is not).

Then trace the example from its first byte or click to its result and back,
naming the context and `file:line` at every hop.

## Answer: the nine parts

1. **The model in one sentence**: who cuts in or runs beside whom, what is nested.
2. **Picture 1, the building**: one box per *floor* (a kind of context).
   With priorities (ISR over task, RTOS priorities), higher floors **cut
   into** lower ones; say so. Without (threads beside an event loop, Python
   threads), floors **run side by side**: order them by what wakes them
   (bytes, period, job, user) and draw arrows for who posts to whom and who
   can block whom. Each line: `trigger → entry function : job`. Several
   programs → **picture 0** first: programs as boxes, the wires between them
   (USB, TCP, HTTP), how replies are matched.
3. **Picture 2, time**: one row per context over one typical period (a tick,
   a poll), or, for a job that is not periodic, one short window of the
   example. Then a table: wakes on / job / owns which state / can it block
   the others.
4. **Picture 3, the nest**: a tree of one backbone pass, numbered ①②③ in
   code order, each level indented under its caller, state machines with
   their states and sub-steps under them.
5. **Picture 4, how they talk**: commands down on the left, news up on the
   right, mailboxes / queues / locks across contexts in the middle; then a
   3-row rules table: down, up, across.
6. **One example through every floor**: the trace as a timeline, the
   context in the left margin, `file:line` at each hop. A hop that repeats
   one already shown → "(same hops as above)".
7. **Analogy**: one everyday picture that fits this system (factory,
   restaurant, dispatch office, orchestra): code → analogy, only for parts
   that exist.
8. **Watch out** (only if found): one line each, a light, `file:line`, no
   fixes. 🔴 broken, 🟡 risky, ⚪ "design note" (correct but surprising).
   Look especially for: two unsafe writers; a **blocking call on the
   GUI / event-loop / busy thread**; a wait with no timeout; an unbounded
   queue; a failure the user is never told about.
9. **Next step**: "draw picture 3 from memory, then check it against
   `<backbone file:line>`", or the next thing worth mapping.

## Size

- **Full map** (no argument, or a scope): all nine parts, about two screens
  (picture 0 included). Few contexts (3 or fewer) → merge pictures 1 and 4.
- **Trace mode** (an argument names one thing to trace): parts 1, 4 (the
  nest), 6, 8, 9; add picture 1 only if more than one context takes part.
- Tiny program (one thread, no state machine): parts 1, 4, 6, 9, and say
  in one line that the other pictures would be empty.

Pictures are ASCII in code blocks, tables have short cells.
