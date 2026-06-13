return {
	{
		"kevinhwang91/nvim-bqf",
        enabled = false, -- This shuts down the plugin completely
		ft = "qf", -- Efficient lazy loading: only load when a quickfix window opens
		dependencies = {
			-- Only compile/load fzf locally if it's NOT already installed on your Linux system
			{
				"junegunn/fzf",
				build = "./install --all",
				enabled = vim.fn.executable("fzf") == 0, -- Skips downloading if 'fzf' exists in your PATH
			},
		},
		---@type BqfConfig
		opts = {
			auto_enable = true,
			auto_resize_height = true,
			preview = {
				win_height = 12,
				win_vheight = 12,
				delay_syntax = 80,
				border = "rounded",
				show_title = true,
				-- Optimize performance by skipping previews for giant files
				should_preview_cb = function(bufnr)
					local bufname = vim.api.nvim_buf_get_name(bufnr)
					local fsize = vim.fn.getfsize(bufname)
					if fsize > 100 * 1024 then -- Skip files larger than 100KB
						return false
					end
					return true
				end,
			},
			-- Modern home-row friendly key mappings inside the quickfix window
			func_map = {
				vsplit = "v", -- Open hit in a vertical split
				split = "x", -- Open hit in a horizontal split
				tab = "t", -- Open hit in a new tab
				ptogglemode = "zM", -- Change preview window layout orientation
				stoggleup = "K", -- Visual select item and move up
				stoggledown = "J", -- Visual select item and move down
			},
		},
	},
}
