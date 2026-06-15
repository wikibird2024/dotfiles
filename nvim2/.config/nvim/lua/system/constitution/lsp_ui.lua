local M = {}

function M.setup()
	local border = "single"

	local signs = {
		[vim.diagnostic.severity.ERROR] = "󰅚 ",
		[vim.diagnostic.severity.WARN]  = "󰀪 ",
		[vim.diagnostic.severity.HINT]  = "󰌶 ",
		[vim.diagnostic.severity.INFO]  = "󰋽 ",
	}

	vim.diagnostic.config({
		virtual_text = { prefix = "●", spacing = 4 },
		signs        = { text = signs },
		underline         = true,
		update_in_insert  = false,
		severity_sort     = true,
		float = {
			border = border,
			source = "always",
			header = "",
			prefix = "",
		},
	})

	-- Force rounded borders on all LSP floating windows (hover, signature help)
	local orig = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts        = opts or {}
		opts.border = opts.border or border
		return orig(contents, syntax, opts, ...)
	end

	-- Apply rounded borders to nvim-cmp completion/documentation windows
	local ok, cmp = pcall(require, "cmp")
	if ok then
		local bordered = cmp.config.window.bordered({
			border      = border,
			winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
		})
		cmp.setup({ window = { completion = bordered, documentation = bordered } })
	end
end

return M
