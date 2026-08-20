return {
	{
		"saghen/blink.cmp",
		event   = { "InsertEnter", "CmdlineEnter" },
		version = "1.*", -- downloads a prebuilt fuzzy-matcher binary, no Rust toolchain needed
		dependencies = { "folke/lazydev.nvim" },
		opts = {
			keymap = {
				preset = "none",
				["<C-j>"] = { "select_next", "fallback" },
				["<C-k>"] = { "select_prev", "fallback" },
				-- Unified Tab: Copilot ghost text first, then accept-if-selected, then snippet jump, else raw Tab
				["<Tab>"] = {
					function(_)
						local ok, suggestion = pcall(require, "copilot.suggestion")
						if ok and suggestion.is_visible() then
							suggestion.accept()
							return true
						end
					end,
					"select_and_accept",
					"snippet_forward",
					"fallback",
				},
				["<S-Tab>"]   = { "snippet_backward", "fallback" },
				["<C-space>"] = { "show", "show_documentation", "hide_documentation" },
				["<C-e>"]     = { "hide", "fallback" },
				["<C-d>"]     = { "scroll_documentation_down", "fallback" },
				["<C-u>"]     = { "scroll_documentation_up", "fallback" },
			},
			completion = {
				-- preselect=false + auto_insert=false mirrors the old cmp.confirm({select=false}):
				-- Tab only accepts an item once you've explicitly navigated to it with <C-j>,
				-- and nothing gets inserted as ghost preview text that would fight Copilot's own overlay.
				list = { selection = { preselect = false, auto_insert = false } },
				menu = {
					border       = "rounded",
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
				},
				documentation = {
					auto_show       = true,
					auto_show_delay_ms = 200,
					window          = { border = "rounded" },
				},
				-- Auto-insert () after accepting a function completion (replaces the old
				-- nvim-autopairs <-> nvim-cmp bridge; pairing itself now lives in tools/blink-pairs.lua).
				accept = { auto_brackets = { enabled = true } },
			},
			snippets = { preset = "luasnip" },
			sources = {
				default      = { "lsp", "path", "snippets", "buffer" },
				per_filetype = { lua = { "lazydev", "lsp", "path", "snippets", "buffer" } },
				providers = {
					lazydev = {
						name         = "LazyDev",
						module       = "lazydev.integrations.blink",
						score_offset = 100,
					},
				},
			},
			cmdline = {
				enabled = true,
				keymap  = { preset = "cmdline" },
				completion = { menu = { auto_show = true } },
			},
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
	},
}
