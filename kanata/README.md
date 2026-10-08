# kanata

Caps Lock does two jobs: **tap = Esc, hold = Ctrl**. [kanata](https://github.com/jtroo/kanata)
(Rust) reads the keyboard before the desktop does, so it works the same in GNOME/X11,
niri/Wayland and the TTY. Stowed by `steps/04_stow.sh` (`stow -R -t ~ kanata`).

```
keyboard ─► /dev/input ─► kanata ─► /dev/uinput (virtual keyboard) ─► X11 / Wayland / TTY
```

| File | Links to | What |
|---|---|---|
| `.config/kanata/kanata.kbd` | `~/.config/kanata/kanata.kbd` | the key map |
| `.config/systemd/user/kanata.service` | `~/.config/systemd/user/kanata.service` | starts kanata at login |

**Install:** `./bootstrap.sh` does it all: `02_tools.sh` runs `cargo install kanata`, and
`04_stow.sh` does the one-time root setup, then enables the service:

- system group `uinput`, and `/etc/udev/rules.d/99-uinput.rules` gives it `/dev/uinput`
- `/etc/modules-load.d/uinput.conf` loads the `uinput` module at boot
- your user joins `input` (read keyboards) and `uinput` (write the virtual keyboard);
  **log out and back in once** after this

**Use:**

```bash
systemctl --user status kanata        # running?
systemctl --user restart kanata       # after editing kanata.kbd
journalctl --user -u kanata -f        # log
kanata --cfg ~/.config/kanata/kanata.kbd --check   # check the config without running it
```

**Emergency stop:** `LCtrl+Space+Esc` stops kanata if a bad config locks the keyboard.
Caps then falls back to the XKB setting (`caps:escape`, see [`xorg`](../xorg/README.md)), so it is
still Esc.

**Tuning:** if a quick tap sometimes gives Ctrl instead of Esc (or the other way), change the
`200 200` (tap and hold time, ms) in `kanata.kbd`.

**Note:** members of the `input` group can read every key typed on this machine. That is the
normal cost of any remapper of this kind (keyd runs as root instead).
