return {
	"windwp/nvim-autopairs",
	event = "InsertEnter",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"hrsh7th/nvim-cmp",
	},
	config = function()
		local autopairs = require("nvim-autopairs")

		autopairs.setup({
			check_ts = true, -- Sử dụng Treesitter để thông minh hơn (không tự đóng ngoặc trong string/comment)
			ts_config = {
				lua = { "string", "source" },
				javascript = { "string", "template_string" },
				java = false,
			},
			enable_moveright = true, -- TỰ ĐỘNG NHẢY QUA dấu đóng khi bạn gõ đè lên nó
			enable_check_bracket_line = true, -- Kiểm tra dấu ngoặc trên cùng một dòng
			map_cr = true, -- Hỗ trợ xuống dòng thụt lề khi nhấn Enter
			map_bs = true, -- Xóa cặp ngoặc thông minh khi nhấn Backspace
			disable_filetype = { "TelescopePrompt", "fzf", "spectre_panel", "vim", "NvimTree", "undotree" },
			fast_wrap = {
				map = "<M-e>", -- Alt + e: Bọc nhanh từ hiện tại vào dấu ngoặc
				chars = { "{", "[", "(", '"', "'" },
				pattern = [=[[%'%"%)%>%]%]%}%,]]=],
				offset = 0,
				end_key = "$",
				keys = "qwertyuiopzxcvbnmasdfghjkl",
				check_comma = true,
				highlight = "Search",
				highlight_grey = "Comment",
			},
		})

		-- ──────────────────────────────────────────────────────────────────────
		-- TÍCH HỢP VỚI NVIM-CMP
		-- ──────────────────────────────────────────────────────────────────────
		-- Tự động thêm dấu ngoặc đơn () sau khi bạn chọn một hàm/phương thức từ menu gợi ý
		local cmp_status_ok, cmp = pcall(require, "cmp")
		if cmp_status_ok then
			local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
		end
	end,
}
