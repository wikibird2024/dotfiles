
-- ~/.config/nvim/lua/user/plugins/colorscheme.lua

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
    opts = {}, -- Nord does not require options by default
  },
  catppuccin = {
    plugin = "catppuccin/nvim",
    module = "catppuccin",
    opts = {
      flavour = "mocha", -- Options: latte, frappe, macchiato, mocha
    },
  },
}

-- Choose the active theme
local active_theme = "catppuccin"  -- Change this to switch theme
local theme_config = themes[active_theme]

return {
  {
    theme_config.plugin,
    priority = 1000,
    lazy = false,
    config = function()
      -- Safely require the theme module
      if theme_config.module and theme_config.opts then
        local ok, theme_module = pcall(require, theme_config.module)
        if ok and theme_module and type(theme_module.setup) == "function" then
          theme_module.setup(theme_config.opts)
        end
      end

      -- Apply the colorscheme
      vim.cmd.colorscheme(active_theme)
    end,
  },
}
