return {
	"echasnovski/mini.bracketed",
	event = "VeryLazy",
	opts = {
		-- disable targets already covered by other plugins
		treesitter = { suffix = "" },   -- flash handles node-jumping
		comment    = { suffix = "C" },  -- avoid clash with ]c (class, from treesitter)
		quickfix   = { suffix = "" },   -- quicker.nvim owns ]q/[q with wrap-around logic
	},
}
