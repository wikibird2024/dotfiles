return {
	"mrcjkb/rustaceanvim",
	version = "^5", -- Khuyên dùng cho Neovim hiện tại
	ft = { "rust" },
	config = function()
		-- Lấy các thiết lập dùng chung từ hệ thống của bạn
		local on_attach_custom = require("system.runtime.lsp_on_attach").on_attach
		local capabilities_custom = require("system.constitution.lsp_capabilities")

		vim.g.rustaceanvim = {
			-- Cấu hình Server (thay thế cho lspconfig/vim.lsp.enable)
			server = {
				on_attach = function(client, bufnr)
					-- 1. Gọi các keymap chung của bạn
					on_attach_custom(client, bufnr)

					-- 2. Kích hoạt Inlay Hints (Hiện tên biến, kiểu dữ liệu)
					-- Đây là tính năng giúp học Rust cực nhanh vì nó hiển thị Type rõ ràng
					if vim.lsp.inlay_hint then
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end
				end,
				capabilities = capabilities_custom,
				default_settings = {
					["rust-analyzer"] = {
						-- Cấu hình check lỗi chuẩn mới nhất
						check = {
							command = "clippy", -- Sử dụng Clippy để bắt lỗi logic/style
						},
						checkOnSave = true, -- Kích hoạt tự động kiểm tra khi lưu file

						inlayHints = {
							bindingModeHints = { enable = true },
							parameterHints = { enable = true },
							typeHints = { enable = true },
						},
					},
				},
			},
		}
	end,
}
