-- ~/.config/nvim/lua/system/plugins/lsp/servers/clangd.lua
local M = {}

function M.setup(on_attach, capabilities)
	-- Create an extended on_attach function strictly for C/C++
	local clangd_on_attach = function(client, bufnr)
		-- 1. Execute your standard lsp_on_attach.lua rules (gd, gr, K)
		if type(on_attach) == "function" then
			on_attach(client, bufnr)
		end

		-- 2. Trigger the native LSP switch request directly via pure Lua
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
				-- Open the file path returned by clangd
				vim.cmd("edit " .. vim.uri_to_fname(result))
			end)
		end, {
			buffer = bufnr,
			desc = "LSP: C/C++ Switch Source/Header",
			silent = true,
		})
	end

	-- 3. Configure the native Neovim 0.11 LSP options
	vim.lsp.config("clangd", {
		on_attach = clangd_on_attach,
		capabilities = capabilities,

		-- Native Neovim 0.11 way to find project roots without loading lspconfig
		root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", ".git" },

		-- Your specialized embedded/low-resource execution flags
		cmd = {
			"clangd",
			"--background-index",
			"-j=1", -- Thread limit for low-resource environments
			"--limit-results=20", -- Reduces indexer caching footprint
			"--malloc-trim", -- Aggressively releases RAM back to OS
			"--clang-tidy=false", -- Disables heavy background linting
			"--header-insertion=never", -- Stops messy auto-includes
			"--completion-style=bundled",
			"--query-driver=/usr/bin/arm-none-eabi*", -- Crucial for your ARM toolchain paths
		},
	})
end

return M
