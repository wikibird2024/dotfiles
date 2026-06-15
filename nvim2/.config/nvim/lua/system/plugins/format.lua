return {
	{
		"stevearc/conform.nvim",
		event = { "BufWritePre" },
		config = function()
			require("conform").setup({
				format_on_save = {
					timeout_ms   = 500,
					lsp_fallback = true,
				},
				formatters_by_ft = {
					lua    = { "stylua"       },
					python = { "black"        },
					sh     = { "shfmt"        },
					json   = { "jq"           },
					rust   = { "rustfmt"      },
					c      = { "clang_format" },
					cpp    = { "clang_format" },
				},
			})
		end,
	},
}
