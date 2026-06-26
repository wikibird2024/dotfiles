return {
	"mistweaverco/kulala.nvim",
	ft   = { "http", "rest" },
	keys = {
		{ "<leader>Hr", function() require("kulala").run() end,                desc = "HTTP: Run Request"   },
		{ "<leader>Ha", function() require("kulala").run_all() end,            desc = "HTTP: Run All"       },
		{ "<leader>Hn", function() require("kulala").jump_next() end,          desc = "HTTP: Next Request"  },
		{ "<leader>Hp", function() require("kulala").jump_prev() end,          desc = "HTTP: Prev Request"  },
		{ "<leader>Hi", function() require("kulala").inspect() end,            desc = "HTTP: Inspect"       },
		{ "<leader>Hc", function() require("kulala").copy() end,               desc = "HTTP: Copy as cURL"  },
	},
	opts = {
		default_view      = "body",
		default_env       = "dev",
		debug             = false,
		display_mode      = "split",
		split_direction   = "vertical",
	},
}
