# xorg

X11 keyboard setting: US layout, **Caps Lock acts as Escape** (`caps:escape`) — for Vim/Neovim.

**Not stowed into `~`**: the file belongs in `/etc/X11/xorg.conf.d/`. Install it once with root:

```bash
sudo stow -t / xorg        # or: sudo cp xorg/etc/X11/xorg.conf.d/00-keyboard.conf /etc/X11/xorg.conf.d/
```

Applies to X11 sessions (i3) after restarting X. niri ignores it — set the same under
`input { keyboard { xkb { options "caps:escape" } } }` in `niri/.config/niri/config.kdl` if wanted.
