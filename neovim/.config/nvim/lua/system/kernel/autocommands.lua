local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

local general = augroup("GeneralSettings", { clear = true })

-- Auto-save on leaving insert mode or losing focus (skips special/readonly buffers)
autocmd({ "InsertLeave", "FocusLost" }, {
	group    = general,
	callback = function()
		if vim.bo.modified and vim.fn.expand("%") ~= "" and vim.bo.buftype == "" then
			vim.cmd("silent! update")
		end
	end,
})

-- Flash yanked region briefly
autocmd("TextYankPost", {
	group    = general,
	callback = function()
		vim.hl.on_yank({ timeout = 200 })
	end,
})

-- Strip trailing whitespace on save without moving the cursor.
-- Processes lines above and below the current line separately to avoid
-- excessive redraws on large files.
autocmd("BufWritePre", {
	group    = general,
	callback = function()
		if vim.bo.buftype ~= "" then return end

		local cursor    = vim.fn.getpos(".")
		local cur_line  = vim.fn.line(".")
		local last_line = vim.fn.line("$")

		if cur_line > 1 then
			vim.cmd(string.format([[keepjumps keeppatterns 1,%ds/\s\+$//e]], cur_line - 1))
		end
		if cur_line < last_line then
			vim.cmd(string.format([[keepjumps keeppatterns %d,%ds/\s\+$//e]], cur_line + 1, last_line))
		end

		vim.fn.setpos(".", cursor)
	end,
})
