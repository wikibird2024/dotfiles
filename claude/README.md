# claude

Global instructions and skills for [Claude Code](https://claude.com/claude-code).

Stowed by `steps/04_stow.sh` twice: `stow -R -t ~ claude` for the work
account (`~/.claude`) and `stow -d claude -t ~/.claude-personal .claude` for
the personal one, so both accounts use the **same files**. `04_stow.sh`
creates `skills/` and `rules/` as real folders first, so only these files are
linked and Claude Code's own data (credentials, history, sessions) never ends
up in git.

| File | Purpose |
|---|---|
| `.claude/CLAUDE.md` | rules for every project (naming, wording, ...) |
| `.claude/settings.json` | hooks, plugins, status line, theme, effort; shared by both accounts (see below) |
| `.claude/rules/stm32-cubemx.md` | CubeMX rules; load only when Claude reads or edits a `.ioc`, C, assembly, linker or CMake file (`paths:` in its header) |
| `.claude/rules/firmware-checks.md` | firmware review list (ISR data, blocking calls, safety limits); loads on C/C++ files |
| `.claude/skills/project-status/SKILL.md` | `/project-status`: read-only report on the current repo (git, build, tests, open work) |
| `.claude/skills/flow-map/SKILL.md` | `/flow-map`: explain how a program runs (contexts, nesting, one example traced with `file:line`); `quick` for one screen |
| `.claude/skills/scout/SKILL.md` | `/scout`: find and judge new open-source repos, notes in `community/` |
| `.local/bin/claude-personal` | wrapper script isolating personal credentials to `~/.claude-personal` |
| `.local/bin/claude-stm32-build-check` | Stop hook: builds changed STM32 firmware before Claude may finish (see below) |

## Settings, plugins and memory

- **`settings.json` is a link into this repo.** Claude Code writes through it
  (`/model`, `/config`, `claude plugin install`), so check `git diff` before a
  commit. It saves via `settings.json.tmp.*` next to the file (gitignored).
- **Keep work details out** (public repo): `autoMode` text from
  `/auto-mode-setup` names company hosts and one repo path, so delete it from
  this file if a session adds it. Approvals ("don't ask again") go to each
  project's own `.claude/settings.local.json`, not here.
- **Plugins** come from `enabledPlugins` + `extraKnownMarketplaces` (ponytail).
  On a new machine: `claude plugin install <name>@<marketplace>` for each one
  enabled, once per account (`CLAUDE_CONFIG_DIR=~/.claude-personal claude …`).
- **archify** has no plugin: `02_tools.sh` clones tag v3.2.0 into
  `~/.local/share/claude-skills/archify`, `04_stow.sh` links it into both accounts.
- **Memory** for this repo lives in `../.claude/memory/` (repo root
  `.claude/settings.json` sets `autoMemoryDirectory`). Memories of work repos
  stay local on purpose.

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

The hook entry is in the `Stop` list of `.claude/settings.json`.

## Agent state in the tmux bar

The [tmux-agent-signal](https://github.com/jward7/tmux-agent-signal) plugin
(installed by tpm, pinned in `tmux/.tmux.conf`) shows every Claude session's
state on its tmux window tab: 󰪡 working, 󰂚 blocked on a permission, 󰋗 asking
a question, 󰄬 finished while you were elsewhere. The right side of the bar
lists **every** Claude agent of every session, grouped by session:
`Dekit_grader_v1 󰄰  STM32F7_USB_spra… 󰄰  dotfiles 󰪡`. The session name is
colored by its most urgent agent (yellow needs you, orange asks, green
finished unseen, cyan working, purple - the block's own color - all idle),
fenced by `│` and led by a solid purple `󰚩 AI` label pill whose arrow
points at the sessions, followed by one icon per
window that has agents (`󰄰` = idle; several Claudes in one window share one
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

The states come from Claude Code hooks: the `hooks` block (agent-signal +
auto-shutdown) in `.claude/settings.json`, which both accounts share, so
sessions started by `claude-personal` show in the bar too. Settings edits
reach running sessions on save.
