return {
	"folke/persistence.nvim",
	event = "BufReadPre", -- Super lightweight, loads passively
	opts = { options = { "buffers", "curdir", "tabpages", "winsize" } },
	keys = {
		{
			"<leader>qs",
			function()
				require("persistence").load()
			end,
			desc = "Session: Restore Current Directory",
		},
		{
			"<leader>ql",
			function()
				require("persistence").load({ last = true })
			end,
			desc = "Session: Restore Last Session",
		},
	},
}
