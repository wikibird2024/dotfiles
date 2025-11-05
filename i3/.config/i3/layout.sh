
#!/bin/bash
# i3_layout_setup.sh
# Automatically set up preferred workspace layout for i3wm

set -euo pipefail

# --- Safety checks ---
if ! pgrep -x "i3" >/dev/null; then
    echo "❌ i3 is not running. Please start i3 first."
    exit 1
fi

echo "🧩 Setting up i3 layout..."

# --- Workspace 1: Main terminal ---
i3-msg 'workspace 1; append_layout ~/.config/i3/layouts/main_terminal.json' >/dev/null
i3-msg 'exec alacritty --title main' >/dev/null
sleep 0.3

# --- Workspace 2: Dev environment ---
i3-msg 'workspace 2; layout splith' >/dev/null
i3-msg 'exec alacritty --title code' >/dev/null
sleep 0.3
i3-msg 'exec firefox' >/dev/null
sleep 0.3
i3-msg '[title="code"] resize set width 40 ppt' >/dev/null

# --- Workspace 3: Monitoring tools ---
i3-msg 'workspace 3; layout tabbed' >/dev/null
i3-msg 'exec htop' >/dev/null
i3-msg 'exec alacritty --title logs -e tail -f /var/log/syslog' >/dev/null

# --- Workspace 4: Communication ---
i3-msg 'workspace 4; layout splith' >/dev/null
i3-msg 'exec telegram-desktop' >/dev/null
sleep 0.3
i3-msg 'exec alacritty --title chat' >/dev/null

# --- Workspace 5: Web ---
i3-msg 'workspace 5; exec firefox --new-window https://duckduckgo.com' >/dev/null

echo "✅ i3 layout initialized successfully."
