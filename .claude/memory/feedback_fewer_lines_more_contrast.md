---
name: feedback_fewer_lines_more_contrast
description: User finds line-heavy terminal screens hard to read; background contrast (dimmed unfocused panes) works better than borders
metadata:
  node_type: memory
  type: feedback
  originSessionId: c418dd47-c9ad-4866-b5db-7e2e5dccfa5e
  modified: 2026-10-10T03:21:24.612Z
---

The user runs Claude Code inside tmux with several panes and found the screen hard to read because of stacked lines (Claude input box rules, tmux pane borders, table borders in answers). On 2026-10-10 we dimmed unfocused panes (`window-style bg=#{@thm_pane_dim}`, one value per theme profile) and made idle borders close to the terminal background. The user said the dimmed pane color "make the text easier to read".

**Why:** Separation by background shade reads more easily for this user than separation by more lines.

**How to apply:** For UI work (tmux, nvim, waybar, niri, kitty), prefer contrast and shading over adding borders, rules or boxes. Keep idle borders faint. Use theme roles so `theme` still recolors everything. Related: [[feedback_tmux_powerline_style]].
