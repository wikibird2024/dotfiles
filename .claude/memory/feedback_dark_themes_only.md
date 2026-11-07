---
name: feedback-dark-themes-only
description: "User doesn't want light themes; suggest dark profiles only (tried everforest-light and github-light 2026-10-28)"
metadata:
  node_type: memory
  type: feedback
  originSessionId: 85071513-7200-47ab-977f-7bbfd10a2570
  modified: 2026-10-28T06:24:12.666Z
---

Don't suggest or add light color themes; only dark ones.

**Why:** 2026-10-28 the user tried a light profile. everforest-light was unreadable (code 2.2–3.3:1 contrast); github-light (7.8–20:1) was dropped too. Their words: "maybe light isn't fit to my eye so we don't need it".

**How to apply:** 2026-11-03 the user cut the profiles down to their 4 favorites: xfce, abyss, ubuntu, moonfly (carbonfox, catppuccin, gruvbox-classic, kanagawa-dragon, onedark, rose-pine deleted). Don't re-add or propose those; suggest a new dark theme only when asked. Their taste leans to high contrast, see [[feedback-fewer-lines-more-contrast]]. Check a theme's code contrast in headless nvim before recommending it.
