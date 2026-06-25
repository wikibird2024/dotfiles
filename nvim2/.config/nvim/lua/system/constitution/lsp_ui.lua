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

	-- Border for hover / signature is passed directly at each call site (lsp/init.lua, lsp_on_attach.lua)
	-- to avoid re-wrapping vim.lsp.buf.hover on every LspAttach event.
end

return M