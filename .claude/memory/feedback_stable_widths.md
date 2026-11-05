---
name: feedback-stable-widths
description: Tabs and bar items should keep their size and position; jumping sizes make them hard to follow
metadata:
  node_type: memory
  type: feedback
  originSessionId: 01dc6ddb-47ec-4825-b43f-6e39667cef19
  modified: 2026-11-05T05:38:39.316Z
---

Keep tabs and bar items at a stable size and position: pad and cap the text instead of letting it follow content length.

**Why:** the user said that when they jump around and tab sizes change, it is hard to follow. Kitty tabs were fixed at 24 cells for this on 2026-11-05.

**How to apply:** for any tab, bar or list design, check first what makes items move (title changes, state icons, session switches) and prefer fixed-width slots. The tmux Agents block is still not fixed: see [[feedback-tmux-powerline-style]].
