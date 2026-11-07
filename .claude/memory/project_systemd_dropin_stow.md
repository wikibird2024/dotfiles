---
name: project-systemd-dropin-stow
description: systemd ignores a stow-folded (symlinked) *.service.d drop-in folder; niri.service has oomd avoid since 2026-10-08
metadata:
  node_type: memory
  type: project
  originSessionId: daf066ea-43d8-4c6c-aa9c-a576ceefcd72
  modified: 2026-11-05T10:51:24.921Z
---

systemd silently skips a drop-in folder (`foo.service.d`) that is a symlink, which is what stow makes when the folder is new (DropInPaths stays empty). The folder must be real with only the `.conf` file linked; `steps/04_stow.sh` pre-creates `~/.config/systemd/user/niri.service.d` for that.

**Why:** 2026-10-08 the session logged out 3 times: systemd-oomd (Ubuntu default: user@ memory pressure > 50% for 20 s) killed niri.service, ending the session. Fix: `niri/.config/systemd/user/niri.service.d/oomd.conf` with `ManagedOOMPreference=avoid` (honored because user owns both cgroups). Still open (user's choice): zram, a less strict oomd limit in /etc.

**Side effect found 2026-11-05 (3 logouts: 11:13, 16:58, 17:37):** oomd spares niri.service but kills dbus.service and the rest, so the session ends with niri still active. Every new login then fails with "A niri session is already running." (`niri-session` check) and looks like a wrong password until reboot. dbus.service has no avoid setting; fix not yet chosen. Why so many units die: oomd (255.4-1ubuntu8.18) hits an error on each kill and moves to the next candidate; logs show N-1 units "killed some process(es)" then one "killed 1 process(es)", matching the `r < 0` branch in upstream oomd-util.c (same loop in v257). Exact error unknown. Proposed 2026-11-05, not applied: remove oomd pressure monitor on user@, cap app.slice and each tmux pane, move desktop units to session.slice, niri BindsTo=dbus.service.

**How to apply:** any new user drop-in in a stow package needs its folder pre-created in 04_stow.sh; check with `systemctl --user show <unit> -p DropInPaths`. Related: [[project-dotfiles-stow-quirks]]
