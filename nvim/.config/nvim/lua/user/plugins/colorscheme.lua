
-- Colorscheme configuration for Gruvbox
-- File: ~/.config/nvim/lua/user/plugins/colorscheme.lua

return {
  {
    "ellisonleao/gruvbox.nvim",  -- Gruvbox colorscheme plugin
    priority = 1000,             -- Ensure it loads before all other plugins (highest priority)
    lazy = false,                -- Do not lazy load; apply immediately at startup
    config = function()
      -- Optional Gruvbox setup before applying the theme
      require("gruvbox").setup({
        contrast = "hard",       -- Options: "soft", "medium", "hard"
        overrides = {},          -- You can override highlight groups here
      })

      -- Set the colorscheme
      vim.cmd.colorscheme("gruvbox")
    end,
  },
}
