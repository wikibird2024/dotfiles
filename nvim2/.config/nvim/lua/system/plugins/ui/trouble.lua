return {
	"folke/trouble.nvim",
	cmd          = "Trouble",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		modes = {
			diagnostics = {
				auto_open   = false,
				auto_close  = true,
				auto_preview = true,
			},
		},
		icons = {
			error       = " ",
			warning     = " ",
			hint        = " ",
			information = " ",
		},
		signs = {
			error       = " ",
			warning     = " ",
			hint        = " ",
			information = " ",
			other       = " ",
		},
		use_diagnostic_signs = true,
	},
}