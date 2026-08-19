return {
	"echasnovski/mini.ai",
	event = "VeryLazy",
	opts = {
		n_lines = 500,
		-- a = around, i = inside
		-- adds: q (any quote), ? (user-prompted), and treesitter-based f/c/a text objects
		-- 'f' disabled: nvim-treesitter-textobjects owns af/if for function definitions;
		-- mini.ai's builtin 'f' is function-call, which silently collided with it.
		custom_textobjects = { f = false },
	},
}
