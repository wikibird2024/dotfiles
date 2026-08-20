-- Bottom-right LSP progress spinner (e.g. "clangd: indexing..."). Owns LSP
-- progress display; noice.lua's lsp.progress is disabled to avoid a second,
-- toast-based progress UI fighting this one.
return {
	"j-hui/fidget.nvim",
	event = "LspAttach",
	opts = {
		notification = {
			window = {
				winblend = 0,
				border   = "rounded",
			},
		},
		progress = {
			display = {
				done_icon = "✓",
			},
		},
	},
}
