-- Path: neovim/.config/nvim/lua/system/plugins/tools/claudecode.lua
-- Claude Code in a right split, on the personal Pro account (claude-personal, no API key).
return {
	{
		"coder/claudecode.nvim",
		dependencies = { "folke/snacks.nvim" },
		cmd = {
			"ClaudeCode",
			"ClaudeCodeFocus",
			"ClaudeCodeSelectModel",
			"ClaudeCodeAdd",
			"ClaudeCodeSend",
			"ClaudeCodeTreeAdd",
			"ClaudeCodeStatus",
			"ClaudeCodeStart",
			"ClaudeCodeStop",
			"ClaudeCodeOpen",
			"ClaudeCodeClose",
			"ClaudeCodeDiffAccept",
			"ClaudeCodeDiffDeny",
			"ClaudeCodeCloseAllDiffs",
		},
		keys = {
			{ "<leader>ac", "<cmd>ClaudeCode<cr>",           desc = "AI: Toggle Claude" },
			{ "<leader>af", "<cmd>ClaudeCodeFocus<cr>",      desc = "AI: Focus Claude" },
			{ "<leader>ar", "<cmd>ClaudeCode --resume<cr>",  desc = "AI: Resume Claude" },
			{ "<leader>aC", "<cmd>ClaudeCode --continue<cr>",desc = "AI: Continue Claude" },
			{ "<leader>am", "<cmd>ClaudeCodeSelectModel<cr>",desc = "AI: Select Model" },
			{ "<leader>ab", "<cmd>ClaudeCodeAdd %<cr>",      desc = "AI: Add Current Buffer" },
			{ "<leader>as", "<cmd>ClaudeCodeSend<cr>",       mode = "v", desc = "AI: Send Selection" },
			{ "<leader>aa", "<cmd>ClaudeCodeDiffAccept<cr>", desc = "AI: Accept Diff" },
			{ "<leader>ad", "<cmd>ClaudeCodeDiffDeny<cr>",   desc = "AI: Deny Diff" },
		},
		opts = {
			terminal_cmd = vim.fn.expand("~/.local/bin/claude-personal"),
			terminal = {
				provider = "snacks",
				split_side = "right",
				split_width_percentage = 0.35,
			},
		},
		config = function(_, opts)
			-- The plugin writes its IDE lock file to $CLAUDE_CONFIG_DIR/ide/; claude-personal
			-- only looks in ~/.claude-personal/ide/, so both must use the same folder.
			vim.env.CLAUDE_CONFIG_DIR = vim.fn.expand("~/.claude-personal")
			require("claudecode").setup(opts)
		end,
	},
}
