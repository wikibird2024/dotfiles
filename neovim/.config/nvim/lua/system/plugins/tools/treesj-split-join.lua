return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	keys = {
		{ "<leader>m",  function() require("treesj").toggle() end, desc = "TreeSJ: Toggle Split/Join" },
		{ "<leader>cj", function() require("treesj").join()   end, desc = "TreeSJ: Join Lines"        },
		{ "<leader>cs", function() require("treesj").split()  end, desc = "TreeSJ: Split Lines"       },
	},
	config = function()
		require("treesj").setup({ use_default_keymaps = false })
	end,
}
