return {
	"L3MON4D3/LuaSnip",
	-- Chạy sau khi nvim-cmp load (nếu bạn dùng auto-completion)
	event = "InsertEnter",
	dependencies = {
		"rafamadriz/friendly-snippets", -- Kho snippet khổng lồ từ cộng đồng
	},
	config = function()
		local ls = require("luasnip")

		-- 1. THIẾT LẬP CHUNG
		ls.config.set_config({
			history = true, -- Giữ lại snippet cũ để quay lại sửa nếu cần
			updateevents = "TextChanged,TextChangedI", -- Cập nhật biến trong snippet khi gõ
			enable_autosnippets = true, -- Hỗ trợ auto-snippets (gõ là ra luôn không cần Enter)
		})

		-- 2. LOAD SNIPPETS (QUAN TRỌNG)
		-- Load từ friendly-snippets (cộng đồng)
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Load từ folder snippets/ ngoài cùng của bạn
		-- vim.fn.stdpath("config") sẽ trỏ thẳng tới thư mục ~/.config/nvim/ của bạn
		require("luasnip.loaders.from_vscode").lazy_load({
			paths = { vim.fn.stdpath("config") .. "/snippets" },
		})

		-- 3. KEYMAPS (Dùng phím tắt để nhảy giữa các ô $1, $2 trong snippet)
		-- Nhấn Tab để nhảy tới ô tiếp theo
		vim.keymap.set({ "i", "s" }, "<Tab>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			else
				-- Nếu không có snippet thì Tab hoạt động bình thường
				vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false)
			end
		end, { silent = true })

		-- Nhấn Shift-Tab để nhảy ngược lại ô trước đó
		vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
			if ls.jumpable(-1) then
				ls.jump(-1)
			end
		end, { silent = true })

		-- 4. LIÊN KẾT NGÔN NGỮ (Tùy chọn)
		-- Ví dụ: Khi mở file .tex thì cho phép dùng cả snippets của .markdown
		ls.filetype_extend("latex", { "tex", "bib" })
	end,
}
