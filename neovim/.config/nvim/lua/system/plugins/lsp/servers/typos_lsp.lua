local M = {}

-- Rust source-code spell checker (github.com/tekumara/typos-lsp). Runs
-- broadly across filetypes; severity kept at "Hint" (lowest) since a
-- spell-checker over code identifiers is more false-positive-prone than a
-- normal linter.
function M.setup(capabilities)
	vim.lsp.config("typos_lsp", {
		capabilities = capabilities,
		cmd          = { "typos-lsp" },
		cmd_env      = { RUST_LOG = "typos_lsp=error" },
		init_options = {
			diagnosticSeverity = "Hint",
		},
	})
end

return M
