return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",

		event = { "BufReadPost", "BufNewFile" },

		dependencies = {
			"nvim-treesitter/nvim-treesitter-textobjects",
		},

		opts = {
			ensure_installed = {
				"bash",
				"c",
				"cpp",
				"cmake",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"python",
				"rust",
				"json",
				"markdown",
				"markdown_inline",
			},

			auto_install = true,

			highlight = {
				enable = true,
				additional_vim_regex_highlighting = false,
			},

			indent = {
				enable = true,
			},

			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					node_decremental = "<BS>",
				},
			},

			textobjects = {
				select = {
					enable = true,
					lookahead = true,

					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",

						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
					},
				},

				move = {
					enable = true,
					set_jumps = true,

					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
					},

					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
					},
				},
			},
		},

		config = function(_, opts)
			require("nvim-treesitter.configs").setup(opts)
		end,
	},
}
