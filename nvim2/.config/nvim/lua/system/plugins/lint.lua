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
				callback = function()
					-- Only run linters whose binary is actually installed
					local available = vim.tbl_filter(function(name)
						local linter = lint.linters[name]
						local cmd = type(linter) == "table" and linter.cmd or name
						return vim.fn.executable(cmd) == 1
					end, lint.linters_by_ft[vim.bo.filetype] or {})

					if #available > 0 then
						lint.try_lint(available)
					end
				end,
			})
		end,
	},
}
