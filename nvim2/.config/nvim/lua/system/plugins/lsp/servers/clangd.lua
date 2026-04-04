local M = {}

function M.setup(on_attach, capabilities)
	vim.lsp.config.clangd = {
		cmd = {
			"clangd",
			"--background-index",
			-- 1. GIỚI HẠN LUỒNG: Cực kỳ quan trọng cho i3 đời 4
			"-j=1",
			-- 2. GIỚI HẠN RAM: Giảm bộ nhớ đệm cho indexer
			"--limit-results=20",
			"--malloc-trim",
			-- 3. TÍNH NĂNG: Tắt bớt các tính năng phân tích sâu nếu vẫn lag
			"--clang-tidy=false", -- clang-tidy ngốn CPU rất kinh khủng
			"--header-insertion=never", -- Giảm việc quét header liên tục
			"--completion-style=bundled",
		},
		filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
		root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", ".git" },
		on_attach = on_attach,
		capabilities = capabilities,
	}
end

return M
