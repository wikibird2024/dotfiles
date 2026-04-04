-- ~/.config/nvim/lua/user/plugins/tools/treesj.lua
return {
	"Wansmer/treesj",
	keys = { "<space>m", "<space>j", "<space>s" },
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	config = function()
		require("treesj").setup({
			use_default_keymaps = false,
		})

		local map = require("system.utils").map
		map("n", "<leader>m", function()
			require("treesj").toggle()
		end, { desc = "Toggle Split/Join Code" })
	end,
}
