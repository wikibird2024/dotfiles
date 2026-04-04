local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- 1. Nhóm cài đặt chung
local general_grp = augroup("GeneralSettings", { clear = true })

-- Tự động lưu: Chỉ lưu khi thực sự cần thiết
autocmd({ "InsertLeave", "FocusLost" }, {
	group = general_grp,
	callback = function()
		-- Điều kiện: File có sửa đổi, không phải file trống, và không phải file chỉ đọc
		if vim.bo.modified and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
			vim.cmd("silent! update")
		end
	end,
})

-- Highlight khi copy (Yank)
autocmd("TextYankPost", {
	group = general_grp,
	callback = function()
		vim.hl.on_yank({ timeout = 200 })
	end,
})

-- Xóa khoảng trắng thừa (Smart Trim) - BẢN SỬA LỖI TRIỆT ĐỂ
autocmd("BufWritePre", {
	group = general_grp,
	callback = function()
		-- Không chạy trên các file đặc biệt (NvimTree, Terminal, v.v.)
		if vim.bo.buftype ~= "" then
			return
		end

		local save_cursor = vim.fn.getpos(".")
		local current_line = vim.fn.line(".")
		local last_line = vim.fn.line("$")

		-- Xóa vùng phía trên dòng hiện tại
		if current_line > 1 then
			vim.cmd(string.format([[keepjumps keeppatterns 1,%ds/\s\+$//e]], current_line - 1))
		end

		-- Xóa vùng phía dưới dòng hiện tại (Chỉ chạy nếu dòng hiện tại chưa phải cuối cùng)
		if current_line < last_line then
			vim.cmd(string.format([[keepjumps keeppatterns %d,%ds/\s\+$//e]], current_line + 1, last_line))
		end

		vim.fn.setpos(".", save_cursor)
	end,
})

-- 2. Tự động nạp lại cấu hình khi sửa file lua trong nvim
autocmd("BufWritePost", {
	group = augroup("ReloadConfig", { clear = true }),
	pattern = { "**/lua/system/**/*.lua", "init.lua" },
	callback = function()
		vim.notify("Nvim Config Updated!", vim.log.levels.INFO)
	end,
})
