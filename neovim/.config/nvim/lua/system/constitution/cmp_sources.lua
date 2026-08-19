-- Default insert-mode completion sources.
-- crates is intentionally low priority here — crates.nvim registers itself
-- only when Cargo.toml is active, but ranking it high globally wastes a query
-- on every other buffer.
return {
	{ name = "nvim_lsp", priority = 1000 },
	{ name = "luasnip",  priority = 750  },
	{ name = "buffer",   priority = 500  },
	{ name = "path",     priority = 250  },
	{ name = "crates",   priority = 100  },
}