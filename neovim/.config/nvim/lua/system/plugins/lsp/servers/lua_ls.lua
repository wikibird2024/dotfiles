local M = {}

function M.setup(capabilities)
	vim.lsp.config("lua_ls", {
		capabilities = capabilities,
		root_markers = { ".luarc.json", ".luarc.jsonc", ".git" },
		settings = {
			Lua = {
				workspace  = { checkThirdParty = false },
				telemetry  = { enable = false },
			},
		},
	})
end

return M
