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
		backends = { "treesitter", "lsp" },
		layout   = {
			max_width         = { 40, 0.2 },
			min_width         = 25,
			default_direction = "right",
		},
		show_guides = true,
	},
}
