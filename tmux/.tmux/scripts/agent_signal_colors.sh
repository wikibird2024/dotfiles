#!/bin/sh
# Colors and icons for the tmux-agent-signal plugin, taken from the active
# @thm_* theme roles. The plugin reads these options as plain strings when a
# state changes (no #{} expansion there), so they must hold real color values.
# Called when .tmux.conf loads and by `theme <name>` after a switch.
# Badge format per state: "<icon> <text color> <tab background>"; background
# "default" keeps the tab colors ours. Icons are Nerd Font, single width.

thm() {
	value=$(tmux show -gqv "@thm_$1")
	[ -n "$value" ] && printf '%s' "$value" || printf '%s' "$2"
}

# Window tab badges: working = timer, blocked on a permission = bell,
# asking a question = help circle, done = check, wait/park = manual holds
tmux set -g @agent_signal_working "󰔟 $(thm cyan '#7dcfff') default"
tmux set -g @agent_signal_blocked "󰂚 $(thm yellow '#e0af68') default"
tmux set -g @agent_signal_ask "󰋗 $(thm orange '#ff9e64') default"
tmux set -g @agent_signal_done "󰄬 $(thm done '#73daca') default"
tmux set -g @agent_signal_wait "… $(thm muted '#565f89') default"
tmux set -g @agent_signal_park "p $(thm muted '#565f89') default"

# Fleet summary (status-right): one glyph per agent pane, colored by state
tmux set -g @agent_signal_colour_working "$(thm cyan '#7dcfff')"
tmux set -g @agent_signal_colour_blocked "$(thm yellow '#e0af68')"
tmux set -g @agent_signal_colour_ask "$(thm orange '#ff9e64')"
tmux set -g @agent_signal_colour_done "$(thm done '#73daca')"
tmux set -g @agent_signal_colour_idle "$(thm muted '#565f89')"
