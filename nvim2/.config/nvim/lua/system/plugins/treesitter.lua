return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = { "BufReadPost", "BufNewFile" },

		-- FIX 1: Changed "nvim-treesitter.configs" to "nvim-treesitter.config"
		main = "nvim-treesitter.config",

		opts = function()
			local max_filesize = 500 * 1024

			return {
				ensure_installed = {
					"c",
					"cpp",
					"rust",
					"python",
					"lua",
					"vim",
					"vimdoc",
					"query",
					"cmake",
					"markdown",
					"markdown_inline",
					"bash",
					"json",
					"bibtex",
				},

				sync_install = false,
				auto_install = true,

				highlight = {
					enable = true,
					disable = function(_, buf)
						local ok, stat = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
						return ok and stat and stat.size > max_filesize
					end,
				},

				indent = {
					enable = true,
				},

				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = false,
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
							["ai"] = "@conditional.outer",
							["ii"] = "@conditional.inner",
							["al"] = "@loop.outer",
							["il"] = "@loop.inner",
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

					swap = {
						enable = true,
						swap_next = {
							["<leader>na"] = "@parameter.inner",
						},
						swap_previous = {
							["<leader>pa"] = "@parameter.inner",
						},
					},
				},
			}
		end,
		-- FIX 2: Removed manual 'config = function(_, opts)...' block.
		-- 'main' instructs lazy.nvim to execute require("nvim-treesitter.config").setup(opts) automatically.
	},

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
