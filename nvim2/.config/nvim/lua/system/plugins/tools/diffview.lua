return {
	"sindrets/diffview.nvim",
	cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewFileHistory" },
	keys = {
		{ "<leader>gD", "<cmd>DiffviewOpen<CR>",            desc = "Diff View Open" },
		{ "<leader>gH", "<cmd>DiffviewFileHistory %<CR>",   desc = "File History" },
		{ "<leader>gX", "<cmd>DiffviewClose<CR>",           desc = "Diff View Close" },
	},
	opts = {
		enhanced_diff_hl = true,
		view = {
			default = { layout = "diff2_horizontal" },
			merge_tool = { layout = "diff3_horizontal" },
		},
	},
}
