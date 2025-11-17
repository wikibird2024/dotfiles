
#!/usr/bin/env bash
# Memory usage portable
# đọc từ /proc/meminfo
read total free available <<< $(awk '/MemTotal/ {t=$2} /MemAvailable/ {a=$2} END{print t,a}' /proc/meminfo)
used=$((total - available))
echo "$((used/1024))M/$((total/1024))M"
