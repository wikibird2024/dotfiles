return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		{ "<leader>uz", function() Snacks.zen() end, desc = "Zen Mode" },
	},
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

		-- Start screen. Wired to plugins already installed elsewhere in this
		-- config instead of snacks' own picker (fzf-lua owns file/grep pickers).
		dashboard = {
			enabled = true,
			preset = {
				header = [[
███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗
████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║
██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║
██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║
██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║
╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝]],
				keys = {
					{ icon = " ", key = "f", desc = "Find File",    action = ":FzfLua files" },
					{ icon = " ", key = "g", desc = "Find Text",    action = ":FzfLua live_grep" },
					{ icon = " ", key = "r", desc = "Recent Files", action = ":FzfLua oldfiles" },
					{ icon = " ", key = "n", desc = "New File",     action = ":ene | startinsert" },
					{
						icon = " ", key = "s", desc = "Restore Session",
						action = function()
							local p = require("persistence")
							if vim.fn.filereadable(p.current()) == 1 then p.load()
							else vim.notify("No session for this directory", vim.log.levels.WARN) end
						end,
					},
					{ icon = " ", key = "c", desc = "Edit Config",  action = ":e $MYVIMRC" },
					{ icon = "󰒲 ", key = "L", desc = "Lazy",         action = ":Lazy" },
					{ icon = " ", key = "q", desc = "Quit",         action = ":qa" },
				},
			},
			sections = {
				{ section = "header" },
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},

		-- Smooth scrolling; effectively free since snacks.nvim is already loaded.
		scroll = { enabled = true },

		-- True distraction-free zen mode (layout change), separate from
		-- twilight.nvim's dimming (<leader>z, see twilight-focus-dim.lua).
		zen = {
			enabled = true,
			toggles = { dim = true },
			win     = { style = "zen" },
		},
	},
}
