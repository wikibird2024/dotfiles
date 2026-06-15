-- Loaded by lsp/init.lua via require("system.plugins.lsp.servers.texlab")
return {
	settings = {
		texlab = {
			build = {
				executable = "latexmk",
				args       = { "-xelatex", "-interaction=nonstopmode", "-synctex=1", "%f" },
			},
			forwardSearch = {
				executable = "zathura",
				args       = { "--synctex-forward", "%l:1:%f", "%p" },
			},
		},
	},
}
