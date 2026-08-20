return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		config = function()
			require("conform").setup({
				format_on_save = {
					timeout_ms   = 500,
					lsp_format = "never",
				},
				formatters_by_ft = {
					lua    = { "stylua"       },
					-- ruff (Rust, Astral) replaces black: sorts imports, then formats
					python = { "ruff_organize_imports", "ruff_format" },
					sh     = { "shfmt"        },
					json   = { "jq"           },
					rust   = { "rustfmt"      },
					c      = { "clang_format" },
					cpp    = { "clang_format" },
					toml   = { "taplo"        },
				},
			})
		end,
	},
}
