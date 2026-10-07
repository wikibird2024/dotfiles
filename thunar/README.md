# thunar

Right-click actions for [Thunar](https://docs.xfce.org/xfce/thunar/start), the file manager
on niri. Stowed by `steps/04_stow.sh` (`stow -R -t ~ thunar`).

| File | Links to | What |
|---|---|---|
| `.config/Thunar/uca.xml` | `~/.config/Thunar/uca.xml` | right-click actions: **Open Terminal Here**, **Copy Path** |
| `.local/bin/copy-path` | `~/.local/bin/copy-path` | what Copy Path runs; also works in a terminal: `copy-path file...` |

**Copy Path** puts the full paths of the selected files on the clipboard as one line, quoted
for the shell only where needed (`/home/me/My\ File.txt`). It pastes into kitty as plain
text, unlike Thunar's own `Ctrl+C`, which copies the *file* (for pasting in another
Thunar window). Uses `wl-copy` on Wayland and `xclip` on X11.

**Note:** Thunar rewrites `uca.xml` when you change an action in Edit → Configure custom
actions, which replaces the stow link with a plain file. Copy changes you want to keep
back to this repo, then `stow -R -t ~ thunar`.
