---
name: project-systemd-dropin-stow
description: systemd ignores a stow-folded (symlinked) *.service.d drop-in folder; niri.service has oomd avoid since 2026-10-08
metadata:
  node_type: memory
  type: project
  originSessionId: daf066ea-43d8-4c6c-aa9c-a576ceefcd72
  modified: 2026-10-08T10:27:52.249Z
---

systemd silently skips a drop-in folder (`foo.service.d`) that is a symlink, which is what stow makes when the folder is new (DropInPaths stays empty). The folder must be real with only the `.conf` file linked; `steps/04_stow.sh` pre-creates `~/.config/systemd/user/niri.service.d` for that.

**Why:** 2026-10-08 the session logged out 3 times: systemd-oomd (Ubuntu default: user@ memory pressure > 50% for 20 s) killed niri.service, ending the session. Fix: `niri/.config/systemd/user/niri.service.d/oomd.conf` with `ManagedOOMPreference=avoid` (honored because user owns both cgroups). Still open (user's choice): zram, a less strict oomd limit in /etc.

**How to apply:** any new user drop-in in a stow package needs its folder pre-created in 04_stow.sh; check with `systemctl --user show <unit> -p DropInPaths`. Related: [[project-dotfiles-stow-quirks]]
