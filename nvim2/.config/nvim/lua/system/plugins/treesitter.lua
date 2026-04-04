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
			-- Danh sách ngôn ngữ tự động cài đặt
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
				"latex",
				"bibtex",
			},

			-- Tự động cài đặt parser nếu chưa có
			auto_install = true,
			sync_install = false,

			highlight = {
				enable = true,
				-- Tắt highlight cho file quá nặng để tránh lag
				disable = function(lang, buf)
					local max_filesize = 500 * 1024 -- 500 KB
					local ok, stat = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
					if ok and stat and stat.size > max_filesize then
						return true
					end
				end,
				additional_vim_regex_highlighting = false,
			},

			indent = { enable = true },

			-- 1. CHỌN KHỐI CODE THÔNG MINH (Incremental Selection)
			incremental_selection = {
				enable = true,
				keymaps = {
					init_selection = "<C-space>",
					node_incremental = "<C-space>",
					scope_incremental = false,
					node_decremental = "<bs>",
				},
			},

			-- 2. TEXTOBJECTS (Phím tắt thao tác nhanh)
			textobjects = {
				select = {
					enable = true,
					lookahead = true, -- Tự động nhảy đến node gần nhất
					keymaps = {
						-- Chọn nhanh: vif (trong hàm), vaf (ngoài hàm)
						["af"] = "@function.outer",
						["if"] = "@function.inner",
						["ac"] = "@class.outer",
						["ic"] = "@class.inner",
						-- Chọn nhanh khối If-Else, Vòng lặp, Scope
						["ai"] = "@conditional.outer",
						["ii"] = "@conditional.inner",
						["al"] = "@loop.outer",
						["il"] = "@loop.inner",
						["as"] = "@scope.outer",
						["is"] = "@scope.inner",
					},
				},

				-- Di chuyển nhanh: ]f (hàm kế tiếp), [f (hàm phía trước)
				move = {
					enable = true,
					set_jumps = true, -- Lưu vào jump list (Ctrl+o để quay lại)
					goto_next_start = {
						["]f"] = "@function.outer",
						["]c"] = "@class.outer",
					},
					goto_previous_start = {
						["[f"] = "@function.outer",
						["[c"] = "@class.outer",
					},
				},

				-- Hoán đổi vị trí tham số: <leader>na (đổi chỗ biến trong hàm)
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
		})
	end,
}
