return {
	"p00f/clangd_extensions.nvim",
	ft   = { "c", "cpp" },
	keys = {
		{ "<leader>lA", "<cmd>ClangdAST<CR>",           desc = "Clangd: AST View"        },
		{ "<leader>lT", "<cmd>ClangdTypeHierarchy<CR>", desc = "Clangd: Type Hierarchy"  },
		{ "<leader>lI", "<cmd>ClangdSymbolInfo<CR>",    desc = "Clangd: Symbol Info"     },
		{ "<leader>lM", "<cmd>ClangdMemoryUsage<CR>",   desc = "Clangd: Memory Usage"    },
	},
	-- server config stays in lsp/servers/clangd.lua — only UI extensions here
	opts = {
		inlay_hints = { inline = true },
		ast = {
			role_icons = {
				type        = "",
				declaration = "󰙠",
				expression  = "󰸿",
				specifier   = "󰦪",
				statement   = "󰅩",
				["template argument"] = "󰉼",
			},
		},
	},
}
