return {
	"stevearc/quicker.nvim",
	event = "FileType qf",
	keys = {
		{
			"<leader>xq",
			function()
				local h = vim.o.lines
				require("quicker").toggle({
					min_height = math.floor(h * 0.15),
					max_height = math.floor(h * 0.30),
				})
			end,
			desc = "Toggle Quickfix",
		},
		{
			"<leader>xl",
			function()
				local h = vim.o.lines
				require("quicker").toggle({
					min_height = math.floor(h * 0.15),
					max_height = math.floor(h * 0.30),
					loclist    = true,
				})
			end,
			desc = "Toggle Loclist",
		},
		{
			"]q",
			function()
				local ok, err = pcall(vim.cmd, "cnext")
				if not ok and err:find("E553") then vim.cmd("cfirst") end
			end,
			desc = "Quickfix: Next (wrap)",
		},
		{
			"[q",
			function()
				local ok, err = pcall(vim.cmd, "cprev")
				if not ok and err:find("E553") then vim.cmd("clast") end
			end,
			desc = "Quickfix: Prev (wrap)",
		},
	},
	opts = {
		follow     = { enabled = false },
		borders    = {
			vert          = "│",
			strong_header = "━",
			strong_cross  = "╋",
			strong_end    = "┫",
			soft_header   = "╌",
			soft_cross    = "╂",
			soft_end      = "┨",
		},
		type_icons = {
			E = "󰅚 ",
			W = "󰀪 ",
			I = " ",
			N = " ",
			H = " ",
		},
		highlight = {
			treesitter   = true,
			lsp          = true,
			load_buffers = false,
		},
		-- Narrow threshold: 100 columns
		-- Wide  → filename column up to half the screen (default behaviour)
		-- Narrow → filename column capped at 24 chars; entries wrap so nothing is hidden
		max_filename_width = function()
			if vim.o.columns < 100 then
				return 24
			end
			return math.floor(math.min(95, vim.o.columns / 2))
		end,
		on_qf = function(_)
			if vim.o.columns < 100 then
				vim.wo.wrap = true   -- wrap long lines so code text is not cut off
			else
				vim.wo.wrap = false
			end
		end,
		keys = {
			{ ">", function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end, desc = "Expand context"   },
			{ "<", function() require("quicker").collapse() end,                                                 desc = "Collapse context" },
		},
	},
	config = function(_, opts)
		require("quicker").setup(opts)
	end,
}
