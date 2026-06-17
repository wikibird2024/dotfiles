return {
	"folke/todo-comments.nvim",
	event        = "BufReadPost",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		"ibhagwan/fzf-lua",
	},
	config = function()
		require("todo-comments").setup({
			signs         = true,
			sign_priority = 8,
			keywords = {
				FIX  = { icon = " ", color = "error",   alt = { "FIXME", "BUG", "ISSUE" } },
				TODO = { icon = " ", color = "info"    },
				HACK = { icon = " ", color = "warning" },
				PERF = { icon = " ", color = "default", alt = { "OPTIM", "OPT" } },
				NOTE = { icon = " ", color = "hint",    alt = { "INFO" } },
				TEST = { icon = " ", color = "test"    },
			},
			highlight = {
				before  = "",
				keyword = "bg",
				after   = "fg",
				pattern = [[.*<(KEYWORDS)\s*:]],
			},
			search = {
				command = "rg",
				args    = { "--color=never", "--no-heading", "--with-filename", "--line-number", "--column" },
				pattern = [[\b(KEYWORDS):]],
			},
		})

		local map = vim.keymap.set
		map("n", "<leader>xt", "<cmd>TodoTrouble<cr>",  { desc = "Todo → Trouble"  })
		map("n", "<leader>xT", "<cmd>TodoFzfLua<cr>",   { desc = "Todo → Fzf-Lua" })
		map("n", "]t", function() require("todo-comments").jump_next() end, { desc = "Next Todo" })
		map("n", "[t", function() require("todo-comments").jump_prev() end, { desc = "Prev Todo" })
	end,
}
