return {
	"rachartier/tiny-inline-diagnostic.nvim",
	event    = "VeryLazy",
	priority = 1000,   -- must render before other diagnostic-consuming plugins attach
	opts     = {
		preset  = "modern",
		options = {
			show_source  = { enabled = true, if_many = true },
			multilines   = { enabled = true },
		},
	},
	-- virtual_text is disabled in constitution/lsp_ui.lua; this plugin renders
	-- in its place and inherits the same severity icons from that config.
}
