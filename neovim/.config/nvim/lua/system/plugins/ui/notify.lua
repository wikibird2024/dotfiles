return {
	"rcarriga/nvim-notify",
	-- Trying snacks.notifier instead (ui/snacks.lua). To revert: set true here, disable notifier there.
	enabled = false,
	event  = "VeryLazy",
	opts   = {
		timeout  = 3000,
		render   = "compact",
		stages   = "fade",
		max_width = 50,
	},
	config = function(_, opts)
		local notify = require("notify")
		notify.setup(opts)
		vim.notify = notify
	end,
}
