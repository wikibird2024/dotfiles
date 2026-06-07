-- ~/.config/nvim/lua/user/plugins/tools/treesj.lua
return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	-- Handle your keys here so Lazy.nvim maps them instantly before loading the plugin
	keys = {
		{
			"<leader>m",
			function()
				require("treesj").toggle()
			end,
			desc = "TreeSJ: Toggle Split/Join",
		},
		{
			"<leader>j",
			function()
				require("treesj").join()
			end,
			desc = "TreeSJ: Join Code Block",
		},
		{
			"<leader>s",
			function()
				require("treesj").split()
			end,
			desc = "TreeSJ: Split Code Block",
		},
	},
	config = function()
		require("treesj").setup({
			use_default_keymaps = false, -- Keeps your manual keys clean
		})
	end,
}
