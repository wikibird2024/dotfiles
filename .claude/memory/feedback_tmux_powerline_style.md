---
name: feedback_tmux_powerline_style
description: "User confirmed preference for symmetric Nerd Font powerline styling in tmux status bar, referencing mature repos (tmux-powerline, catppuccin-tmux)"
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 654d4c0f-803e-48a5-ab06-19e6ba1e0121
  modified: 2026-10-29T02:29:31.476Z
---

For `tmux/.tmux.conf` status bar work, the user wants proper powerline-style "pills": any highlighted segment (bg color block) in the middle of the status line needs BOTH a leading and trailing powerline arrow (U+E0B0, `fg=<outer_bg>,bg=<pill_bg>` on entry, `fg=<pill_bg>,bg=<outer_bg>` on exit) so it reads as one continuous shape — a pill pointed on only one edge (flat-cut on the other) reads as visually broken/discontinuous.

Also prefer Nerd Font PUA glyphs (e.g. `nf-fa-search` U+F002) over emoji (e.g. 🔍) in the status bar — emoji are double-width and render inconsistently across terminals, causing the bar to jitter/misalign; Nerd Font icons are single-width and stable. This aligns with [[feedback_prefers_rust_tools]]'s general preference for well-maintained, terminal-native tooling conventions.

**Why:** User asked to fix a "look uncontinuously" status bar and referenced mature GitHub repos for decoration style; confirmed the powerline-pill + Nerd-Font-icon fix ("ok that good") after I diagnosed the asymmetric-pill bug and validated the config with `tmux -f` before applying.

**How to apply:** When adding/editing tmux status-bar segments, always pair leading/trailing powerline arrows for any bg-colored block, and default to Nerd Font icons over emoji for icon decoration. Validate syntax with `tmux -L <tmp> -f <conf> new-session -d` before touching the user's live config, then apply with `tmux source-file ~/.tmux.conf` (symlinked via stow, so no restow needed unless the symlink is missing).

**Update 2026-10-21:** the active window tab (`1:claude`) must be plain bold colored text with a Nerd Font icon, styled like user@ip and the clock in status-right, **not** a pill. User: "it shouldn't be on the block ... as the text similar to the ip or the time". Pills stay for the session pill and the Agents label only; don't add new bg blocks to the bar unasked.

**Update 2026-10-29:** the ZOOM mode badge is now a filled cyan pill too — user asked for it ("should be highlighted ... too dim and easy to pass"). Plain-colored badge text in the Light font is easy to miss; for a state the user must notice, a filled pill is the accepted fix. Other badges (PREFIX/COPY/SYNC) are still plain text.
