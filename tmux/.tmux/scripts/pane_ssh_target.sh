#!/usr/bin/env bash
# ssh block for the tmux status bar: " user@host │" in cyan when the pane's
# foreground process is `ssh`, or nothing when it is not. With "plain" it
# prints only "user@host" (for the pane header).
# Usage: pane_ssh_target.sh <pane_tty> [plain]

pane_tty="$1"
output_style="$2" # saved now: "set --" below replaces $1, $2...

ssh_args=$(ps -t "$pane_tty" -o comm=,args= 2>/dev/null | awk '$1 == "ssh" { $1=""; print; exit }')
[ -z "$ssh_args" ] && exit 0

# ssh options that consume a following argument
optspec="46AaCfGgKkMNnqsTtVvXxYyb:c:D:e:F:I:i:J:L:l:m:O:o:p:Q:R:S:W:w:B:E:"
# shellcheck disable=SC2086 # split the ssh command line into words on purpose
set -- $ssh_args
shift # drop the program name "ssh"
OPTIND=1
while getopts "$optspec" opt 2>/dev/null; do :; done
shift $((OPTIND - 1))
target="$1"
[ -z "$target" ] && exit 0

case "$target" in
	*@*) ;;
	*) target="$(whoami)@$target" ;;
esac
if [ "$output_style" = plain ]; then
	printf '%s' "$target"
	exit 0
fi
printf '#[fg=#7dcfff,bold]\xef\x83\xac %s#[nobold] #[fg=#414868]│ ' "$target"
