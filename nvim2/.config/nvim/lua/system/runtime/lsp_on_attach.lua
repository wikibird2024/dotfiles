local M = {}
M.on_attach = function(client, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, silent = true })
	end

	-- --- STANDARD KEYMAPS ---
	nmap("K", vim.lsp.buf.hover, "Hover Documentation")
	nmap("gd", vim.lsp.buf.definition, "Go to Definition")
	nmap("gr", vim.lsp.buf.references, "Show References")
	nmap("gi", vim.lsp.buf.implementation, "Go to Implementation")
	nmap("<leader>rn", vim.lsp.buf.rename, "Rename Symbol")
	nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
	nmap("<leader>d", vim.diagnostic.open_float, "Show Line Diagnostics")

	-- Signature Help (Show function parameters while typing)
	vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "LSP: Signature Help" })

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
