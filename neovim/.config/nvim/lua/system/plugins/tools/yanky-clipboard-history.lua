return {
	"gbprod/yanky.nvim",
	event = { "BufReadPost", "TextYankPost" },
	opts = {
		-- kernel/autocommands.lua already flashes the yanked region; avoid a double flash
		highlight = { on_put = false, on_yank = false },
		ring      = { history_length = 100, storage = "shada" },
	},
	keys = {
		{ "y",  "<Plug>(YankyYank)",             mode = { "n", "x" }, desc = "Yank (ring-aware)" },
		{ "p",  "<Plug>(YankyPutAfter)",         mode = { "n", "x" }, desc = "Put After" },
		{ "P",  "<Plug>(YankyPutBefore)",        mode = { "n", "x" }, desc = "Put Before" },
		{ "gp", "<Plug>(YankyGPutAfter)",        mode = { "n", "x" }, desc = "Put After, Keep Cursor" },
		{ "gP", "<Plug>(YankyGPutBefore)",       mode = { "n", "x" }, desc = "Put Before, Keep Cursor" },
		{ "<C-p>", "<Plug>(YankyPreviousEntry)", desc = "Yank Ring: Cycle to Previous" },
		{ "<C-n>", "<Plug>(YankyNextEntry)",     desc = "Yank Ring: Cycle to Next" },
	},
}
