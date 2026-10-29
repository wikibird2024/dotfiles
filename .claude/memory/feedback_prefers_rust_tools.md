---
name: feedback-prefers-rust-tools
description: User prefers Rust-written CLI/LSP tools and plugins when modernizing the nvim config
metadata: 
  node_type: memory
  type: feedback
  originSessionId: 17ff4cff-ff33-4c47-8f45-7978b4b9ae0c
  modified: 2026-08-20T02:14:58.182Z
---

When suggesting new plugins/tools for the [[project-nvim-toolchain-overhaul]] nvim config (or similar tooling decisions elsewhere in the dotfiles), prefer options written in Rust when a credible one exists, and call out explicitly that it's Rust-based.

**Why:** User asked directly ("I refer plugin prom rust" / "find more interesting plugin that written by rust and community like to use and appreciate it") on 2026-08-20, after already approving swaps to `blink.cmp`/`blink.pairs` and adding `ruff`/`typos-lsp`/`taplo`. This is a stated aesthetic + performance preference, not a one-off request.

**How to apply:** When a Rust and a non-Rust option are both reasonable for some new capability, default to proposing the Rust one first (and mention the tradeoff if the Rust option is less mature). Verify the plugin/tool actually exists and is Rust-based via a real source (WebSearch/WebFetch) before proposing it by name — a prior guess in this same session (`cokeline.nvim` believed to be Rust) turned out to be wrong on verification, so don't rely on memory alone for "is X written in Rust" claims.
