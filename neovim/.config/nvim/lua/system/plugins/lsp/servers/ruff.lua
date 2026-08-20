local M = {}

-- Ruff (Rust, Astral) owns Python linting/fixes/import-sorting via its native
-- LSP server. Runs alongside pyright, which stays responsible for type
-- checking, hover, and completion — ruff's own hover is disabled in
-- lsp/init.lua's LspAttach callback to avoid duplicate hover popups.
function M.setup(capabilities)
	vim.lsp.config("ruff", {
		capabilities = capabilities,
		root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml", ".git" },
	})
end

return M
