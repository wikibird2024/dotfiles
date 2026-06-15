return {
	{
		"lukas-reineke/indent-blankline.nvim",
		event = "BufReadPre",
		config = function()
			local ibl = require("ibl")

			-- Two alternating colors for indent guides (subtle contrast)
			local indent_highlights = { "IndentLevel1", "IndentLevel2" }
			for i, hl in ipairs(indent_highlights) do
				local colors = { "#555555", "#AAAAAA" }
				vim.api.nvim_set_hl(0, hl, { fg = colors[i], nocombine = true })
			end

			-- Bright accent for the active scope line
			vim.api.nvim_set_hl(0, "CurrentScopeHighlight", { fg = "#FFFF00", nocombine = true })

			ibl.setup({
				indent = {
					char              = "│",
					tab_char          = "│",
					highlight         = indent_highlights,
					smart_indent_cap  = true,
				},
				scope = {
					enabled    = true,
					show_start = true,
					show_end   = true,
					highlight  = "CurrentScopeHighlight",
				},
				exclude = {
					filetypes = {
						"help", "startify", "dashboard",
						"lazy", "neo-tree", "Trouble",
						"markdown", "text",
						"gitcommit", "diff",
					},
				},
			})
		end,
	},
}
