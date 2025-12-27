-- lua/system/plugins/init.lua
-- File này CHỈ trả về table để các tầng khác sử dụng
return {
	{ import = "system.plugins.colorscheme" },
	{ import = "system.plugins.ui" },
	{ import = "system.plugins.latex" },
	{ import = "system.plugins.lint" },
	{ import = "system.plugins.luasnip" },
	{ import = "system.plugins.tools" },
	{ import = "system.plugins.cmp" },
	{ import = "system.plugins.lsp" },
	{ import = "system.plugins.git" },
	{ import = "system.plugins.format" },
	{ import = "system.plugins.treesitter" },
	{ import = "system.plugins.snippets" },
	{ import = "system.plugins.terminal" },
	{ import = "system.plugins.ts_comment" },
}
