return {
	"code-biscuits/nvim-biscuits",
	event        = "BufReadPost",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	opts = {
		default_config = {
			max_length    = 12,
			min_distance  = 5,
			prefix_string = " 󰧟 ",
		},
	},
}
