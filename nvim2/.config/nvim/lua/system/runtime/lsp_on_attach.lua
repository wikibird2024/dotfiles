local M = {}
M.on_attach = function(client, bufnr)
	-- Signature help in insert mode (not set globally)
	vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "LSP: Signature Help", silent = true })

	-- Diagnostics float (not set globally)
	vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { buffer = bufnr, desc = "LSP: Show Line Diagnostics", silent = true })

	-- Automatically highlight symbol references under cursor
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved" }, {
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

return M
