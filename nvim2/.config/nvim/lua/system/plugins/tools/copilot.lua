-- Path: nvim2/.config/nvim/lua/system/plugins/tools/copilot-cmp.lua
return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	opts = {
		copilot_node_command = (function()
			local nodes = vim.fn.glob("~/.nvm/versions/node/*/bin/node", false, true)
			table.sort(nodes)
			return nodes[#nodes] or "node"
		end)(),
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

