local M = {}

function M.setup(capabilities)
	vim.lsp.config("bashls", {
		capabilities = capabilities,
		filetypes    = { "sh", "bash" },
	})
end

return M
