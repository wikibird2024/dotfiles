return {
	"MeanderingProgrammer/render-markdown.nvim",
	-- Capture standard files, AI assistants, and obsidian vaults if used
	ft = { "markdown", "codecompanion", "Avante", "copilot-chat" },
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		"nvim-tree/nvim-web-devicons", -- optional for icons
	},
	opts = {
		-- Core Performance & Rules
		enabled = true,
		max_file_size = 10.0,
		debounce = 100,
		-- Keeps insert mode completely clean, renders in normal/visual/command
		render_modes = { "n", "v", "c" },

		-- PRO FEATURE: Anti-Conceal
		-- Solves the major issue where text jumps around when your cursor is on the line.
		-- It temporarily reveals the raw markdown syntax *only* on the current cursor line.
		anti_conceal = {
			enabled = true,
			ignore = {
				code_background = true, -- keep code block backgrounds colored even on cursor line
				sign = true,
			},
		},

		-- Minimalist, high-contrast headings
		heading = {
			enabled = true,
			sign = true, -- Adds an indicator in the signcolumn for rapid navigation
			icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
			signs = { "🄷" },
			width = "block", -- Renders a full block background width for headers
			position = "overlay",
		},

		-- Code block engineering
		code = {
			enabled = true,
			sign = false,
			style = "language",
			position = "left",
			width = "block",
			left_pad = 2,
			right_pad = 2,
			border = "thin",
		},

		-- Clean checkboxes
		checkbox = {
			enabled = true,
			unchecked = { icon = "󰄱 " },
			checked = { icon = "󰄵 " },
			custom = {
				todo = { raw = "[-]", rendered = "󰥔 ", highlight = "RenderMarkdownWarn" },
			},
		},

		bullet = {
			enabled = true,
			icons = { "●", "○", "◆", "◇" },
		},

		-- Full padded grid tables
		pipe_table = {
			enabled = true,
			preset = "round",
			style = "full",
			cell = "trimmed",
			padding = 1,
		},

		-- Clean inline code backticks handling
		inline_code = {
			enabled = true,
			highlight = "ColorColumn", -- Subtle background highlighting
		},

		-- Corrected & Modern Callout Definitions (GitHub style)
		callout = {
			note = { render = "󰋽 Note", hl = "RenderMarkdownInfo" },
			tip = { render = "󰌶 Tip", hl = "RenderMarkdownSuccess" },
			important = { render = "󰅚 Important", hl = "RenderMarkdownError" },
			warning = { render = "󰀪 Warning", hl = "RenderMarkdownWarn" },
			caution = { render = "󰳦 Caution", hl = "RenderMarkdownError" },
		},

		-- Window and Conceal settings
		win_options = {
			conceallevel = { default = 0, rendered = 2 },
			concealcursor = { default = "", rendered = "nc" },
		},
	},
	config = function(_, opts)
		require("render-markdown").setup(opts)

		-- Toggle Mapping
		vim.keymap.set("n", "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle Markdown Render" })

		-- PRO USER INTEGRATION: Expose state to your statusline or tabline
		-- You can check this globally if you want an indicator on whether rendering is active.
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "markdown",
			callback = function()
				-- Example of a buffer-local mapping to update or interact with the parser state
				vim.keymap.set(
					"n",
					"<leader>tc",
					"<cmd>RenderMarkdown contract<cr>",
					{ buffer = true, desc = "Contract Conceal Margin" }
				)
				vim.keymap.set(
					"n",
					"<leader>te",
					"<cmd>RenderMarkdown expand<cr>",
					{ buffer = true, desc = "Expand Conceal Margin" }
				)
			end,
		})
	end,
}
