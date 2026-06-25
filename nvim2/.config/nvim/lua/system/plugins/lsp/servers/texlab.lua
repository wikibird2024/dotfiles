local M = {}

function M.setup(capabilities)
	vim.lsp.config("texlab", {
		capabilities = capabilities,
		root_markers  = { ".latexmkrc", ".texlabroot", "*.tex", ".git" },
		settings = {
			texlab = {
				build = {
					executable = "latexmk",
					args       = { "-xelatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
					onSave     = true,
				},
				forwardSearch = {
					executable = "zathura",
					args       = { "--synctex-forward", "%l:1:%f", "%p" },
				},
			},
		},
	})
end

return M
