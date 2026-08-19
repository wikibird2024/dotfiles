return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	cmd    = "Neotree",
	keys = {
		{ "<leader>e", "<cmd>Neotree toggle<CR>", desc = "Explorer Toggle" },
		{ "<leader>o", "<cmd>Neotree focus<CR>",  desc = "Explorer Focus"  },
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		"nvim-tree/nvim-web-devicons",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window   = true,
			popup_border_style     = "rounded",
			enable_git_status      = true,
			enable_diagnostics     = true,
			sort_case_insensitive  = true,
			window = {
				width    = 30,
				position = "left",
				mappings = {
					["l"] = "open",
					["h"] = "close_node",
					["v"] = "open_vsplit",
					["s"] = "open_split",
					["P"] = { "toggle_preview", config = { use_float = true } },
					["<space>"] = "none",  -- prevent conflict with leader
				},
			},
			default_component_configs = {
				indent = {
					with_expanders       = true,
					expander_collapsed   = "",
					expander_expanded    = "",
				},
				icon = {
					folder_closed = "",
					folder_open   = "",
					folder_empty  = "󰜌",
				},
				git_status = {
					symbols = {
						added     = "",
						modified  = "",
						deleted   = "✖",
						renamed   = "󰁕",
						untracked = "",
						ignored   = "",
						unstaged  = "󰄱",
						staged    = "",
						conflict  = "",
					},
				},
			},
			filesystem = {
				follow_current_file    = { enabled = true, leave_dirs_open = false },
				use_libuv_file_watcher = true,
				hijack_netrw_behavior  = "open_default",
				filtered_items = {
					visible         = false,
					hide_dotfiles   = false,
					hide_gitignored = false,
					hide_by_name    = { ".git", "node_modules", "__pycache__" },
				},
			},
		})
	end,
}