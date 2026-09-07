return {
	"Saecki/crates.nvim",
	event        = { "BufRead Cargo.toml" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("crates").setup({
			lsp = {
				enabled   = true,
				on_attach = function(client, bufnr)
					require("system.runtime.lsp_on_attach").on_attach(client, bufnr)
				end,
			},
			popup = {
				autofocus = true,
				border    = "rounded",
			},
			-- No dedicated blink.cmp source needed: crates.nvim registers its own
			-- LSP client (lsp.enabled above), and blink's generic "lsp" source
			-- already pulls completions from every attached client for free.
		})
	end,
}
