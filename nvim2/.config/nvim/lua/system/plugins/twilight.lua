return {
	"folke/twilight.nvim",
	cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
	keys = {
		{ "<leader>z", "<cmd>Twilight<CR>", desc = "Twilight (dim inactive code)" },
	},
	opts = {
		dimming = {
			alpha       = 0.25,
			color       = { "Normal", "#ffffff" },
			term_bg     = "#000000",
			-- must stay true: false makes twilight run treesitter context on
			-- every other window on toggle, which crashes if that window's
			-- buffer has no parser attached (e.g. terminal/quickfix splits)
			inactive    = true,
		},
		context           = 12,
		treesitter        = true,
		expand            = {
			"function",
			"method",
			"table",
			"if_statement",
		},
		exclude = {},
	},
}
