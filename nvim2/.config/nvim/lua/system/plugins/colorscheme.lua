-- List of themes you want to support
local themes = {
	gruvbox8 = {
		plugin = "lifepillar/vim-gruvbox8",
		module = nil, -- It doesn't use require("gruvbox8").setup()
		opts = {
			-- We handle these via vim.g in the config function below
			contrast = "medium", -- Options: soft, medium, hard
			italic = 1,
		},
	},
	gruvbox = {
		plugin = "ellisonleao/gruvbox.nvim",
		module = "gruvbox",
		opts = {
			contrast = "medium", -- Options: hard | medium | soft
			overrides = {},
		},
	},
	nord = {
		plugin = "gbprod/nord.nvim",
		module = "nord",
		opts = {}, -- no extra options by default
	},
	catppuccin = {
		plugin = "catppuccin/nvim",
		module = "catppuccin",
		opts = {
			flavour = "mocha", -- Options: latte | frappe | macchiato | mocha
		},
	},
	everforest = {
		plugin = "neanias/everforest-nvim",
		module = "everforest",
		opts = {
			background = "hard", -- Options: hard | medium | soft
			ui_contrast = "high", -- Options: low | high
			diagnostic_text_highlight = 1,
		},
	},
	-- Existing Additions:
	tokyonight = {
		plugin = "folke/tokyonight.nvim",
		module = "tokyonight",
		opts = {
			style = "storm", -- Options: storm | night | day
			transparent = false,
		},
	},
	kanagawa = {
		plugin = "rebelot/kanagawa.nvim",
		module = "kanagawa",
		opts = {
			variant = "wave", -- Options: wave | dragon | lotus
			background = "dark",
		},
	},
	nightfox = {
		plugin = "EdenEast/nightfox.nvim",
		module = "nightfox",
		opts = {
			variant = "carbonfox", -- Many variants: duskfox, nordfox, etc.
			transparent = true,
		},
	},

	-- === NEW ADDITIONS ===
	onedark = {
		plugin = "navarasu/onedark.nvim",
		module = "onedark",
		opts = {
			style = "dark", -- Options: dark | warmer | cool | deep
			transparent = false,
			term_colors = true,
		},
	},
	solarized = {
		plugin = "shaunsingh/solarized.nvim",
		module = "solarized",
		opts = {
			style = "dark", -- Options: dark | light
			transparent = false,
		},
	},
	-- =====================
}

-- ACTIVE THEME
--=========================================================================
-- local active_theme = "gruvbox8" -- Change this name to select the active theme
local active_theme = "catppuccin" -- Change this name to select the active theme
local theme_config = themes[active_theme]
--=========================================================================

-- Main Plugin Configuration Block (for use with a plugin manager like Lazy.nvim)
return {
	{
		theme_config.plugin,
		priority = 1000, -- Ensure the theme loads first
		lazy = false, -- Load immediately on startup
		config = function()
			if theme_config.module and theme_config.opts then
				local ok, theme_module = pcall(require, theme_config.module)
				if ok and theme_module and type(theme_module.setup) == "function" then
					-- Call the setup function with theme-specific options
					theme_module.setup(theme_config.opts)
				end
			end
			-- Apply the colorscheme
			vim.cmd.colorscheme(active_theme)
		end,
	},
}
