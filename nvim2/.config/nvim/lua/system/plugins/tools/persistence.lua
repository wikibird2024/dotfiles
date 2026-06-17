return {
	"folke/persistence.nvim",
	event = "VimEnter",        -- must load at startup to hook VimLeavePre for auto-save
	opts  = { options = { "buffers", "curdir", "tabpages", "winsize" } },
	config = function(_, opts)
		require("persistence").setup(opts)
		-- Do NOT auto-restore here — user triggers it manually via keymaps below
	end,
	keys = {
		{ "<leader>qs", function() require("persistence").load()               end, desc = "Session: Restore Current Dir" },
		{ "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Session: Restore Last"        },
	},
}
