return {
	"folke/trouble.nvim",
	cmd          = "Trouble",
	dependencies = "nvim-tree/nvim-web-devicons",
	opts = {
		-- trouble.nvim v3 API
		modes = {
			diagnostics = {
				auto_open    = false,
				auto_close   = true,
				auto_preview = true,
			},
		},
	},
}
