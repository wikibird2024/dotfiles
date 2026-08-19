return {
	"nvim-lualine/lualine.nvim",
	event        = "VeryLazy",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	config = function()
		local function hl_color(group, attr)
			local hl = vim.api.nvim_get_hl(0, { name = group, link = false })
			local val = hl[attr or "fg"]
			return val and string.format("#%06x", val) or nil
		end

		local function term(n, fallback)
			local v = vim.g["terminal_color_" .. n]
			if type(v) == "string" then return v end
			if type(v) == "number" then return string.format("#%06x", v) end
			return fallback
		end

		-- Central palette, derived live from the active colorscheme (Normal/
		-- CursorLine highlight groups + ANSI terminal colors, which every
		-- theme in colorscheme.lua sets via terminal_colors = true). Feeds
		-- lualine_theme() below so the mode block always matches.
		local function palette()
			local bg = hl_color("Normal", "bg") or "#1e222a"
			local fg = hl_color("Normal", "fg") or "#abb2bf"
			local mid = hl_color("CursorLine", "bg") or hl_color("Visual", "bg") or bg
			return {
				bg = bg,
				fg = fg,
				mid = mid,
				normal   = term(4, "#61afef"),
				insert   = term(2, "#98c379"),
				visual   = term(5, "#c678dd"),
				replace  = term(1, "#e06c75"),
				command  = term(3, "#e5c07b"),
				terminal = term(6, "#56b6c2"),
			}
		end

		-- Rounded pill caps around a single component. No color override here
		-- on purpose: each pill just inherits its section's a/b/c color from
		-- lualine_theme() below, so it always matches the active colorscheme.
		local function pill_shape()
			return { separator = { left = "", right = "" } }
		end

		local function lsp_name()
			local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
			if #clients == 0 then return "󰅚 No LSP" end
			local names = {}
			for _, client in ipairs(clients) do
				if client.name ~= "null-ls" then
					table.insert(names, client.name)
				end
			end
			if #names == 0 then return "󰅚 No LSP" end
			return "󰒋 " .. names[1]
		end

		local function macro_recording()
			local reg = vim.fn.reg_recording()
			if reg == "" then return "" end
			return "󰑋 @" .. reg
		end

		local function search_count()
			if vim.v.hlsearch == 0 then return "" end
			local ok, count = pcall(vim.fn.searchcount, { maxcount = 999 })
			if not ok or count.total == 0 then return "" end
			return string.format(" %d/%d", count.current, count.total)
		end

		-- Most colorschemes don't ship a matching lualine theme (or ship one
		-- that's intentionally flat, like abyss.nvim's). Build one live so
		-- the mode block looks right no matter which of the registered
		-- colorschemes (colorscheme.lua) is active.
		local function lualine_theme()
			local p = palette()
			local function pill(color)
				return { fg = p.bg, bg = color, gui = "bold" }
			end
			local b = { fg = p.fg, bg = p.mid }
			local sec_c = { fg = p.fg, bg = p.bg }
			return {
				normal   = { a = pill(p.normal),   b = b, c = sec_c },
				insert   = { a = pill(p.insert),   b = b, c = sec_c },
				visual   = { a = pill(p.visual),   b = b, c = sec_c },
				replace  = { a = pill(p.replace),  b = b, c = sec_c },
				command  = { a = pill(p.command),  b = b, c = sec_c },
				terminal = { a = pill(p.terminal), b = b, c = sec_c },
				inactive = { a = { fg = p.fg, bg = p.bg }, b = sec_c, c = sec_c },
			}
		end

		require("lualine").setup({
			options = {
				theme                = lualine_theme(),
				globalstatus         = true,
				icons_enabled        = true,
				component_separators = { left = "", right = "" },
				section_separators   = { left = "", right = "" },
				disabled_filetypes   = { statusline = { "alpha", "dashboard", "snacks_dashboard", "lazy" } },
				ignore_focus         = { "NvimTree", "toggleterm" },
				always_divide_middle = true,
			},
			sections = {
				lualine_a = { { "mode", separator = { left = "", right = "" } } },
				lualine_b = {
					vim.tbl_extend("force", { "branch", icon = "" }, pill_shape()),
					{
						"diff",
						colored = true,
						symbols = { added = " ", modified = " ", removed = " " },
						source  = function()
							local gs = vim.b.gitsigns_status_dict
							if gs then
								return { added = gs.added, modified = gs.changed, removed = gs.removed }
							end
						end,
					},
				},
				lualine_c = {
					{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
					{
						"filename",
						path         = 1,
						file_status  = true,
						newfile_status = true,
						symbols = {
							modified = " ●",
							readonly = " ",
							unnamed  = "[No Name]",
							newfile  = "[New]",
						},
						shorting_target = 40,
					},
					vim.tbl_extend("force", { search_count }, pill_shape()),
				},
				lualine_x = {
					vim.tbl_extend("force", { macro_recording }, pill_shape()),
					{ "selectioncount" },
					vim.tbl_extend("force", {
						"diagnostics",
						symbols = { error = " ", warn = " ", info = " ", hint = " " },
					}, pill_shape()),
					vim.tbl_extend("force", { lsp_name }, pill_shape()),
					vim.tbl_extend("force", { "filetype", icon_only = false, colored = false }, pill_shape()),
				},
				lualine_y = {
					vim.tbl_extend("force", { "encoding" }, pill_shape()),
					vim.tbl_extend("force", { "fileformat", icons_enabled = true }, pill_shape()),
					vim.tbl_extend("force", { "progress" }, pill_shape()),
				},
				lualine_z = {
					vim.tbl_extend("force", { "location", icon = "󰍍" }, pill_shape()),
					vim.tbl_extend("force", { function() return " " .. os.date("%H:%M") end }, pill_shape()),
				},
			},
			inactive_sections = {
				lualine_a = {},
				lualine_b = {},
				lualine_c = { { "filename", path = 1 } },
				lualine_x = { "location" },
				lualine_y = {},
				lualine_z = {},
			},
			tabline         = {},
			winbar          = {},
			inactive_winbar = {},
			extensions = {
				"lazy", "mason", "quickfix",
				"nvim-tree", "toggleterm", "fugitive",
			},
		})
	end,
}
