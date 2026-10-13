#!/usr/bin/env bash
# Claude Code status line: model | ctx | 5h | 7d, each a bar on a dark track + percent.
#   Opus 5.5 | ctx ▆▆▆▆▆▆▆▆▆▆   8% | 5h ▆▆▆▆▆▆▆▆▆▆   4% | ...
# Every cell is ▆ (3/4 height): the used ones in the fill color, the rest dark
# gray (the track). A half-used cell is the fill color, dimmed.
# Muted on purpose (256-color palette): gray text, dark track, the used part
# soft green < 50 %, amber < 80 %, soft red from 80 %.
# Claude Code sends the session as JSON on stdin (settings.json "statusLine").

input=$(cat)
read_field() { jq -r "$1 // empty" <<<"$input"; }

BAR_CELLS=10
CELL="▆"                       # 3/4 height (▅ 5/8, ▄ 1/2 are thinner)
TEXT=$'\e[38;5;244m'           # gray: model, labels, numbers, separators
TRACK=$'\e[38;5;237m'          # dark gray: the empty cells
GREEN=65 AMBER=137 RED=131     # muted fill colors (256-color numbers)
RESET=$'\e[0m'

# usage_bar <label> <percent>: label, bar of BAR_CELLS, percent
usage_bar() {
    local label=$1 percent
    percent=$(printf '%.0f' "$2")
    ((percent > 100)) && percent=100
    local half_cells=$(((percent * BAR_CELLS * 2 + 50) / 100))
    local full=$((half_cells / 2)) has_half=$((half_cells % 2))
    local empty=$((BAR_CELLS - full - has_half))
    local fill=$GREEN
    ((percent >= 50)) && fill=$AMBER
    ((percent >= 80)) && fill=$RED
    local cells=$'\e[38;5;'"$fill"'m'
    for ((i = 0; i < full; i++)); do cells+="$CELL"; done
    ((has_half)) && cells+=$'\e[2m'"$CELL$RESET"
    cells+="$TRACK"
    for ((i = 0; i < empty; i++)); do cells+="$CELL"; done
    printf '%s%s %s%s%s %3s%%' "$TEXT" "$label" "$cells" "$RESET" "$TEXT" "$percent"
}

out="$TEXT$(read_field '.model.display_name')"
context=$(read_field '.context_window.used_percentage')
five_hour=$(read_field '.rate_limits.five_hour.used_percentage')
seven_day=$(read_field '.rate_limits.seven_day.used_percentage')

[ -n "$context" ] && out+=" | $(usage_bar ctx "$context")"
[ -n "$five_hour" ] && out+=" | $(usage_bar 5h "$five_hour")"
[ -n "$seven_day" ] && out+=" | $(usage_bar 7d "$seven_day")"
echo "$out$RESET"
