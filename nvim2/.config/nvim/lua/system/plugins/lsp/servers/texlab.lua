-- File này sẽ được tự động gọi bởi nvim-lspconfig trong hệ thống của bạn
return {
	settings = {
		texlab = {
			build = {
				executable = "latexmk",
				args = { "-xelatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
			},
			forwardSearch = {
				executable = "zathura",
				args = { "--synctex-forward", "%l:1:%f", "%p" },
			},
		},
	},
}
