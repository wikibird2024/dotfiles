return {
	"stevearc/oil.nvim",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "-", "<cmd>Oil<CR>", desc = "Open parent directory (oil)" },
	},
	opts = {
		default_file_explorer = false,
		view_options = { show_hidden = true },
		float = { border = "rounded" },
	},
}
