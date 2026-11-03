---
name: project-waybar-reload
description: "Ubuntu 24.04 waybar 0.9.24 — SIGUSR2 reloads only CSS; config.jsonc changes need `systemctl --user restart niri-waybar`"
metadata:
  node_type: memory
  type: project
  originSessionId: d5ada05a-9669-45c8-b377-448e790fb0f9
  modified: 2026-10-09T09:23:55.652Z
---

On the niri desktop (Ubuntu 24.04, waybar 0.9.24), `pkill -USR2 waybar` re-read the CSS but NOT `config.jsonc` (verified 2026-09-30: a new `format-ethernet` only showed after a restart).

**Why:** `scripts/shell colors` (run by `theme`) relies on USR2, which is fine for colors (CSS only); config edits silently don't apply.

**How to apply:** since 2026-10-09 waybar runs as the user unit `niri-waybar` (unit file in `niri/.config/systemd/user/`), so after editing `niri/.config/waybar/config.jsonc` run `systemctl --user restart niri-waybar` — never `pkill waybar` + `setsid waybar` (that starts a second, unmanaged copy outside the unit). Logs: `journalctl --user -u niri-waybar`. Related: [[project-waybar-helper-scripts]], [[project-dotfiles-stow-quirks]]
