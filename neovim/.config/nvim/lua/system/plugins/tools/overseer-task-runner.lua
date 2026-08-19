return {
	"stevearc/overseer.nvim",
	cmd  = { "OverseerRun", "OverseerToggle", "OverseerBuild" },
	keys = {
		{ "<leader>or", "<cmd>OverseerRun<CR>",    desc = "Overseer: Run Task"    },
		{ "<leader>ot", "<cmd>OverseerToggle<CR>", desc = "Overseer: Toggle Panel" },
	},
	opts = {
		task_list = {
			direction  = "bottom",
			min_height = 10,
			max_height = 15,
		},
	},
}
