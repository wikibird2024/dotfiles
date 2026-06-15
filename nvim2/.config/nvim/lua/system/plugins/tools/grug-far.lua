return {
	"MagicDuck/grug-far.nvim",
	cmd = "GrugFar",
	keys = {
		{
			"<leader>sr",
			function() require("grug-far").open({ prefills = { search = vim.fn.expand("<cword>") } }) end,
			desc = "Search & Replace (word)",
		},
		{
			"<leader>sr",
			function() require("grug-far").with_visual_selection() end,
			mode = "v",
			desc = "Search & Replace (selection)",
		},
		{
			"<leader>sR",
			function() require("grug-far").open() end,
			desc = "Search & Replace",
		},
	},
	opts = {
		headerMaxWidth = 80,
	},
}
