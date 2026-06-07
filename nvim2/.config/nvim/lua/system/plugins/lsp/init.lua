return {
	"neovim/nvim-lspconfig",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		-- 1. Initialize the UI (Borders, Icons, Diagnostics)
		-- This must be called first for UI settings to take effect
		require("system.constitution.lsp_ui").setup()

		-- 2. Guard: Ensure initialization happens only once per session
		vim.g._lsp_kernel_enabled = vim.g._lsp_kernel_enabled or {}
		local enabled = vim.g._lsp_kernel_enabled

		-- 3. Load Runtime logic and Capabilities
		local on_attach = require("system.runtime.lsp_on_attach").on_attach
		local capabilities = require("system.constitution.lsp_capabilities")

		-- List of servers to activate
		local servers = { "texlab", "pyright", "clangd" }
		-- "rust_analyzer" if you want to use it again
		for _, name in ipairs(servers) do
			if not enabled[name] then
				-- Check for a dedicated configuration file for each server
				local ok, server_mod = pcall(require, "system.plugins.lsp.servers." .. name)

				if ok and type(server_mod.setup) == "function" then
					-- If a dedicated file exists, call its setup function
					server_mod.setup(on_attach, capabilities)
				else
					-- Fallback to the standard Neovim 0.11 configuration setup
					-- Calls vim.lsp.config as a function to maintain native stability
					vim.lsp.config(name, {
						on_attach = on_attach,
						capabilities = capabilities,
						root_markers = { ".git", "pyproject.toml", "package.json", "Cargo.toml" },
					})
				end

				-- Enable the LSP Server
				vim.lsp.enable(name)
				enabled[name] = true
			end
		end
	end,
}
