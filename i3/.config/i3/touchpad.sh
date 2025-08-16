
#!/bin/bash
if xinput list | grep -q "SynPS/2"; then
    xinput set-prop "SynPS/2 Synaptics TouchPad" "libinput Tapping Enabled" 1
fi
