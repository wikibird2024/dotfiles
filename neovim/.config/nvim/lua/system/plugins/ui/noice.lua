return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = { "MunifTanjim/nui.nvim" },
	opts = {
		lsp = {
			progress  = { enabled = true },
			hover     = { enabled = true, border = "rounded" },
			signature = { enabled = true, auto_open = { enabled = true, trigger = true } },
			-- kills "Press ENTER to continue" prompts for routine LSP messages
			message   = { enabled = true, view = "notify" },
			override  = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"]                = true,
			},
		},
		presets = {
			bottom_search         = true,
			command_palette       = true,
			long_message_to_split = true,
			lsp_doc_border        = true,
			-- pairs with tools/inc-rename-lsp-preview.lua
			inc_rename             = true,
		},
		-- ui/notify.lua already owns vim.notify end to end; noice only
		-- takes cmdline/popupmenu/LSP UI, never notifications.
		notify   = { enabled = false },
		messages = { view = "notify", view_error = "notify", view_warn = "notify" },
	},
}
