#!/bin/bash
# layout_workspace.sh
# Open Alacritty on workspace 1.
# Open xfce4-terminal and Firefox side-by-side on workspace 2 with a specific layout.

set -euo pipefail

# Define application commands and titles
TERMINAL_CMD="xfce4-terminal"
TERMINAL_TITLE="terminal_left"
BROWSER_CMD="firefox"
BROWSER_CLASS="firefox"

# Reusable function to wait for a window by title and return its ID
wait_for_window_id() {
    local title="$1"
    local timeout=${2:-50}
    local id=""
    for ((i=0; i<timeout; i++)); do
        id=$(i3-msg -t get_tree | jq -r '.. | select(.name? == "'"$title"'") | .id' | head -n1 || true)
        if [[ -n "$id" && "$id" != "null" ]]; then
            echo "$id"
            return 0
        fi
        sleep 0.1
    done
    return 1
}

# ---
# Workspace 1: Open Alacritty
i3-msg 'workspace 1; exec alacritty'

# ---
# Workspace 2: Open terminal and Firefox with layout
i3-msg 'workspace 2; layout splith'

# Open xfce4-terminal with a specific title
i3-msg "exec $TERMINAL_CMD --title=$TERMINAL_TITLE"

# Wait for the terminal to appear and get its container ID
term_id=$(wait_for_window_id "$TERMINAL_TITLE") || {
    echo "Error: $TERMINAL_TITLE window not found" >&2
    exit 1
}

# Explicitly resize the terminal container to 33% width
i3-msg "[con_id=$term_id] resize set width 33 ppt"

# Open Firefox. i3 automatically places it in the new split.
i3-msg "exec $BROWSER_CMD"

# Wait for the Firefox window to appear (using its title) and get its container ID
# Note: Using class could also be an option for more generic applications
firefox_id=$(wait_for_window_id "Mozilla Firefox") || {
    echo "Error: $BROWSER_CMD window not found" >&2
    exit 1
}

# Focus Firefox explicitly to ensure it's the active window
i3-msg "[con_id=$firefox_id] focus"
