---
name: project-waybar-helper-scripts
description: "waybar ignores SIGPIPE and its children inherit it — long-running custom-module helpers must exit on a failed write, or they pile up per restart"
metadata:
  node_type: memory
  type: project
  originSessionId: 23db5329-bf73-4f21-b076-c90c84d4575a
  modified: 2026-10-09T09:24:00.415Z
---

waybar sets SIGPIPE to ignored, and every `exec` helper it starts inherits that (a unit's `IgnoreSIGPIPE=no` does not help). A long-running helper like `swaync-client -swb | jq` therefore never dies when waybar restarts: verified 2026-10-09, one leftover pair per restart (and 14 leaked `waybar-workspaces` copies before that fix).

**Why:** with SIGPIPE ignored, a write to the dead waybar pipe only returns EPIPE; tools like jq/swaync-client keep running.

**How to apply:** write such helpers as a script in `niri/.config/niri/scripts/` that reads its event source from `< <(...)` or `exec {fd}< <(...)`, ends with `|| exit 0` on the write, and kills the source in an EXIT trap — like `waybar-workspaces` and `waybar-notifications`. Test with 3× `systemctl --user restart niri-waybar` + an event, then list `/sys/fs/cgroup/<unit cgroup>/cgroup.procs`. Related: [[project-waybar-reload]]
