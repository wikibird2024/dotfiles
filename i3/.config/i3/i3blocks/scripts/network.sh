
#!/usr/bin/env bash
nmcli -t -f ACTIVE,SSID dev wifi | awk -F: '$1=="yes"{print $2}' | head -n1
