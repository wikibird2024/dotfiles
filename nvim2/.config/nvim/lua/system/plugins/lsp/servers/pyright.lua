local M = {}

function M.setup(capabilities)
	vim.lsp.config.pyright = {
		cmd          = { "pyright-langserver", "--stdio" },
		filetypes    = { "python" },
		root_markers = { "pyproject.toml", "setup.py", "requirements.txt", ".git" },
		capabilities = capabilities,
		settings = {
			python = {
				analysis = {
					autoSearchPaths      = true,
					useLibraryCodeForTypes = true,
					diagnosticMode       = "workspace",
					typeCheckingMode     = "basic",
				},
			},
		},
	}
end

return M
