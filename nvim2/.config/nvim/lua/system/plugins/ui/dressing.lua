return {
	"stevearc/dressing.nvim",
	event = "VeryLazy",
	opts  = {
		input = {
			enabled      = true,
			border       = "rounded",
			win_options  = { winblend = 0 },
			relative     = "cursor",    -- popup appears near cursor
		},
		select = {
			enabled  = true,
			backend  = { "fzf_lua", "builtin" },  -- use fzf-lua for select menus
		},
	},
}
