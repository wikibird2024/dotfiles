
-- ======================================================================
-- WHICH-KEY Minimal UI Setup (Neovim ≥ 0.11)
-- Author: Ginko
-- ======================================================================

return {
  "folke/which-key.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local wk = require("which-key")

    wk.setup({
      -- Delay before popup appears (ms)
      delay = 300,

      -- Window appearance
      win = {
        border = "rounded",
        padding = { 1, 2, 1, 2 },
        zindex = 1000,
      },

      -- Layout of the popup
      layout = {
        height = { min = 4, max = 25 },
        width  = { min = 20, max = 50 },
        spacing = 4,
        align = "left",
      },

      -- Icons for breadcrumbs, groups, and separators
      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
      },

      -- Show help and keys
      show_help = true,
      show_keys = true,

      -- Only set triggers (modern syntax)
      triggers = { "<leader>" },  -- only triggers, actual keymaps in core/keymaps.lua
    })
  end,
}
