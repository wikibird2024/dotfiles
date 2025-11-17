
#!/usr/bin/env bash
# Disk usage portable (root partition)
read used total <<< $(df -h / | awk 'NR==2 {print $3,$2}')
echo "$used/$total"
