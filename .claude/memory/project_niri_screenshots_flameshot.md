---
name: niri-screenshots-flameshot
description: niri: Print = Flameshot 13.3 copy (--raw | wl-copy); Mod+Insert = niri's own screenshot to save; what breaks and why
metadata:
  type: project
---

Since 2026-10-07 niri's Print runs Flameshot again through `niri/.config/niri/scripts/screenshot`
(Hao prefers Flameshot over satty; satty is only the fallback without Flameshot 13.x).

Facts proven 2026-10-07 (don't re-derive or re-test):
- Flameshot's own copy (Ctrl+C / `-c`) never reaches the clipboard on niri: tested with
  `flameshot full -c` (no window) → clipboard unchanged. Fix = `flameshot gui --raw` → wl-copy.
- `flameshot gui` with any task except `--print-geometry` (e.g. `-p`, `--raw`) removes the
  Copy/Save buttons and Ctrl+C/Ctrl+S (capturewidget.cpp:320 in 13.3); only Enter is left.
  So saving is a separate tool, Hao's choice (2026-10-07): Mod+Insert / Mod+Print run niri's
  built-in `screenshot` (saves to screenshot-path). Shift+Print never arrived from Hao's
  keyboard (Fn+Shift+PrtSc), so it was dropped.
  The 2026-10-06 retirement (commit 1718fb2) blamed a missing build flag; that was wrong.
- Only 13.x has grim mode (`useGrimAdapter`); 12.1 Ubuntu build lacks it, 14.0+ removed it.
  The 13.3.0 deb is held by apt.

**How to apply:** don't switch niri back to satty or suggest Ctrl+C inside Flameshot on niri.
Test clipboard behavior without windows (`flameshot full -c`) before asking Hao to test;
see [[feedback-research-before-screen-tests]].
