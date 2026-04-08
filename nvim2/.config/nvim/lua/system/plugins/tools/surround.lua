-- ~/.config/nvim/lua/user/plugins/tools/surround.lua

return {
	{
		"kylechui/nvim-surround",
		version = "*", -- Sử dụng bản release mới nhất để tương thích v4
		event = "BufReadPost",
		config = function()
			require("nvim-surround").setup({
				-- QUAN TRỌNG: Đã xóa bảng keymaps ở đây để hết lỗi.
				-- nvim-surround v4 sẽ tự động dùng: ys, ds, cs, S...

				surrounds = {
					["("] = {
						add = { "( ", " )" },
						find = "%b()",
						delete = "^(.?)().-(.)()$",
					},

					["{"] = {
						add = { "{ ", " }" },
						find = "%b{}",
						delete = "^(.?)().-(.)()$",
					},

					["<"] = {
						add = { "<", ">" },
						find = "%b<>",
						delete = "^(.?)().-(.)()$",
					},

					-- Giữ lại phím 'l' để bọc log cho ESP32/C
					["l"] = {
						add = function()
							return { 'ESP_LOGI(TAG, "', '");' }
						end,
					},
				},
			})
		end,
	},
}
