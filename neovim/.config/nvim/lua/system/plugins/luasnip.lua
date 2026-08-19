return {
	"L3MON4D3/LuaSnip",
	event        = "InsertEnter",
	dependencies = { "rafamadriz/friendly-snippets" },
	config = function()
		local ls = require("luasnip")

		ls.config.set_config({
			history             = true,
			updateevents        = "TextChanged,TextChangedI",
			enable_autosnippets = true,
		})

		-- Load community snippet collection
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Load project-local snippets from ~/.config/nvim/snippets/
		require("luasnip.loaders.from_vscode").lazy_load({
			paths = { vim.fn.stdpath("config") .. "/snippets" },
		})

		-- Tab / S-Tab are handled by cmp/init.lua to avoid conflicts
		ls.filetype_extend("latex", { "tex", "bib" })
	end,
}
