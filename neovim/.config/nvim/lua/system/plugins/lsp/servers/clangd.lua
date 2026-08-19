local M = {}

function M.setup(capabilities)
	-- clangd requires utf-16 offset encoding to avoid conflicts with Neovim's utf-8 default.
	local clangd_caps = vim.tbl_deep_extend("force", capabilities, {
		offsetEncoding = { "utf-16" },
	})

	vim.lsp.config("clangd", {
		capabilities = clangd_caps,
		root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", ".git" },
		cmd = {
			"clangd",
			"--background-index",
			"-j=1",                              -- Thread limit for low-resource environments
			"--limit-results=20",                -- Reduce indexer cache footprint
			"--malloc-trim",                     -- Aggressively release RAM back to OS
			-- clang-tidy intentionally omitted (disabled by absence of the flag)
			"--header-insertion=never",          -- Prevent unwanted auto-includes
			"--completion-style=bundled",
			"--query-driver=/usr/bin/arm-none-eabi*", -- ARM cross-compilation toolchain
		},
	})
end

return M
