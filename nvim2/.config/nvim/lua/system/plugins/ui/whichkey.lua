return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	config = function()
		local wk = require("which-key")

		wk.setup({
			delay = 300,
			win = {
				border  = "rounded",
				padding = { 1, 2, 1, 2 },
			},
			icons = {
				breadcrumb = "»",
				separator  = "➜",
				group      = "+",
			},
		})

		wk.add({
			{ "<leader>c", group = "Code/CMake",     icon = "󰅩 " },
			{ "<leader>f", group = "Find/Search",    icon = " "  },
			{ "<leader>b", group = "Buffer",         icon = "󰓩 " },
			{ "<leader>w", group = "Window",         icon = "󱂬 " },
			{ "<leader>l", group = "LSP/Code",       icon = "󰅩 " },
			{ "<leader>L", group = "LaTeX",          icon = "󰚗 " },
			{ "<leader>g", group = "Git",            icon = " "  },
			{ "<leader>d", group = "Debug",          icon = " "  },
			{ "<leader>x", group = "Diagnostics/QF", icon = "󱖫 " },
			{ "<leader>q", group = "Session",        icon = "󰅚 " },
			{ "<leader>s", group = "Search/Replace", icon = "󰛔 " },
			{ "<leader>u", group = "UI/Toggle",      icon = " "  },
			{ "<leader>h", group = "Harpoon",        icon = "󱡅 " },
			{ "<leader>n", group = "Neogen/Docs",    icon = "󰆉 " },
			{ "<leader>H", group = "HTTP",           icon = "󰖟 " },
			{ "<leader>t", desc  = "Terminal",       icon = "󱂇 " },
			{ "<leader>y", hidden = true },
			{ "<leader>p", hidden = true },
		})
	end,
}