return {
	"windwp/nvim-autopairs",
	-- Load khi bắt đầu gõ
	event = "InsertEnter",
	-- Đảm bảo Treesitter được load trước để autopairs thông minh hơn
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		local autopairs = require("nvim-autopairs")

		autopairs.setup({
			check_ts = true, -- Bật kiểm tra Treesitter
			ts_config = {
				lua = { "string", "source" }, -- Không tự đóng ngoặc khi đang gõ trong string của Lua
				javascript = { "string", "template_string" },
				java = false, -- Không kiểm tra Treesitter cho Java
			},
			-- Tự động thêm dấu cách ở giữa cặp ngoặc: ( ) thay vì ()
			map_cr = true, -- Tự động xuống dòng khi nhấn Enter giữa cặp ngoặc
			map_bs = true, -- Tự động xóa cặp dấu đóng khi xóa dấu mở
			disable_filetype = { "TelescopePrompt", "spectre_panel", "vim" },

			-- Tính năng Fast Wrap: Nhấn <Alt-e> để bọc nhanh từ tiếp theo
			fast_wrap = {
				map = "<M-e>",
				chars = { "{", "[", "(", '"', "'" },
				pattern = [=[[%'%"%)%>%]%]%}%,]]=],
				offset = 0, -- Offset từ vị trí con trỏ
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
		})

		-- KẾT NỐI VỚI NVIM-CMP (Quan trọng)
		-- Giúp tự động thêm dấu () khi bạn chọn một hàm từ menu gợi ý
		local cmp_status_ok, cmp = pcall(require, "cmp")
		if cmp_status_ok then
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end
	end,
}
