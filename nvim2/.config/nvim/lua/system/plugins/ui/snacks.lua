return {
	"folke/snacks.nvim",
	event = "VeryLazy",
	opts = {
		-- input only: owns vim.ui.input (rename prompts, etc).
		-- picker is left disabled on purpose -- fzf-lua already owns
		-- vim.ui.select and file/grep pickers; enabling snacks.picker
		-- here would duplicate that instead of replacing dressing.nvim.
		input = {
			enabled = true,
			win = {
				relative = "cursor",
				row      = -3,
				col      = 0,
				border   = "rounded",
			},
		},
	},
}
