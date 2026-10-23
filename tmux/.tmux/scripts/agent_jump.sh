#!/bin/sh
# Jump to an agent, kitty-tab aware. Reads only the state the
# tmux-agent-signal plugin writes; never changes agent state.
#
#   agent_jump.sh next                          prefix+N:
#       pick a target (blocked > ask > done > working, windows on a
#       wait/park hold skipped, scanning after the current window first)
#   agent_jump.sh window <window_id> <client>   click on an agent icon:
#       that window's most urgent agent, for the client that clicked
#   agent_jump.sh session <session_id> <client> click on a session name:
#       that session's most urgent agent (idle ones too)
#
# All end in goto, which handles three cases:
#   - target is in the client's own session: just change window/pane
#   - target's session is attached in another kitty tab: select the
#     window/pane THERE and focus that kitty tab (the tab title starts with
#     the session name, set by set-titles-string), instead of stealing the
#     session into this tab
#   - not attached anywhere: switch this client to it, as plain tmux

# Focus the kitty tab whose title starts with the session name. Fails
# quietly when kitty is unreachable. Kitty's --match splits on spaces and
# parentheses even when escaped, so those (and quotes) go in as \xHH.
focus_kitty_tab() {
	listen=$(tmux show-environment -g KITTY_LISTEN_ON 2>/dev/null | cut -d= -f2-)
	[ -n "$listen" ] || return 1
	escaped=$(printf '%s' "$1" | sed 's/[^A-Za-z0-9_ ()"]/\\&/g; s/ /\\x20/g; s/(/\\x28/g; s/)/\\x29/g; s/"/\\x22/g')
	kitty @ --to "$listen" focus-window --match "title:^$escaped\\x20" >/dev/null 2>&1
}

# goto <session> <window_id> <pane_id> [client]
goto() {
	session=$1 window=$2 pane=$3 client=${4:-}
	if [ -n "$client" ]; then
		own_session=$(tmux display -p -c "$client" '#{client_session}')
	else
		own_session=$(tmux display -p '#{session_name}')
	fi
	if [ "$session" = "$own_session" ]; then
		tmux select-window -t "$window" \; select-pane -t "$pane"
		return 0
	fi
	if tmux list-clients -F '#{client_session}' | grep -Fxq "$session"; then
		tmux select-window -t "$window" \; select-pane -t "$pane"
		focus_kitty_tab "$session" || tmux display-message "agent is on the '$session' tab"
		return 0
	fi
	if [ -n "$client" ]; then
		tmux switch-client -c "$client" -t "$session" \; select-window -t "$window" \; select-pane -t "$pane"
	else
		tmux switch-client -t "$session" \; select-window -t "$window" \; select-pane -t "$pane"
	fi
}

# Most urgent agent pane among the rows on stdin, scanning after the window
# given as $1 first (empty = from the top). Rows: window_id, session_name,
# pane_id, state, hold, dead, kind. Prints "session<TAB>window_id<TAB>pane_id".
#   pick <current_window> next      blocked > ask > done > working; panes on
#                                   a wait/park hold skipped (prefix+N)
#   pick <current_window> session   same order, then idle agents too, holds
#                                   ignored (a click names its target)
pick() {
	awk -F'	' -v cur="$1" -v mode="$2" '
		{ rows[NR] = $0; if ($1 == cur && !pos) pos = NR }
		END {
			n = split(mode == "session" ? "blocked ask done working -" : "blocked ask done working", wants, " ")
			for (p = 1; p <= n; p++)
				for (i = 1; i <= NR; i++) {
					j = ((pos + i - 1) % NR) + 1
					split(rows[j], f, "\t")
					if (f[4] != wants[p] || f[6] == "1" || f[7] == "-") continue
					if (mode == "next" && f[5] != "-") continue
					print f[2] "\t" f[1] "\t" f[3]; exit
				}
		}'
}

pane_rows() {
	tmux list-panes "$@" -F "#{window_id}	#{session_name}	#{pane_id}	#{?#{@agent_pane_state},#{@agent_pane_state},-}	#{?#{@agent_hold},#{@agent_hold},-}	#{pane_dead}	#{?#{@agent_kind},#{@agent_kind},-}" 2>/dev/null
}

# goto from a "session<TAB>window_id<TAB>pane_id" line, with an optional client
goto_line() {
	[ -n "$1" ] || return 1
	goto "$(printf '%s' "$1" | cut -f1)" "$(printf '%s' "$1" | cut -f2)" \
		"$(printf '%s' "$1" | cut -f3)" "${2:-}"
}

next() {
	target=$(pane_rows -a | pick "$(tmux display -p '#{window_id}')" next)
	goto_line "$target" || tmux display-message "no agent to jump to"
}

case ${1:-next} in
next) next ;;
window)
	[ $# -eq 3 ] || { echo "usage: agent_jump.sh window <window_id> <client>" >&2; exit 1; }
	# Empty when the window or its agents are gone: nothing to do
	goto_line "$(pane_rows -t "$2" | pick "" session)" "$3" || exit 0
	;;
session)
	[ $# -eq 3 ] || { echo "usage: agent_jump.sh session <session_id> <client>" >&2; exit 1; }
	# Empty when the session or its agents are gone: nothing to do
	goto_line "$(pane_rows -s -t "$2" | pick "" session)" "$3" || exit 0
	;;
*) echo "usage: agent_jump.sh [next | window <window_id> <client> | session <session_id> <client>]" >&2; exit 1 ;;
esac
