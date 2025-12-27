-- lua/system/plugins/treesitter.lua
return {
	"nvim-treesitter/nvim-treesitter",
	branch = "master",
	build = ":TSUpdate",
	lazy = false,
	dependencies = {
		"nvim-treesitter/nvim-treesitter-textobjects",
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = {
				"c",
				"cpp",
				"rust",
				"python",
				"lua",
				"vim",
				"vimdoc",
				"query",
				"markdown",
				"markdown_inline",
				"bash",
				"json",
				"latex",
				"bibtex",
			},

			highlight = {
				enable = true,
				disable = function(lang, buf)
					local max_filesize = 500 * 1024 -- 500 KB
					local ok, stat = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stat and stat.size > max_filesize then
						return true
					end
				end,
			},

			indent = { enable = true },

			-- 1. CHỌN KHỐI CODE (Selection)
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},

			-- 2. SIÊU NĂNG LỰC TEXTOBJECTS (PRO CONFIG)
			textobjects = {
				-- Chọn nhanh: vif, vaf, vic, vac
				select = {
					enable = true,
					lookahead = true,
					keymaps = {
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						["ai"] = "@conditional.outer", -- Chọn toàn bộ khối if-else
						["ii"] = "@conditional.inner",
					},
				},

				-- Di chuyển nhanh: ]f (hàm sau), [f (hàm trước)
				move = {
					enable = true,
					set_jumps = true, -- Lưu vào danh sách jump (Ctrl+o để quay lại)
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
					},
				},

				-- Hoán đổi vị trí: <leader>na (đổi chỗ tham số trong hàm)
				swap = {
					enable = true,
					swap_next = {
						["<leader>na"] = "@parameter.inner", -- swap next argument
					},
					swap_previous = {
						["<leader>pa"] = "@parameter.inner", -- swap previous argument
					},
				},
			},
		})
	end,
}
