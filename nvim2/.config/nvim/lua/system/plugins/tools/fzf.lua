-- ~/.config/nvim/lua/system/plugins/tools/fzf.lua

return {
	"ibhagwan/fzf-lua",

	cmd = "FzfLua",

	dependencies = {
		"nvim-tree/nvim-web-devicons",
	},

	opts = {
		winopts = {
			height = 0.90,
			width = 0.90,
			border = "rounded",

			preview = {
				layout = "vertical",
				vertical = "down:50%",
			},
		},

		files = {
			hidden = true,
			cwd_prompt = false,
			formatter = "path.filename_first",
		},

		grep = {
			hidden = true,
		},

		keymap = {
			builtin = {
				["<C-d>"] = "preview-page-down",
				["<C-u>"] = "preview-page-up",
			},

			fzf = {
				["ctrl-d"] = "preview-page-down",
				["ctrl-u"] = "preview-page-up",
			},
		},
	},

	config = function(_, opts)
		require("fzf-lua").setup(opts)
	end,
}
