return {
	"danymat/neogen",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	keys = {
		{ "<leader>ng", function() require("neogen").generate() end,                          desc = "Generate Docstring"  },
		{ "<leader>nf", function() require("neogen").generate({ type = "func" }) end,         desc = "Generate Func Doc"   },
		{ "<leader>nc", function() require("neogen").generate({ type = "class" }) end,        desc = "Generate Class Doc"  },
		{ "<leader>nt", function() require("neogen").generate({ type = "type" }) end,         desc = "Generate Type Doc"   },
	},
	opts = {
		snippet_engine = "luasnip",
		languages = {
			c   = { template = { annotation_convention = "doxygen" } },
			cpp = { template = { annotation_convention = "doxygen" } },
			python = { template = { annotation_convention = "google_docstrings" } },
			rust   = { template = { annotation_convention = "rustdoc" } },
		},
	},
}
