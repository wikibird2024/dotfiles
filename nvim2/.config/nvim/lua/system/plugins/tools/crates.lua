return {
	"Saecki/crates.nvim",
	event = { "BufRead Cargo.toml" },
	dependencies = { "nvim-lua/plenary.nvim" },
	config = function()
		require("crates").setup({
			lsp = {
				enabled = true,
				on_attach = function(client, bufnr)
					require("system.runtime.lsp_on_attach").on_attach(client, bufnr)
				end,
			},
			popup = {
				autofocus = true,
				border = "rounded",
			},
			completion = {
				cmp = {
					enabled = true,
				},
			},
		})
	end,
}
