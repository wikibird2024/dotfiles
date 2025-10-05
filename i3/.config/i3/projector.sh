
#!/bin/sh

# Detect HDMI connection
HDMI_CONNECTED=$(xrandr | grep "HDMI-1-1 connected")

if [ -n "$HDMI_CONNECTED" ]; then
    # Projector mode: HDMI primary, laptop on the left
    xrandr \
      --output LVDS-1 --mode 1366x768 --pos 0x0 \
      --output HDMI-1-1 --primary --mode 1920x1080 --right-of LVDS-1 \
      --output VGA-1-2 --off

    if [ $? -eq 0 ]; then
        notify-send "Display Mode" "✅ Projector mode enabled (HDMI primary 1920x1080)"
    else
        notify-send "Display Mode" "❌ Failed to switch to projector mode"
    fi
else
    # Fallback: laptop only
    xrandr \
      --output LVDS-1 --primary --mode 1366x768 --pos 0x0 \
      --output HDMI-1-1 --off \
      --output VGA-1-2 --off

    notify-send "Display Mode" "⚠️ No HDMI detected → Laptop only"
fi
