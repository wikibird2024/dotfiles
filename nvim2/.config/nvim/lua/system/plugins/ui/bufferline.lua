return {
	{
		"akinsho/bufferline.nvim",
		version      = "*",
		event        = "BufReadPre",
		dependencies = "nvim-tree/nvim-web-devicons",
		config = function()
			local ok, mocha = pcall(require, "catppuccin.palettes")
			-- Highlights are left to the theme; we only configure behaviour here
			require("bufferline").setup({
				options = {
					mode              = "buffers",
					numbers           = "none",
					diagnostics       = "nvim_lsp",
					diagnostics_indicator = function(count, level)
						local icons = { error = " ", warning = " " }
						local icon  = level:match("error") and icons.error or icons.warning
						return icon .. count
					end,
					show_buffer_close_icons = true,
					show_close_icon         = false,
					show_tab_indicators     = true,
					separator_style         = "thin",   -- slant | slope | thin | thick
					always_show_bufferline  = true,
					hover = {
						enabled = true,
						delay   = 150,
						reveal  = { "close" },
					},
					offsets = {
						{
							filetype   = "neo-tree",
							text       = "  Explorer",
							highlight  = "Directory",
							separator  = true,
						},
					},
				},
			})
		end,
	},
}
