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
			-- Without the tmux variables: Claude talks to nvim's terminal, not tmux. With them it
			-- wraps clipboard copies (OSC 52) for tmux, which nvim prints as "52;c;<base64>" text.
			-- nvim keeps $TMUX (vim-tmux-navigator needs it).
			terminal_cmd = "env -u TMUX -u TMUX_PANE -u TERM_PROGRAM " .. vim.fn.expand("~/.local/bin/claude-personal"),
			terminal = {
				provider = "snacks",
				split_side = "right",
				split_width_percentage = 0.35,
				-- snacks paints terminals with NormalFloat (the gray popup color from
				-- kernel/float_theme.lua); a split should look like the editor.
				snacks_win_opts = {
					wo = { winhighlight = "Normal:Normal,NormalNC:NormalNC" },
				},
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
