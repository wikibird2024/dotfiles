return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{ "<leader>t",  "<cmd>ToggleTerm<CR>",                    desc = "Terminal" },
		{ "<leader>tf", "<cmd>ToggleTerm direction=float<CR>",     desc = "Float Terminal" },
		{ "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>",desc = "Horizontal Terminal" },
		{ "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>",  desc = "Vertical Terminal" },
	},
	config = function()
		require("toggleterm").setup({
			size = function(term)
				if term.direction == "horizontal" then
					return math.floor(vim.o.lines * 0.30)
				elseif term.direction == "vertical" then
					return math.floor(vim.o.columns * 0.38)
				end
			end,
			hide_numbers      = true,
			shade_terminals   = true,
			shading_factor    = 1,
			start_in_insert   = true,
			persist_size      = true,
			persist_mode      = false,
			direction         = "horizontal",
			auto_scroll       = true,
			insert_mappings   = false,
			terminal_mappings = false,
			close_on_exit     = false,
			float_opts = {
				border   = "curved",
				winblend = 2,
			},
			winbar = {
				enabled = true,
				name_formatter = function(term)
					return string.format(" [%d] Terminal ", term.id)
				end,
			},
		})

		-- Window navigation from within the terminal
		vim.api.nvim_create_autocmd("TermOpen", {
			pattern  = "term://*",
			callback = function()
				local opts = { buffer = 0, silent = true }
				vim.keymap.set("t", "<C-h>",      [[<C-\><C-n><C-w>h]],           opts)
				vim.keymap.set("t", "<C-j>",      [[<C-\><C-n><C-w>j]],           opts)
				vim.keymap.set("t", "<C-k>",      [[<C-\><C-n><C-w>k]],           opts)
				vim.keymap.set("t", "<C-l>",      [[<C-\><C-n><C-w>l]],           opts)
				vim.keymap.set("t", "<leader>t",  [[<C-\><C-n><cmd>ToggleTerm<CR>]], opts)
			end,
			desc = "Terminal window navigation",
		})
	end,
}
