return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	opts = {
		copilot_node_command = vim.fn.expand("~/.nvm/versions/node/v22.18.0/bin/node"),
		suggestion = {
			enabled = true,
			auto_trigger = true,
			debounce = 75,
			keymap = {
				accept = false, -- handled inside cmp's <Tab> mapping instead
				next = "<M-]>",
				prev = "<M-[>",
				dismiss = "<C-]>",
			},
		},
		panel = { enabled = false },
	},
}


-- What is 
