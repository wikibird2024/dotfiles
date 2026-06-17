local M = {}

function M.setup(on_attach, capabilities)
	local clangd_on_attach = function(client, bufnr)
		if type(on_attach) == "function" then
			on_attach(client, bufnr)
		end

		-- Switch between source and header file via clangd extension
		vim.keymap.set("n", "<leader>a", function()
			vim.lsp.buf_request(bufnr, "textDocument/switchSourceHeader", {
				uri = vim.uri_from_bufnr(bufnr),
			}, function(err, result)
				if err then
					vim.notify("LSP Switch Error: " .. tostring(err), vim.log.levels.ERROR)
					return
				end
				if not result then
					vim.notify("No matching source/header file found", vim.log.levels.WARN)
					return
				end
				vim.cmd("edit " .. vim.uri_to_fname(result))
			end)
		end, { buffer = bufnr, desc = "LSP: Switch Source/Header", silent = true })
	end

	-- clangd requires utf-16 offset encoding to avoid conflicts with Neovim's utf-8 default.
	-- This is set locally here rather than globally in lsp_capabilities.lua.
	local clangd_caps = vim.tbl_deep_extend("force", capabilities, {
		offsetEncoding = { "utf-16" },
	})

	vim.lsp.config("clangd", {
		on_attach    = clangd_on_attach,
		capabilities = clangd_caps,
		root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", ".git" },
		cmd = {
			"clangd",
			"--background-index",
			"-j=1",                              -- Thread limit for low-resource environments
			"--limit-results=20",                -- Reduce indexer cache footprint
			"--malloc-trim",                     -- Aggressively release RAM back to OS
			"--clang-tidy=false",                -- Disable heavy background linting
			"--header-insertion=never",          -- Prevent unwanted auto-includes
			"--completion-style=bundled",
			"--query-driver=/usr/bin/arm-none-eabi*", -- ARM cross-compilation toolchain
		},
	})
end

return M
