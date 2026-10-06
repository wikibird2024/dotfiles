# flameshot

Settings for [Flameshot](https://flameshot.org), the screenshot tool used in **GNOME and
i3** (both X11). niri does **not** use Flameshot: its Wayland builds without
`USE_WAYLAND_CLIPBOARD` have no copy to clipboard at all (no `Ctrl+C`, no copy button —
flameshot issue #2848), so there `Print` runs slurp + grim + satty instead — see
`niri/README.md` "Why satty, not Flameshot".

Stowed by `steps/04_stow.sh` (`stow -R -t ~ flameshot`). → `~/.config/flameshot/flameshot.ini`

No tray icon, files named `YYYY-MM-DD_HH-MM-SS`, no welcome screen, no "Screenshot aborted"
pop-up. The grim keys (`useGrimAdapter`) are left over from the retired niri setup and are
ignored on X11.

**Note:** Flameshot rewrites `flameshot.ini` when you change a setting in its window, which
replaces the stow link with a plain file. Copy changes you want to keep back to this repo
by hand, then `stow -R -t ~ flameshot`.
