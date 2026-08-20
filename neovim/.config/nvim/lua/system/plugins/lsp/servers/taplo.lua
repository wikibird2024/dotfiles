local M = {}

-- TOML toolkit (Rust) -- pairs with crates.nvim for Cargo.toml editing:
-- completion, hover, schema validation, and diagnostics for any .toml file.
function M.setup(capabilities)
	vim.lsp.config("taplo", {
		capabilities = capabilities,
		filetypes    = { "toml" },
		root_markers = { ".taplo.toml", "taplo.toml", ".git" },
	})
end

return M
