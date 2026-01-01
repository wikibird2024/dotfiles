return {
	"akinsho/toggleterm.nvim",
	version = "*",
	event = "VeryLazy",
	config = function()
		require("toggleterm").setup({
			-- Viewport động: Terminal là một phần của hệ sinh thái hiển thị
			size = function(term)
				if term.direction == "horizontal" then
					return math.floor(vim.o.lines * 0.30)
				elseif term.direction == "vertical" then
					return math.floor(vim.o.columns * 0.38)
				end
			end,

			-- Trạng thái tĩnh
			hide_numbers = true,
			shade_terminals = true,
			shading_factor = 1,
			start_in_insert = true,
			persist_size = true,
			persist_mode = false,
			direction = "horizontal",
			auto_scroll = true,

			-- Triết lý quản lý Input tập trung
			insert_mappings = false,
			terminal_mappings = false,

			-- Triết lý Debug: Không bao giờ tự hủy dữ liệu lỗi
			close_on_exit = false,

			float_opts = {
				border = "curved",
				winblend = 2,
			},

			-- Terminal Management Layer
			winbar = {
				enabled = true,
				name_formatter = function(term)
					return string.format(" [%d] Terminal ", term.id)
				end,
			},
		})
	end,
}
