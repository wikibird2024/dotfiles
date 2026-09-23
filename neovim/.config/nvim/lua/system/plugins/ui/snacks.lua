-- Dashboard logo with a vertical gradient between two colours of the active
-- colorscheme (Function -> Keyword), so it matches whatever theme is loaded.
local function gradient_logo(self)
	local function channels(c) return math.floor(c / 65536) % 256, math.floor(c / 256) % 256, c % 256 end
	local from = vim.api.nvim_get_hl(0, { name = "Function", link = false }).fg or 0x7aa2f7
	local to   = vim.api.nvim_get_hl(0, { name = "Keyword",  link = false }).fg or 0xbb9af7
	local r1, g1, b1 = channels(from)
	local r2, g2, b2 = channels(to)

	local lines = vim.split(self.opts.preset.header, "\n")
	local text = {}
	for i, line in ipairs(lines) do
		local t = (i - 1) / math.max(#lines - 1, 1)
		local mix = function(a, b) return math.floor(a + (b - a) * t + 0.5) end
		local hl = "SnacksDashboardLogo" .. i
		vim.api.nvim_set_hl(0, hl, { fg = mix(r1, r2) * 65536 + mix(g1, g2) * 256 + mix(b1, b2), bold = true })
		text[#text + 1] = { line .. (i < #lines and "\n" or ""), hl = hl }
	end
	local v = vim.version()
	return {
		{ text = text, align = "center", padding = 1 },
		{ text = { { ("v%d.%d.%d"):format(v.major, v.minor, v.patch), hl = "Comment" } }, align = "center", padding = 2 },
	}
end

return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		{ "<leader>uz", function() Snacks.zen() end, desc = "Zen Mode" },
		{ "<leader>un", function() Snacks.notifier.hide() end,         desc = "Dismiss Notifications" },
		{ "<leader>uN", function() Snacks.notifier.show_history() end, desc = "Notification History" },
	},
	opts = {
		-- Owns vim.notify (replaces nvim-notify, see ui/notify.lua).
		notifier = {
			enabled = true,
			timeout = 3000,
			style   = "compact",
		},

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
				gradient_logo,
				{ section = "keys", gap = 1, padding = 1 },
				{ section = "startup" },
			},
		},

		-- Smooth scrolling; effectively free since snacks.nvim is already loaded.
		scroll = { enabled = true },

		-- Detect very large files and disable treesitter/LSP/other heavy features
		-- on them to avoid freezing the editor.
		bigfile = { enabled = true },

		-- Paint file content before plugins finish loading, for a faster first paint.
		quickfile = { enabled = true },

		-- True distraction-free zen mode (layout change), separate from
		-- twilight.nvim's dimming (<leader>z, see twilight-focus-dim.lua).
		zen = {
			enabled = true,
			toggles = { dim = true },
			win     = { style = "zen" },
		},
	},
}
