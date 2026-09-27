return {
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		config = function()
			local ibl = require("ibl")

			-- Resolve colors from the active theme so they survive colorscheme switches
			local function hl_fg(group)
				local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group, link = false })
				return (ok and hl.fg) and string.format("#%06x", hl.fg) or nil
			end

			-- Indent lines: use Comment fg (dim) and a slightly brighter variant
			local dim   = hl_fg("Comment")  or "#444444"
			local light = hl_fg("LineNr")   or "#666666"
			-- Scope: use a muted accent rather than a blinding color
			local scope = hl_fg("Function") or "#83a598"

			vim.api.nvim_set_hl(0, "IblIndent1",    { fg = dim,   nocombine = true })
			vim.api.nvim_set_hl(0, "IblIndent2",    { fg = light, nocombine = true })
			vim.api.nvim_set_hl(0, "IblScopeAccent",{ fg = scope, nocombine = true })

			ibl.setup({
				indent = {
					char             = "│",
					tab_char         = "│",
					highlight        = { "IblIndent1", "IblIndent2" },
					smart_indent_cap = true,
				},
				scope = {
					enabled    = true,
					show_start = false,  -- start/end underlines are noisy for most users
					show_end   = false,
					highlight  = "IblScopeAccent",
				},
				exclude = {
					filetypes = {
						"help", "alpha", "dashboard", "startify",
						"lazy", "neo-tree", "Trouble", "trouble",
						"text", "gitcommit", "diff", "aerial",
						"toggleterm",
					},
				},
			})
		end,
	},
}
