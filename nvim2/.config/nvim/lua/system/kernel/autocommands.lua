local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- 1. General Settings
local general_grp = augroup("GeneralSettings", { clear = true })

-- Auto-save on Leaving Insert Mode or Losing Focus
-- This will only trigger if the buffer has been modified and is a real file
autocmd({ "InsertLeave", "FocusLost" }, {
	group = general_grp,
	callback = function()
		if vim.bo.modified and vim.fn.expand("%") ~= "" then
			vim.cmd("silent! update")
		end
	end,
	desc = "Auto-save on insert leave or focus lost",
})

-- Highlight yanked text for a short duration
autocmd("TextYankPost", {
	group = general_grp,
	callback = function()
		vim.hl.on_yank({ timeout = 200 })
	end,
	desc = "Highlight text on yank",
})

-- Smart Trim Whitespace: Removes trailing spaces on save
-- Optimized: Does not trim spaces on the current line to avoid disrupting active typing
autocmd("BufWritePre", {
	group = general_grp,
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		local current_line = vim.fn.line(".")

		-- %s/\s\+$//e : Global search for trailing spaces and remove
		-- The 'if' logic inside 'v:val' ensures we skip the current line
		vim.cmd(string.format([[keepjumps keeppatterns %d,%ds/\s\+$//e]], 1, current_line - 1))
		vim.cmd(string.format([[keepjumps keeppatterns %d,%ds/\s\+$//e]], current_line + 1, vim.fn.line("$")))

		vim.fn.setpos(".", save_cursor)
	end,
	desc = "Clean up trailing whitespace (except current line)",
})

-- 2. LSP Bridge
local lsp_grp = augroup("LspSystem", { clear = true })
autocmd("LspAttach", {
	group = lsp_grp,
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		local bufnr = args.buf
		require("system.runtime.lsp_on_attach").on_attach(client, bufnr)
	end,
	desc = "Initialize LSP keymaps and settings on attach",
})

-- 3. Auto-Reload Config
autocmd("BufWritePost", {
	group = augroup("ReloadConfig", { clear = true }),
	pattern = { "**/lua/system/**/*.lua", "init.lua" },
	callback = function()
		vim.notify("Configuration updated successfully", vim.log.levels.INFO)
	end,
	desc = "Notify when configuration files are saved",
})
