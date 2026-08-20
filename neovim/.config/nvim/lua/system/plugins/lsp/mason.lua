return {
	{
		"williamboman/mason.nvim",
		cmd   = { "Mason", "MasonInstall", "MasonUninstall", "MasonUninstallAll", "MasonLog", "MasonUpdate" },
		build = ":MasonUpdate",
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
