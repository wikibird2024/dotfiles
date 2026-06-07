-- ~/.config/nvim/lua/system/plugins/tools/todo.lua

return {
	"folke/todo-comments.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"folke/trouble.nvim",
		"ibhagwan/fzf-lua", -- Matches your terminal-centric setup perfectly
	},
	event = "BufReadPost",
	config = function()
		require("todo-comments").setup({
			signs = true,
			sign_priority = 90,

			keywords = {
				FIX = { icon = " ", color = "error", alt = { "FIXME", "BUG", "ISSUE" } },
				TODO = { icon = " ", color = "info" },
				HACK = { icon = " ", color = "warning" },
				PERF = { icon = " ", color = "default", alt = { "OPTIM", "OPT" } },
				NOTE = { icon = " ", color = "hint", alt = { "INFO" } },
				TEST = { icon = " ", color = "test" },
			},

			highlight = {
				before = "",
				keyword = "bg",
				after = "fg",
				pattern = [[.*<(KEYWORDS)\s*:]], -- Highlights keywords followed by a colon
			},

			search = {
				command = "rg",
				args = {
					"--color=never",
					"--no-heading",
					"--with-filename",
					"--line-number",
					"--column",
				},
				pattern = [[\b(KEYWORDS):]],
			},
		})

		local map = vim.keymap.set
		-- Trouble integration
		map("n", "<leader>xt", "<cmd>TodoTrouble<cr>", { desc = "Todo → Trouble" })

		-- FIXED: Changed from Telescope to FzfLua to match your ecosystem
		map("n", "<leader>xT", "<cmd>TodoFzfLua<cr>", { desc = "Todo → Fzf-Lua" })

		-- Navigation jumps
		map("n", "]t", function()
			require("todo-comments").jump_next()
		end, { desc = "Next todo" })
		map("n", "[t", function()
			require("todo-comments").jump_prev()
		end, { desc = "Prev todo" })
	end,
}
