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
					cs     = { "csharpier"    },
					toml   = { "taplo"        },
				},
				formatters = {
					-- Opt-in per project: only where a .csharpierrc exists. On other C#
					-- code it would rewrite about half the lines on the first save.
					csharpier = {
						condition = function(_, ctx)
							return vim.fs.find(
								{ ".csharpierrc", ".csharpierrc.json", ".csharpierrc.yaml" },
								{ upward = true, path = ctx.dirname }
							)[1] ~= nil
						end,
					},
				},
			})
		end,
	},
}
