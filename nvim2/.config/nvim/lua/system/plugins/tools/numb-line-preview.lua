return {
	"nacro90/numb.nvim",
	event = "CmdlineEnter",
	config = function()
		require("numb").setup({
			show_numbers      = true,
			show_cursorline   = true,
			number_only       = true,   -- Only activate on numeric input
			centered_peeking  = true,   -- Preview stays centered on screen
			delay             = 40,     -- ms — feels instant without jitter
			hide_relativenumbers = true,
		})
	end,
}
