return {
	{
		"mfussenegger/nvim-lint",
		event = { "BufReadPost", "BufWritePost", "InsertLeave" },
		config = function()
			local lint = require("lint")

			lint.linters_by_ft = {
				python = { "flake8"     },
				sh     = { "shellcheck" },
				lua    = { "luacheck"   },
				c      = { "cpplint"    },
				cpp    = { "cpplint"    },
			}

			vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
				group    = vim.api.nvim_create_augroup("NvimLint", { clear = true }),
				callback = function() lint.try_lint() end,
			})
		end,
	},
}
