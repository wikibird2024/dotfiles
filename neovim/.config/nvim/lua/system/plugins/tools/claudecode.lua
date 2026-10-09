-- Path: neovim/.config/nvim/lua/system/plugins/tools/claudecode.lua
-- Claude Code in a right split, on the personal Pro account (claude-personal, no API key).

-- <leader>ae: build/clean errors (quickfix) or else the last Overseer task output (flash),
-- written to a file; Claude is asked to read it and fix the errors.
local function send_errors()
	local lines = {}
	local hasError = false
	for _, item in ipairs(vim.fn.getqflist()) do
		local text = item.text
		if item.valid == 1 then
			hasError = true
			text = string.format("%s:%d:%d: %s", vim.fn.bufname(item.bufnr), item.lnum, item.col, item.text)
		elseif text:lower():find("error") then
			hasError = true
		end
		table.insert(lines, text)
	end
	local source = "build (quickfix)"
	if not hasError then
		local ok, overseer = pcall(require, "overseer")
		local tasks = ok and overseer.list_tasks({ sort = function(a, b) return a.id > b.id end }) or {}
		local bufnr = tasks[1] and tasks[1]:get_bufnr()
		if not (bufnr and vim.api.nvim_buf_is_valid(bufnr)) then
			vim.notify("No build errors and no Overseer task output to send", vim.log.levels.WARN)
			return
		end
		lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
		source = "task: " .. tasks[1].name .. " (" .. tasks[1].status .. ")"
	end
	local path = vim.fn.stdpath("cache") .. "/claude_errors.log"
	table.insert(lines, 1, "# " .. source .. ", cwd " .. vim.fn.getcwd())
	vim.fn.writefile(lines, path)
	-- One typed message, not ClaudeCodeAdd + text: the @-mention arrives over the
	-- websocket and could land after the text was already submitted.
	vim.cmd("ClaudeCodeSendText Read " .. path .. " (" .. source .. " output) and fix these errors.")
	vim.notify("Sent " .. source .. " to Claude")
end

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
			{ "<leader>ae", function() send_errors() end,   desc = "AI: Send Errors"  },
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
