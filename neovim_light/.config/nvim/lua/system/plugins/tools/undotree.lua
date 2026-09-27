return {
	"mbbill/undotree",
	cmd  = "UndotreeToggle",
	keys = {
		{ "<leader>uu", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree" },
	},
	init = function()
		vim.g.undotree_WindowLayout       = 2   -- tree on left, diff below
		vim.g.undotree_ShortIndicators    = 1
		vim.g.undotree_SetFocusWhenToggle = 1
	end,
}
