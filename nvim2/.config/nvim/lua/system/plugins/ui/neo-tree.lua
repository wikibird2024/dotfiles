return {
	"nvim-neo-tree/neo-tree.nvim",
	branch   = "v3.x",
	lazy     = false,
	priority = 1000,
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Explorer Toggle" },
		{ "<leader>o", "<cmd>Neotree focus<CR>",  desc = "Explorer Focus"  },
		{ "<leader>r", "<cmd>Neotree reveal<CR>", desc = "Reveal File"     },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			window = {
				width = 28,
				mappings = {
					["l"] = "open",
					["h"] = "close_node",
					["v"] = "open_vsplit",
					["s"] = "open_split",
					["P"] = { "toggle_preview", config = { use_float = true } },
				},
			},
			filesystem = {
				follow_current_file    = { enabled = true },
				use_libuv_file_watcher = true,
				filtered_items = {
					hide_dotfiles   = false,
					hide_gitignored = false,
					hide_by_name    = { ".git" },
				},
			},
		})
	end,
}
