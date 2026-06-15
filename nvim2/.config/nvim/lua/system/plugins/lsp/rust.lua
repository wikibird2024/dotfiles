return {
	"mrcjkb/rustaceanvim",
	version = "^5",
	ft      = { "rust" },
	config = function()
		local on_attach    = require("system.runtime.lsp_on_attach").on_attach
		local capabilities = require("system.constitution.lsp_capabilities")

		vim.g.rustaceanvim = {
			server = {
				on_attach = function(client, bufnr)
					on_attach(client, bufnr)

					-- Enable inlay hints by default for Rust
					if vim.lsp.inlay_hint then
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end
				end,
				capabilities   = capabilities,
				default_settings = {
					["rust-analyzer"] = {
						check = {
							command = "clippy",
						},
						checkOnSave = true,
						inlayHints = {
							bindingModeHints = { enable = true },
							parameterHints   = { enable = true },
							typeHints        = { enable = true },
						},
					},
				},
			},
		}
	end,
}
