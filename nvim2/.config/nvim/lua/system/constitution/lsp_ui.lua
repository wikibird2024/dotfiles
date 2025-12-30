local M = {}

function M.setup()
	-- single rounded double solid
	local border = "single"
	-- 1. Cấu hình Icons cho Diagnostic (Giữ nguyên của bạn)
	local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋽 " }
	for type, icon in pairs(signs) do
		local hl = "DiagnosticSign" .. type
		vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
	end

	-- 2. Cấu hình hiển thị Diagnostic (Giữ nguyên của bạn)
	vim.diagnostic.config({
		virtual_text = { prefix = "●", spacing = 4 },
		signs = true,
		underline = true,
		update_in_insert = false,
		severity_sort = true,
		float = {
			border = border,
			source = "always",
			header = "",
			prefix = "",
		},
	})

	-- 3. ÉP BO GÓC cho cửa sổ LSP (Hover, Signature Help)
	local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
	function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
		opts = opts or {}
		opts.border = opts.border or border
		return orig_util_open_floating_preview(contents, syntax, opts, ...)
	end

	-- 4. CẤU HÌNH BO GÓC CHO GỢI Ý CODE (CMP)
	-- Chúng ta dùng pcall để tránh lỗi nếu plugin cmp chưa được load
	local ok, cmp = pcall(require, "cmp")
	if ok then
		cmp.setup({
			window = {
				completion = cmp.config.window.bordered({
					border = border,
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
				}),
				documentation = cmp.config.window.bordered({
					border = border,
					winhighlight = "Normal:NormalFloat,FloatBorder:FloatBorder,CursorLine:PmenuSel,Search:None",
				}),
			},
		})
	end
end

return M
