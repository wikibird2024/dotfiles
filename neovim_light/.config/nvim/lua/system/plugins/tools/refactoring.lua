return {
	"ThePrimeagen/refactoring.nvim",
	dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" },
	keys = {
		{ "<leader>re", function() require("refactoring").refactor("Extract Function") end, mode = "x",           desc = "Refactor: Extract Function" },
		{ "<leader>rv", function() require("refactoring").refactor("Extract Variable") end, mode = "x",           desc = "Refactor: Extract Variable" },
		{ "<leader>ri", function() require("refactoring").refactor("Inline Variable")  end, mode = { "n", "x" },  desc = "Refactor: Inline Variable"  },
		{ "<leader>rb", function() require("refactoring").refactor("Extract Block")    end, mode = "n",           desc = "Refactor: Extract Block"    },
		{ "<leader>rr", function() require("refactoring").select_refactor()            end, mode = { "n", "x" },  desc = "Refactor: Select"           },
	},
	opts = {},
}
