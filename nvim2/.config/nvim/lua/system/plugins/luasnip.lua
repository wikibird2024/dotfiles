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

		-- Tab: expand snippet or jump to next field
		vim.keymap.set({ "i", "s" }, "<Tab>", function()
			if ls.expand_or_jumpable() then
				ls.expand_or_jump()
			else
				vim.api.nvim_feedkeys(
					vim.api.nvim_replace_termcodes("<Tab>", true, false, true), "n", false
				)
			end
		end, { silent = true })

		-- Shift-Tab: jump to previous field
		vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
			if ls.jumpable(-1) then ls.jump(-1) end
		end, { silent = true })

		ls.filetype_extend("latex", { "tex", "bib" })
	end,
}
