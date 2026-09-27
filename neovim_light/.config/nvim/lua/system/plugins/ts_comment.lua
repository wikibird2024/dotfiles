return {
    "folke/ts-comments.nvim",
	event   = "VeryLazy",
	enabled = vim.fn.has("nvim-0.10") == 1,
	opts = {
		lang = {
			c      = "// %s",
			cpp    = "// %s",
			rust   = "// %s",
			latex  = "%% %s",
			tex    = "%% %s",
			bib    = "%% %s",
			javascript = {
				"// %s",
				"/* %s */",
				jsx_element  = "{/* %s */}",
				jsx_fragment = "{/* %s */}",
			},
			typescript = "// %s",
			lua        = "-- %s",
			python     = "# %s",
			bash       = "# %s",
			sh         = "# %s",
			toml       = "# %s",
			yaml       = "# %s",
		},
	},
}
