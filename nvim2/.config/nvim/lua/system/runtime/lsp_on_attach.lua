local M = {}

M.on_attach = function(client, bufnr)
	-- Signature help in insert mode
	vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, {
		buffer = bufnr,
		desc   = "LSP: Signature Help",
		silent = true,
	})

	-- Inline diagnostic float
	vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, {
		buffer = bufnr,
		desc   = "LSP: Show Line Diagnostics",
		silent = true,
	})

	-- Auto-highlight symbol references under cursor
	if client.server_capabilities.documentHighlightProvider then
		local hl_group = vim.api.nvim_create_augroup("LspDocumentHighlight_" .. bufnr, { clear = true })
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			group    = hl_group,
			buffer   = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd("CursorMoved", {
			group    = hl_group,
			buffer   = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

return M
