---
name: clipboard-tests-cleanup
description: "Clipboard tests on niri must not leave `xclip -i` / `wl-copy` owners running; a leftover xclip hijacked every Claude paste (2026-10-29)"
metadata:
  node_type: memory
  type: feedback
  originSessionId: a72c8d60-8ebb-48d6-ba90-c98d948953df
  modified: 2026-10-29T07:21:13.471Z
---

When testing the clipboard, never leave an owner process behind: `xclip -i` forks
and keeps serving the X11 clipboard until another X app copies. On niri the
xwayland-satellite bridge does not pass Wayland copies over to X11 reliably, so a leftover
`xclip -i test.png` made every Ctrl+V in Claude paste that test picture instead of
copied text (Claude reads `xclip` before `wl-paste`). Hao noticed it right away.

**Why:** a test that changes the live clipboard breaks Hao's real copy/paste.
**How to apply:** use `xclip -loops 1` or kill the owner at the end of the test,
check `pgrep -a xclip` afterwards, and give back the saved clipboard. The fix for
the paste bug itself is the `claude='env -u DISPLAY claude'` alias in bash/.bashrc.
Related: [[niri-screenshots-flameshot]], [[feedback-research-before-screen-tests]].
