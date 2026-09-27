# picom

Config for [picom](https://github.com/yshui/picom), the X11 compositor for the i3 session
(niri does its own compositing).

Stowed by `steps/04_stow.sh` (`stow -R -t ~ picom`). → `~/.config/picom/picom.conf`

GLX backend with vsync, 12 px rounded corners (not on docks/bars), shadows, fading, opacity rules.
Started from `i3_wm_endervour/.config/i3/conf.d/autostart.conf` (`picom -b`).
