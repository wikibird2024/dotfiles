return {
	{
		"akinsho/bufferline.nvim",
		version      = "*",
		event        = "BufReadPre",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			require("bufferline").setup({
				options = {
					diagnostics = "nvim_lsp",
				},
			})
		end,
	},
}
