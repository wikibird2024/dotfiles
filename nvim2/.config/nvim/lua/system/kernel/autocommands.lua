local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

-- 1. General Settings
local general_grp = augroup("GeneralSettings", { clear = true })

-- Highlight yank
autocmd("TextYankPost", {
	group = general_grp,
	callback = function()
		vim.hl.on_yank({ timeout = 200 })
	end,
})

-- Trim whitespace
autocmd("BufWritePre", {
	group = general_grp,
	callback = function()
		local save_cursor = vim.fn.getpos(".")
		vim.cmd([[%s/\s\+$//e]])
		vim.fn.setpos(".", save_cursor)
	end,
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
})

-- 3. Auto-Reload Config
autocmd("BufWritePost", {
	group = augroup("ReloadConfig", { clear = true }),
	pattern = { "**/lua/system/**/*.lua", "init.lua" },
	callback = function()
		vim.notify("Config updated...", vim.log.levels.INFO)
	end,
})
