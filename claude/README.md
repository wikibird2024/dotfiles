# claude

Global instructions and skills for [Claude Code](https://claude.com/claude-code).

Stowed by `steps/04_stow.sh` (`stow -R -t ~ claude`). `04_stow.sh` creates `~/.claude/skills/` as a real folder first, so only
these files are linked and Claude Code's own data (credentials, history) never ends up in git.

| File | Purpose |
|---|---|
| `.claude/CLAUDE.md` | rules for every project (naming, wording, ...) |
| `.claude/rules/stm32-cubemx.md` | CubeMX rules; load only when Claude reads or edits a `.ioc`, C, assembly, linker or CMake file (`paths:` in its header) |
| `.claude/skills/project-status/SKILL.md` | `/project-status`: read-only report on the current repo (git, build, tests, open work) |
| `.claude/skills/flow-map/SKILL.md` | `/flow-map`: explain how a program runs (contexts, nesting, one example traced with `file:line`) |
| `.local/bin/claude-personal` | wrapper script isolating personal credentials to `~/.claude-personal` |
| `.local/bin/claude-stm32-build-check` | Stop hook: builds changed STM32 firmware before Claude may finish (see below) |

`~/.claude/settings.json` and `~/.claude-personal/settings.json` are **not** linked: Claude Code writes to them. A new machine gets a copy of `templates/claude/settings.json` once.

## Build check for STM32 firmware

Before Claude ends a turn, the Stop hook `claude-stm32-build-check` finds
every firmware folder (a `.ioc` next to a `CMakePresets.json`) with
uncommitted C/H/asm/linker/CMake changes and runs
`cmake --build --preset Debug` there (configuring `build/Debug` first if
needed). A failed build sends the compiler errors back, so Claude fixes them
instead of saying "done".

- Build only: no flash, no HEX copy (a project's `build.sh` may do more).
- Each change is checked once per session: unchanged files are not rebuilt,
  and a failure Claude was already told about does not block again.
- Errors in code Claude did not touch: it is told to report them, not fix them.
- Not a firmware folder, or no `jq`/`cmake`/`Debug` preset: no check, never a block.
- State: `~/.local/state/claude-stm32-build-check/` (one file per session and
  folder, cleared after 7 days).

The hook entry is in the template's `Stop` list; like the other hooks it must
be merged by hand into both live settings files.

## Agent state in the tmux bar

The [tmux-agent-signal](https://github.com/jward7/tmux-agent-signal) plugin
(installed by tpm, pinned in `tmux/.tmux.conf`) shows every Claude session's
state on its tmux window tab: 󰔟 working, 󰂚 blocked on a permission, 󰋗 asking
a question, 󰄬 finished while you were elsewhere. The right side of the bar
lists **every** Claude agent of every session, grouped by session:
`Dekit_grader_v1 ·  STM32F7_USB_spra… ·  dotfiles 󰔟`. The session name is
colored by its most urgent agent (yellow needs you, orange asks, green
finished unseen, cyan working, purple - the block's own color - all idle),
fenced by `│` and led by a solid purple `󰚩 AI` label pill whose arrow
points at the sessions, followed by one icon per
window that has agents (`·` = idle; several Claudes in one window share one
icon, showing the most urgent). The list is a native tmux loop
(`#{S:#{W:#{P:…}}}`) over the plugin's pane options, so it updates the
moment a hook fires. The plugin's own per-agent
glyph strip is deliberately disabled (inert `@agent_summary` token in
status-right). Colors follow the active `theme` profile
(`tmux/.tmux/scripts/agent_signal_colors.sh`).

Navigation (`tmux/.tmux/scripts/agent_jump.sh`): **click an agent icon** on
the bar to jump to that window's most urgent agent, or **click a session
name** to jump to that session's most urgent agent (both are tmux
`range=user` items carrying a window or session id), or press `prefix + N` for the next agent — one that needs you first,
else the next working one. Jumps are kitty-tab aware: when the target
session is already attached in another kitty tab, that tab is focused
(by its kitty window id and socket, read from the environment of the tmux
client attached there, so it keeps working after kitty restarts) instead of
the session being pulled into the current tab. `prefix + A` still opens the
plugin's own fzf switcher; note it does pull sessions into the current tab.

The states come from Claude Code hooks. `templates/claude/settings.json`
carries the full `hooks` block (agent-signal + auto-shutdown); because the
live settings files are untracked, a new machine (or a hook change) needs it
merged **by hand into both** `~/.claude/settings.json` and
`~/.claude-personal/settings.json` — without it, sessions started by
`claude-personal` stay invisible in the bar. Running sessions pick the hooks
up after `/hooks` is opened once, new sessions immediately.
