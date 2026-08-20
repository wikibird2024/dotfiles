-- Rust-backed auto-pairs + rainbow bracket highlighting, from the same
-- author/family as blink.cmp. Replaces nvim-autopairs.
--
-- Auto-insert () after accepting a function completion is handled separately
-- by blink.cmp's own completion.accept.auto_brackets (cmp/init.lua).
return {
	"saghen/blink.pairs",
	event        = "InsertEnter",
	dependencies = { "saghen/blink.lib" },
	version      = "*",
	build        = function() require("blink.pairs").download():pwait(60000) end,
	opts = {
		mappings = {
			enabled            = true,
			cmdline            = true,
			disabled_filetypes = { "fzf", "vim", "NvimTree", "neo-tree", "undotree", "toggleterm" },
		},
		highlights = {
			enabled = true,
			cmdline = true,
		},
	},
}
