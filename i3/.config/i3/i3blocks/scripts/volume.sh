
#!/usr/bin/env bash
# Volume portable
amixer get Master | awk -F'[][]' '/Left:/ {print $2}' | head -n1
