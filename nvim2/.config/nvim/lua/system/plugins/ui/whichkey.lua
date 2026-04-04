return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.setup({
			delay = 300,
			win = {
				border = "rounded",
				padding = { 1, 2, 1, 2 },
			},
			icons = {
				breadcrumb = "»",
				separator = "➜",
				group = "+",
			},
		})

		-- ĐĂNG KÝ GIAO DIỆN (Chuẩn v3)
		wk.add({
			{ "<leader>f", group = "Find/Search", icon = " " },
			{ "<leader>b", group = "Buffer", icon = "󰓩 " },
			{ "<leader>w", group = "Window", icon = "󱂬 " },
			{ "<leader>l", group = "LSP/Code", icon = "󰅩 " },
			{ "<leader>L", group = "LaTeX", icon = "󰚗 " },

			-- THAY ĐỔI QUAN TRỌNG Ở ĐÂY:
			-- Thay 'group' bằng 'desc' và thêm icon.
			-- Việc này cho phép <leader>t chạy lệnh ToggleTerm ngay lập tức.
			-- Các phím con như <leader>tf, <leader>th vẫn sẽ tự hiện trong bảng menu.
			{ "<leader>t", desc = "Terminal", icon = "󱂇 " },

			-- Ẩn các phím lẻ để menu không bị rác
			{ "<leader>y", hidden = true },
			{ "<leader>p", hidden = true },
		})
	end,
}
