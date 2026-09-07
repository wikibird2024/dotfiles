return {
	{
		"williamboman/mason.nvim",
		-- Load eagerly (not lazy) so mason's $PATH prepend always finishes before
		-- nvim-lspconfig tries to spawn any server -- both mason-tool-installer and
		-- nvim-lspconfig trigger on the same BufReadPre event, and letting mason
		-- load lazily raced against that, causing servers with a system-installed
		-- fallback (e.g. clangd, both mason's and /usr/bin/clangd exist here) to
		-- intermittently resolve to whichever binary happened to be on $PATH first.
		lazy     = false,
		priority = 1000,
		cmd      = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog", "MasonUpdate" },
		build    = ":MasonUpdate",
		opts = {
			ui = {
				border = "rounded",
				icons = {
					package_installed   = "✓",
					package_pending      = "➜",
					package_uninstalled = "✗",
				},
			},
		},
	},
	{
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		dependencies = { "williamboman/mason.nvim" },
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			ensure_installed = {
				"clangd",
				"pyright",
				"texlab",
				"lua-language-server",
				"bash-language-server",
				"codelldb",
				-- Rust-written LSP/lint/format tools
				"ruff",
				"typos-lsp",
				"taplo",
			},
			auto_update  = false,
			run_on_start = true,
		},
	},
}
