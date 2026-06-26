return {
	"ThePrimeagen/harpoon",
	branch       = "harpoon2",
	dependencies = { "nvim-lua/plenary.nvim" },
	keys = function()
		local harpoon = require("harpoon")
		return {
			{ "<leader>ha", function() harpoon:list():add() end,                                    desc = "Harpoon: Add File"    },
			{ "<leader>hh", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,            desc = "Harpoon: Menu"        },
			{ "<C-1>",      function() harpoon:list():select(1) end,                                desc = "Harpoon: File 1"      },
			{ "<C-2>",      function() harpoon:list():select(2) end,                                desc = "Harpoon: File 2"      },
			{ "<C-3>",      function() harpoon:list():select(3) end,                                desc = "Harpoon: File 3"      },
			{ "<C-4>",      function() harpoon:list():select(4) end,                                desc = "Harpoon: File 4"      },
			{ "<leader>hp", function() harpoon:list():prev() end,                                   desc = "Harpoon: Prev"        },
			{ "<leader>hn", function() harpoon:list():next() end,                                   desc = "Harpoon: Next"        },
		}
	end,
	config = function()
		require("harpoon"):setup()
	end,
}
