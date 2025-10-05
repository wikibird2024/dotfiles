
#!/bin/sh
xrandr \
  --output LVDS-1 --primary --mode 1366x768 --pos 0x0 \
  --output HDMI-1-1 --mode 1366x768 --same-as LVDS-1 \
  --output VGA-1-2 --off

# Thông báo ra i3 notification
if [ $? -eq 0 ]; then
  notify-send "Display Mode" "✅ Mirror mode enabled (Laptop + Projector)"
else
  notify-send "Display Mode" "❌ Failed to switch to mirror mode"
fi
