return {
	{
		"akinsho/bufferline.nvim",
		version = "*",
		event = "VeryLazy",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},

		config = function()
			require("bufferline").setup({
				options = {
					------------------------------------------------------------------
					-- Buffer display
					------------------------------------------------------------------
					mode = "buffers",
					numbers = "ordinal",

					------------------------------------------------------------------
					-- LSP diagnostics
					------------------------------------------------------------------
					diagnostics = "nvim_lsp",
					diagnostics_update_in_insert = false,

					diagnostics_indicator = function(count, level)
						local icon = level:match("error") and " " or " "
						return string.format("%s%d", icon, count)
					end,

					------------------------------------------------------------------
					-- Buffer management
					------------------------------------------------------------------
					persist_buffer_sort = true,
					sort_by = "insert_after_current",

					max_name_length = 24,
					max_prefix_length = 15,
					truncate_names = true,

					------------------------------------------------------------------
					-- Appearance
					------------------------------------------------------------------
					separator_style = "thin",
					always_show_bufferline = true,

					show_tab_indicators = true,
					show_close_icon = false,
					show_buffer_close_icons = false,

					hover = {
						enabled = false,
					},

					------------------------------------------------------------------
					-- Neo-tree integration
					------------------------------------------------------------------
					offsets = {
						{
							filetype = "neo-tree",
							text = "Explorer",
							text_align = "left",
							highlight = "Directory",
							separator = true,
						},
					},
				},

				----------------------------------------------------------------------
				-- Only change emphasis, let the colorscheme provide all colors.
				----------------------------------------------------------------------
				highlights = {
					buffer_selected = {
						bold = true,
						italic = false,
					},

					numbers_selected = {
						bold = true,
					},

					diagnostic_selected = {
						bold = true,
					},

					hint_selected = {
						bold = true,
					},

					info_selected = {
						bold = true,
					},

					warning_selected = {
						bold = true,
					},

					error_selected = {
						bold = true,
					},
				},
			})
		end,
	},
}
