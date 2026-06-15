return {
	{
		"lervag/vimtex",
		lazy = false,
		ft = { "tex", "bib" },
		keys = {
			{ "<leader>Lc", "<cmd>VimtexCompile<CR>", desc = "LaTeX Compile", ft = "tex" },
			{ "<leader>Lv", "<cmd>VimtexView<CR>",    desc = "LaTeX View",    ft = "tex" },
		},
		config = function()
			vim.g.vimtex_compiler_method = "latexmk"
			vim.g.vimtex_view_method = "zathura"
			-- Chỉ giữ cấu hình biến g., không đặt keymap ở đây
		end,
	},
	{
		"iurimateus/luasnip-latex-snippets.nvim",
		dependencies = { "L3MON4D3/LuaSnip" },
		ft = { "tex" },
		config = function()
			require("luasnip-latex-snippets").setup({ use_treesitter = true })
		end,
	},
}
