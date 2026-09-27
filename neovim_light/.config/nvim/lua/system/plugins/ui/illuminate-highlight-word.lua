return {
	"RRethy/vim-illuminate",
	event = { "BufReadPost", "BufNewFile" },
	opts = {
		delay             = 200,
		large_file_cutoff = 2000,
		large_file_overrides = { providers = { "lsp" } },
		-- don't illuminate in these filetypes
		filetypes_denylist = {
			"NvimTree", "neo-tree", "Trouble", "lazy", "mason",
			"toggleterm", "TelescopePrompt",
		},
	},
	config = function(_, opts)
		require("illuminate").configure(opts)

		-- Inherit colors from the active theme rather than hard-coding them
		vim.api.nvim_set_hl(0, "IlluminatedWordText",  { link = "LspReferenceText",  default = true })
		vim.api.nvim_set_hl(0, "IlluminatedWordRead",  { link = "LspReferenceRead",  default = true })
		vim.api.nvim_set_hl(0, "IlluminatedWordWrite", { link = "LspReferenceWrite", default = true })
	end,
}
