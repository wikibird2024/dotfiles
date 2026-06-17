local M = {}

function M.setup()
	local border = "rounded"   -- matches the rest of the config

	-- Diagnostic signs
	local signs = {
		[vim.diagnostic.severity.ERROR] = "󰅚 ",
		[vim.diagnostic.severity.WARN]  = "󰀪 ",
		[vim.diagnostic.severity.HINT]  = "󰌶 ",
		[vim.diagnostic.severity.INFO]  = "󰋽 ",
	}

	vim.diagnostic.config({
		virtual_text = { prefix = "●", spacing = 4 },
		signs        = { text = signs },
		underline        = true,
		update_in_insert = false,
		severity_sort    = true,
		float = {
			border = border,
			source = "if_many",   -- show source name only when multiple LSPs attached
			header = "",
			prefix = "",
		},
	})

	-- Bordered hover and signature-help windows via the official handler API
	-- (Neovim 0.10+). Avoids monkey-patching vim.lsp.util.open_floating_preview.
	vim.lsp.handlers["textDocument/hover"] =
		vim.lsp.with(vim.lsp.handlers.hover, { border = border })

	vim.lsp.handlers["textDocument/signatureHelp"] =
		vim.lsp.with(vim.lsp.handlers.signature_help, { border = border })
end

return M