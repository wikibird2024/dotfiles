return {
	"stevearc/aerial.nvim",
	event        = { "BufReadPost", "BufNewFile" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons",
	},
	keys = {
		{ "<leader>lo", "<cmd>AerialToggle!<CR>", desc = "Outline" },
	},
	opts = {
		backends     = { "treesitter", "lsp" },
		attach_mode  = "global",   -- one outline shared across all buffers in a window
		layout = {
			max_width         = { 40, 0.2 },
			min_width         = 25,
			default_direction = "right",
			placement         = "edge",
		},
		show_guides  = true,
		guides = {
			mid_item   = "├─",
			last_item  = "└─",
			nested_top = "│ ",
			whitespace = "  ",
		},
		filter_kind = {
			"Class", "Constructor", "Enum", "Function",
			"Interface", "Module", "Method", "Struct",
		},
	},
}