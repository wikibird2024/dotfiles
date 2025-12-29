return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- 1. Kích hoạt Giao diện (Bo góc, Icons, Diagnostic)
		-- Phải gọi hàm này đầu tiên để các thiết lập UI có hiệu lực
		require("system.constitution.lsp_ui").setup()

		-- 2. Guard: Đảm bảo chỉ khởi tạo một lần duy nhất mỗi session
		vim.g._lsp_kernel_enabled = vim.g._lsp_kernel_enabled or {}
		local enabled = vim.g._lsp_kernel_enabled

		-- 3. Load các logic Runtime và Capabilities
		local on_attach = require("system.runtime.lsp_on_attach").on_attach
		local capabilities = require("system.constitution.lsp_capabilities")

		-- Danh sách các server bạn muốn dùng
		local servers = { "texlab", "pyright", "clangd", "rust_analyzer" }

		for _, name in ipairs(servers) do
			if not enabled[name] then
				-- Kiểm tra xem có file cấu hình riêng cho từng server không
				local ok, server_mod = pcall(require, "system.plugins.lsp.servers." .. name)

				if ok and type(server_mod.setup) == "function" then
					-- Nếu có file riêng, gọi hàm setup của file đó
					server_mod.setup(on_attach, capabilities)
				else
					-- Nếu không có file riêng, dùng cấu hình chuẩn của Neovim 0.11
					-- KHÔNG dùng require('lspconfig') để tránh lỗi Deprecated
					vim.lsp.config[name] = {
						on_attach = on_attach,
						capabilities = capabilities,
						root_markers = { ".git", "pyproject.toml", "package.json", "Cargo.toml" },
					}
				end

				-- Kích hoạt LSP Server
				vim.lsp.enable(name)
				enabled[name] = true
			end
		end
	end,
}
