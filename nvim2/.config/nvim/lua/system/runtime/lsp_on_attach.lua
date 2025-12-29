local M = {}
M.on_attach = function(client, bufnr)
	local nmap = function(keys, func, desc)
		if desc then
			desc = "LSP: " .. desc
		end
		vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, silent = true })
	end

	-- --- CÁC PHÍM TẮT CHUẨN ---
	nmap("K", vim.lsp.buf.hover, "Hiện tài liệu (Hover)")
	nmap("gd", vim.lsp.buf.definition, "Đi đến định nghĩa (Definition)")
	nmap("gr", vim.lsp.buf.references, "Xem danh sách tham chiếu (References)")
	nmap("gi", vim.lsp.buf.implementation, "Đi đến phần thực thi (Implementation)")
	nmap("<leader>rn", vim.lsp.buf.rename, "Đổi tên biến toàn cục (Rename)")
	nmap("<leader>ca", vim.lsp.buf.code_action, "Sửa lỗi nhanh (Code Action)")
	nmap("<leader>d", vim.diagnostic.open_float, "Xem lỗi chi tiết tại dòng")

	-- Gợi ý tham số hàm (Signature Help) khi đang gõ
	vim.keymap.set("i", "<C-k>", vim.lsp.buf.signature_help, { buffer = bufnr, desc = "LSP: Signature Help" })

	-- Tự động highlight các biến trùng nhau khi đặt con trỏ vào
	if client.server_capabilities.documentHighlightProvider then
		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = bufnr,
			callback = vim.lsp.buf.document_highlight,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved" }, {
			buffer = bufnr,
			callback = vim.lsp.buf.clear_references,
		})
	end
end

return M
