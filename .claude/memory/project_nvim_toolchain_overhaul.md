---
name: project-nvim-toolchain-overhaul
description: "2026-08-20 modernization of the neovim/.config/nvim config — mason, blink.cmp/pairs, ruff/typos-lsp/taplo, current LSP server list"
metadata: 
  node_type: memory
  type: project
  originSessionId: 17ff4cff-ff33-4c47-8f45-7978b4b9ae0c
  modified: 2026-08-20T02:15:10.910Z
---

On 2026-08-20, the active nvim config (`neovim/.config/nvim/` in `/home/greystone/dotfiles` — the `neovim` stow package is currently linked to `~/.config/nvim`, per [[project-dotfiles-stow-quirks]]) was modernized in one extended session. Treat the state below as current; don't suggest re-adding the replaced tools.

**Completion/pairs engine swap:**
- `nvim-cmp` → `blink.cmp` (`lua/system/plugins/cmp/init.lua`, path kept despite the rename for minimal churn). Same keybinds preserved (`<C-j>/<C-k>` select, `<Tab>` Copilot-first-then-accept-then-snippet, `<S-Tab>`, `<C-Space>/<C-e>/<C-d>/<C-u>`). Snippets still via `luasnip`, driven through blink's `snippets.preset = "luasnip"`.
- `nvim-autopairs` → `blink.pairs` (`lua/system/plugins/tools/blink-pairs.lua`) — adds rainbow bracket highlighting. Lost nvim-autopairs' `<M-e>` fast-wrap; gained `<C-b>`/`<C-S-b>` motion-wrap instead.

**LSP additions** (`lua/system/plugins/lsp/servers/`): `lua_ls` (+ `lazydev.nvim` for `vim.*`/plugin-require awareness), `bashls`, `ruff`, `typos_lsp`, `taplo`. Full active server list is now: `texlab, pyright, clangd, lua_ls, bashls, ruff, typos_lsp, taplo` plus `rust-analyzer` via rustaceanvim (separate, `lsp/rust.lua`).

**Tool management:** `mason.nvim` + `mason-tool-installer.nvim` added (`lua/system/plugins/lsp/mason.lua`) — previously nothing managed LSP/DAP binaries despite CLAUDE.md referencing `:MasonInstall`. `ensure_installed` covers `clangd, pyright, texlab, lua-language-server, bash-language-server, codelldb, ruff, typos-lsp, taplo`. `rust-analyzer` deliberately excluded (rustaceanvim manages it itself).

**Formatting/linting:** Python `black`+`flake8` fully replaced by `ruff` (format + organize-imports + lint, all via ruff's own LSP — not duplicated in nvim-lint). `.toml` now formatted by `taplo`. CLAUDE.md's manual-install list no longer includes black/flake8.

**Other additions:** `yanky.nvim` (yank ring, `<C-p>`/`<C-n>` cycle after paste), `fidget.nvim` (LSP progress spinner — noice's own `lsp.progress` was turned off to avoid a duplicate progress UI), `snacks.bigfile`/`snacks.quickfile` enabled (free, already-installed plugin).

See [[feedback-prefers-rust-tools]] for the user's stated preference driving several of these picks. CLAUDE.md and the nvim README were both updated to match; verify they're still accurate before trusting old descriptions if this memory looks stale.
