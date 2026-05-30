-- ~/.config/nvim/lua/system/plugins/tools/telescope.lua

return {
	"nvim-telescope/telescope.nvim",
	branch = "0.1.x",

	-- FIXED: Just like your old fzf config, this loads Telescope
	-- automatically whenever a ":Telescope" command is executed!
	cmd = "Telescope",

	dependencies = {
		"nvim-lua/plenary.nvim",
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},

	config = function()
		local telescope = require("telescope")
		local actions = require("telescope.actions")

		telescope.setup({
			defaults = {
				prompt_prefix = "   ",
				selection_caret = "❯ ",
				sorting_strategy = "ascending",
				path_display = { "truncate" },
				layout_strategy = "horizontal",

				layout_config = {
					horizontal = {
						prompt_position = "top",
						preview_width = 0.55,
						results_width = 0.8,
					},
					width = 0.87,
					height = 0.80,
					preview_cutoff = 120,
				},

				mappings = {
					i = {
						["<C-j>"] = actions.move_selection_next,
						["<C-k>"] = actions.move_selection_previous,
						["<Esc>"] = actions.close,
						["<C-u>"] = false,
					},
					n = {
						["q"] = actions.close,
					},
				},
			},

			pickers = {
				find_files = {
					previewer = true,
					hidden = true,
				},
				buffers = {
					sort_lastused = true,
					previewer = true,
					ignore_current_buffer = true,
				},
				live_grep = {
					theme = "ivy",
				},
				oldfiles = {
					prompt_title = "History",
				},
			},
		})

		-- Load the performance fzf extension compiled dependency
		pcall(telescope.load_extension, "fzf")
	end,
}
