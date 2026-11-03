---
name: feedback_tell_panes_apart
description: User mixes up tmux panes when every app shares one theme; wants Neovim on a different bg than the terminal plus app icons in pane headers
metadata:
  node_type: memory
  type: feedback
  originSessionId: 1063eb9b-ab4f-4ab2-bd91-c8e2768cbfb6
  modified: 2026-10-29T03:47:45.172Z
---

One identical theme across kitty/tmux/Neovim makes panes in a tmux session easy to mix up ("nhầm lẫn"). Confirmed fix (2026-10-29, "that is good for xfce theme. I like it"):
- Neovim keeps a clearly different background from the terminal (xfce profile: terminal pure black, Neovim Dracula's own `#282a36`).
- tmux pane headers show an app icon + name (`@pane-app` in `.tmux.conf`): green nvim, orange Claude, yellow yazi, grey other; icon keeps its color on unfocused panes.

**Why:** at a glance the user must tell editor, Claude and shell panes apart, not only which pane has focus.

**How to apply:** when adding or tuning a `theme` profile, don't give Neovim the exact terminal background: Neovim one step lighter, same color family. Applied to all 10 profiles on 2026-10-29 ("go all") — a theme's own lighter variant first (`gruvbox:soft`, `kanagawa:wave`, `rose_pine:moon`, `catppuccin:macchiato`, `onedark:dark`), else `raise_background()` in colorscheme.lua (carbonfox, moonfly, abyss). New profiles follow the same rule. Related: [[feedback_fewer_lines_more_contrast]], [[feedback_tmux_powerline_style]], [[feedback_dark_themes_only]].
