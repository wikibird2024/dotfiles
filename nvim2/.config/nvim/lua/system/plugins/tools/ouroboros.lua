return {
	"jakemason/ouroboros.nvim",
	dependencies = { "nvim-lua/plenary.nvim" },
	ft = { "c", "cpp" }, -- Only load for C/C++ files
	keys = {
		{ "<leader>a", "<cmd>OuroborosTS<CR>", desc = "C/C++: Switch between Source/Header" },
	},
}
