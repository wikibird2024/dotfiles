-- Path: nvim2/.config/nvim/lua/system/plugins/tools/copilot.lua
local cached_node = nil
local get_node_cmd = function()
	if cached_node then return cached_node end
	local nodes = vim.fn.glob("~/.nvm/versions/node/*/bin/node", false, true)
	table.sort(nodes)
	cached_node = nodes[#nodes] or "node"
	return cached_node
end

return {
	"zbirenbaum/copilot.lua",
	cmd = "Copilot",
	event = "InsertEnter",
	opts = {
		copilot_node_command = get_node_cmd(),
		suggestion = {
			enabled = true,
			auto_trigger = true,
			debounce = 150,
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

