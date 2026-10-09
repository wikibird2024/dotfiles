return {
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			"rouge8/neotest-rust",
		},
		keys = {
			{ "<leader>Tt", function() require("neotest").run.run()                              end, desc = "Test: Run Nearest"   },
			{ "<leader>Tf", function() require("neotest").run.run(vim.fn.expand("%"))            end, desc = "Test: Run File"      },
			{ "<leader>Ts", function() require("neotest").summary.toggle()                       end, desc = "Test: Summary"       },
			{ "<leader>To", function() require("neotest").output_panel.toggle()                  end, desc = "Test: Output Panel"  },
			{ "<leader>Td", function() require("neotest").run.run({ strategy = "dap" })          end, desc = "Test: Debug Nearest" },
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-python")({ runner = "pytest", dap = { justMyCode = false } }),
					require("neotest-rust"),
				},
			})
		end,
	},
}
