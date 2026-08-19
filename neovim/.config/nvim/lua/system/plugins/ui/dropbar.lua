return {
	"Bekaboo/dropbar.nvim",
	event = "BufReadPost",
	config = function()
		require("dropbar").setup()

		local api = require("dropbar.api")
		vim.keymap.set("n", "<leader>up", api.pick, { desc = "Breadcrumb Picker" })
	end,
}
