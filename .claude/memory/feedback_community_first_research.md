---
name: feedback-community-first-research
description: Survey existing community/OSS solutions before designing custom tooling; user rejects plans that look like homegrown patchwork
metadata:
  node_type: memory
  type: feedback
  originSessionId: d22f3f5e-d41c-4598-809e-723f0469da37
  modified: 2026-10-12T07:02:57.575Z
---

When a feature idea comes up (2026-10-12: agent-status awareness in tmux), Hao Tran rejected a ready custom-build plan twice: first asking for "clean and right architecture proper instead of patch", then "reference and learn from community what they do to find the best suite solution". The adopted plan used an existing MIT plugin (tmux-agent-signal) restyled to the dotfiles theme.

**Why:** they prefer maintained community code over bespoke scripts, and clean single-owner architecture over scattered edits; a custom build is the fallback, not the default.

**How to apply:** before proposing new tooling, search for existing OSS doing the job (GitHub, plugin ecosystems), present a short comparison with a recommendation, and frame any custom build around explicit interfaces/ownership. Related: [[feedback-research-before-screen-tests]], [[feedback-prefers-rust-tools]].
