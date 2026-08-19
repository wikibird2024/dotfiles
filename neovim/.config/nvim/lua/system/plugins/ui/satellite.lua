return {
	"lewis6991/satellite.nvim",
	event        = { "BufReadPost", "BufNewFile" },
	dependencies = { "lewis6991/gitsigns.nvim" },  -- load order against git.lua
	opts = {
		width    = 2,
		winblend = 50,
		handlers = {
			cursor     = { enable = true },
			search     = { enable = true },
			diagnostic = { enable = true },
			gitsigns   = { enable = true },
			marks      = { enable = true },
			quickfix   = { enable = true },
		},
	},
}
