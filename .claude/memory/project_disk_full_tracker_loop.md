---
name: project-disk-full-tracker-loop
description: "2026-11-19 SSD hit 100% from a tracker-miner log-spam loop; tracker is masked, journal capped at 500M, snaps keep 2 versions"
metadata:
  node_type: memory
  type: project
  originSessionId: a402e5c3-ae7f-422e-80d1-220d7502c2e9
  modified: 2026-11-19T00:56:14.897Z
---

On 2026-11-19 the root SSD reached 100% (619 MB free). Cause: once the disk was nearly full, tracker-miner-fs-3 could not index drawio temp files in ~/Documents and logged "not enough space" 8.2M times, so syslog.1 grew to 2.8 GB and filled the disk further.

Fixes applied (87% after cleanup, 11 GB free):
- tracker-miner-fs-3 and tracker-extract-3 masked (user units, `~/.config/systemd/user/*.service -> /dev/null`, not in the repo); ~/.cache/tracker3 deleted. GNOME Files no longer searches file contents.
- `/etc/systemd/journald.conf.d/size.conf`: SystemMaxUse=500M (not in the repo).
- `snap set system refresh.retain=2`; old disabled snap versions removed (~5 GB).

**Why:** the SSD is only 87 GB (see [[project-home-offload]]); a single log spammer can fill it.

**How to apply:** when the disk is full again, check `/var/log/syslog*` and `journalctl --disk-usage` first for a spammer, then disabled snaps. A new machine needs the tracker mask and journald cap set by hand. Never clean `~/.claude`, `~/.claude-personal`, `~/.local/share/claude`.
