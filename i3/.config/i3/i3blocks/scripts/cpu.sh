
#!/usr/bin/env bash
# CPU usage portable

# Lấy line cpu đầu tiên
cpu1=($(grep '^cpu ' /proc/stat))
sleep 0.1
cpu2=($(grep '^cpu ' /proc/stat))

# Tính toán
idle1=${cpu1[4]}
idle2=${cpu2[4]}

# total = tất cả field trừ field[0] (cpu label)
total1=0
total2=0
for i in {1..9}; do
    total1=$((total1 + cpu1[i]))
    total2=$((total2 + cpu2[i]))
done

total=$((total2 - total1))
idle=$((idle2 - idle1))

cpu_load=$(( total ? 100*(total-idle)/total : 0 ))
echo "${cpu_load}%"
