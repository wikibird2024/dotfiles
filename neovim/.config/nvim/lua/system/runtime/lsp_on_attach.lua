local M = {}

M.on_attach = function(client, bufnr)
	local map = function(mode, lhs, rhs, desc)
		vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
	end

	-- Signature help — using <C-s> avoids conflict with <C-k> used by nvim-cmp
	map("i", "<C-s>", function() vim.lsp.buf.signature_help({ border = "rounded" }) end, "LSP: Signature Help")

	-- Diagnostic float for current line
	map("n", "<leader>xd", vim.diagnostic.open_float, "LSP: Show Line Diagnostics")

	-- Auto-highlight all references to the symbol under the cursor.
	-- Guard against duplicate attach (two LSPs on one buffer) with pcall on group creation.
	if client.server_capabilities.documentHighlightProvider then
		local group = "LspDocumentHighlight_" .. bufnr
		local ok, id = pcall(vim.api.nvim_create_augroup, group, { clear = false })
		if ok then
			vim.api.nvim_clear_autocmds({ group = group, buffer = bufnr })

			vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
				group    = group,
				buffer   = bufnr,
				callback = vim.lsp.buf.document_highlight,
			})

			-- Scope the clear to this buffer only, not globally
			vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
				group    = group,
				buffer   = bufnr,
				callback = function()
					vim.lsp.buf.clear_references()
				end,
			})
		end
	end

	-- Clean up all buffer-local LSP autocmds when the LSP detaches
	vim.api.nvim_create_autocmd("LspDetach", {
		buffer   = bufnr,
		once     = true,
		callback = function()
			pcall(vim.api.nvim_del_augroup_by_name, "LspDocumentHighlight_" .. bufnr)
		end,
	})
end

return M