-- =============================================================================
-- ACTIVE THEME — change this one line to switch
-- =============================================================================
local active = "gruvbox"

-- =============================================================================
-- THEME REGISTRY
-- Each entry:
--   plugin  : lazy.nvim plugin spec string
--   setup() : called before vim.cmd.colorscheme() — configure the theme here
--   name    : optional override for vim.cmd.colorscheme() (nightfox variants)
-- =============================================================================
local themes = {

	gruvbox8 = {
		plugin = "lifepillar/vim-gruvbox8",
		setup  = function()
			vim.g.gruvbox_contrast_dark  = "hard"  -- soft | medium | hard
			vim.g.gruvbox_italics        = 1
			vim.g.gruvbox_italicize_strings = 0
			vim.g.gruvbox_filetype_hi_groups = 1
			vim.g.gruvbox_plugin_hi_groups   = 1
		end,
	},

	gruvbox = {
		plugin = "ellisonleao/gruvbox.nvim",
		setup  = function()
			require("gruvbox").setup({
				contrast      = "hard",   -- soft | medium | hard
				bold          = true,
				italic        = { strings = false, comments = true, operators = false },
				undercurl     = true,
				strikethrough = true,
			})
		end,
	},

	catppuccin = {
		plugin = "catppuccin/nvim",
		setup  = function()
			require("catppuccin").setup({
				flavour              = "mocha",  -- latte | frappe | macchiato | mocha
				background           = { light = "latte", dark = "mocha" },
				transparent_background = false,
				integrations = {
					cmp        = true,
					gitsigns   = true,
					nvimtree   = true,
					treesitter = true,
					notify     = false,
					mini       = { enabled = true },
				},
			})
		end,
	},

	tokyonight = {
		plugin = "folke/tokyonight.nvim",
		setup  = function()
			require("tokyonight").setup({
				style         = "night",  -- storm | night | moon | day
				transparent   = false,
				terminal_colors = true,
				styles = {
					comments  = { italic = true },
					keywords  = { italic = false },
					sidebars  = "dark",
					floats    = "dark",
				},
			})
		end,
	},

	kanagawa = {
		plugin = "rebelot/kanagawa.nvim",
		setup  = function()
			require("kanagawa").setup({
				theme      = "wave",   -- wave | dragon | lotus
				background = { dark = "wave", light = "lotus" },
				compile    = false,
				undercurl  = true,
				commentStyle = { italic = true },
				keywordStyle = { italic = false, bold = false },
				statementStyle = { bold = true },
			})
		end,
	},

	nord = {
		plugin = "gbprod/nord.nvim",
		setup  = function()
			require("nord").setup({
				transparent      = false,
				terminal_colors  = true,
				diff             = { mode = "fg" },   -- fg | bg
				borders          = true,
				errors           = { mode = "fg" },
				styles = {
					comments = { italic = true },
					keywords = { italic = false },
				},
			})
		end,
	},

	everforest = {
		plugin = "neanias/everforest-nvim",
		setup  = function()
			require("everforest").setup({
				background              = "hard",  -- soft | medium | hard
				ui_contrast             = "high",  -- low | high
				transparent_background_level = 0,
				diagnostic_text_highlight = true,
				diagnostic_virtual_text   = "coloured",
				italics                   = true,
			})
		end,
	},

	nightfox = {
		plugin = "EdenEast/nightfox.nvim",
		name   = "carbonfox",   -- carbonfox | duskfox | nordfox | terafox
		setup  = function()
			require("nightfox").setup({
				options = {
					transparent = false,
					terminal_colors = true,
					styles = {
						comments = "italic",
						keywords = "bold",
					},
				},
			})
		end,
	},

	onedark = {
		plugin = "navarasu/onedark.nvim",
		setup  = function()
			require("onedark").setup({
				style         = "darker",  -- dark | darker | cool | deep | warm | warmer
				transparent   = false,
				term_colors   = true,
				ending_tildes = false,
				code_style = {
					comments  = "italic",
					keywords  = "none",
					functions = "none",
					strings   = "none",
					variables = "none",
				},
			})
		end,
	},

	rose_pine = {
		plugin = "rose-pine/neovim",
		name   = "rose-pine-moon",  -- rose-pine | rose-pine-moon | rose-pine-dawn
		setup  = function()
			require("rose-pine").setup({
				variant        = "moon",  -- auto | main | moon | dawn
				dark_variant   = "moon",
				dim_inactive_windows = false,
				extend_background_behind_borders = true,
				styles = {
					bold      = true,
					italic    = true,
					transparency = false,
				},
			})
		end,
	},

}

-- =============================================================================
-- BOOTSTRAP
-- =============================================================================
local config = themes[active]
assert(config, ("colorscheme.lua: unknown theme %q — check the themes table"):format(active))

return {
	{
		config.plugin,
		name     = config.name or active,
		priority = 1000,
		lazy     = false,
		config   = function()
			if type(config.setup) == "function" then
				config.setup()
			end
			vim.cmd.colorscheme(config.name or active)
		end,
	},
}
