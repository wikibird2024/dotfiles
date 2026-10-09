return {
	"stevearc/overseer.nvim",
	cmd  = { "OverseerRun", "OverseerToggle", "OverseerBuild" },
	keys = {
		{ "<leader>Or", "<cmd>OverseerRun<CR>",    desc = "Overseer: Run Task"    },
		{ "<leader>Ot", "<cmd>OverseerToggle<CR>", desc = "Overseer: Toggle Panel" },
	},
	opts = {
		task_list = {
			direction  = "bottom",
			min_height = 10,
			max_height = 15,
		},
	},
}
