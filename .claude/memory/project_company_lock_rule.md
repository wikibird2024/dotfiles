---
name: project-company-lock-rule
description: Company rule since 2026-10-30 - screen must lock after 1 min idle on every desktop (niri swayidle + GNOME gsettings)
metadata:
  node_type: memory
  type: project
  originSessionId: ebf4f482-19d8-4415-9352-09463d785d96
  modified: 2026-10-30T09:43:08.475Z
---

Company rule (new on 2026-10-30, was 5 min): the screen locks after **1 minute** idle.

**Why:** company security rule, stated by Hao Tran; not negotiable to save convenience.

**How to apply:** never raise a lock timeout above 60 s. niri: `timeout 60 ... shell lock` in `niri/.config/systemd/user/niri-swayidle.service`. GNOME: `gsettings org.gnome.desktop.session idle-delay 60` (+ screensaver lock-delay 0); this lives in dconf, not in the repo, so a new machine needs it set again. A logind "idle" inhibitor (`systemd-inhibit --what=idle`) turns the niri lock off too, so use only "shutdown" inhibitors.
