
#!/usr/bin/env bash
# Battery portable
if command -v acpi >/dev/null 2>&1; then
    acpi -b | awk '{print $4}' | tr -d ','
else
    # đọc trực tiếp từ /sys/class/power_supply nếu acpi không có
    if [ -d /sys/class/power_supply/BAT0 ]; then
        capacity=$(cat /sys/class/power_supply/BAT0/capacity)
        echo "${capacity}%"
    else
        echo "N/A"
    fi
fi
