-- List of themes you want to support
local themes = {
  gruvbox = {
    plugin = "ellisonleao/gruvbox.nvim",
    module = "gruvbox",
    opts = {
      contrast = "hard",
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
      flavour = "mocha", -- latte | frappe | macchiato | mocha
    },
  },

  -- New additions:
  tokyonight = {
    plugin = "folke/tokyonight.nvim",
    module = "tokyonight",
    opts = {
      style = "storm",        -- possible: storm | night | day
      transparent = false,
    },
  },
  kanagawa = {
    plugin = "rebelot/kanagawa.nvim",
    module = "kanagawa",
    opts = {
      variant = "wave",       -- possible: wave | dragon | lotus
      background = "dark",
    },
  },
  nightfox = {
    plugin = "EdenEast/nightfox.nvim",
    module = "nightfox",
    opts = {
      variant = "carbonfox",  -- many variants: duskfox, nordfox, etc.
      transparent = true,
    },
  },
}

-- Choose the active theme
local active_theme = "nord"  -- Change this to the one you want
local theme_config = themes[active_theme]

return {
  {
    theme_config.plugin,
    priority = 1000,
    lazy = false,
    config = function()
      if theme_config.module and theme_config.opts then
        local ok, theme_module = pcall(require, theme_config.module)
        if ok and theme_module and type(theme_module.setup) == "function" then
          theme_module.setup(theme_config.opts)
        end
      end
      vim.cmd.colorscheme(active_theme)
    end,
  },
}

