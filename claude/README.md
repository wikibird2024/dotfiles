# claude

Global instructions and skills for [Claude Code](https://claude.com/claude-code).

Stowed by `steps/04_stow.sh` (`stow -R -t ~ claude`). `04_stow.sh` creates `~/.claude/skills/` as a real folder first, so only
these files are linked and Claude Code's own data (credentials, history) never ends up in git.

| File | Purpose |
|---|---|
| `.claude/CLAUDE.md` | rules for every project (naming, wording, ...) |
| `.claude/skills/project-status/SKILL.md` | `/project-status`: read-only report on the current repo (git, build, tests, open work) |
| `.local/bin/claude-personal` | wrapper script isolating personal credentials to `~/.claude-personal` |

`~/.claude/settings.json` and `~/.claude-personal/settings.json` are **not** linked: Claude Code writes to them. A new machine gets a copy of `templates/claude/settings.json` once.

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
(matched by its title, which starts with the session name) instead of the
session being pulled into the current tab. `prefix + A` still opens the
plugin's own fzf switcher; note it does pull sessions into the current tab.

The states come from Claude Code hooks. `templates/claude/settings.json`
carries the full `hooks` block (agent-signal + auto-shutdown); because the
live settings files are untracked, a new machine (or a hook change) needs it
merged **by hand into both** `~/.claude/settings.json` and
`~/.claude-personal/settings.json` — without it, sessions started by
`claude-personal` stay invisible in the bar. Running sessions pick the hooks
up after `/hooks` is opened once, new sessions immediately.
