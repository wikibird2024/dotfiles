-- ======================================================================
-- WHICH-KEY (Stable for Neovim ≥ 0.11)
-- Author : Ginko
-- ======================================================================

return {
  "folke/which-key.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    local wk = require("which-key")

    wk.setup({
      delay = 300,

      win = {
        border = "rounded",
        padding = { 1, 2, 1, 2 },
        zindex = 1000,
      },

      layout = {
        height = { min = 4, max = 25 },
        width = { min = 20, max = 50 },
        spacing = 4,
        align = "left",
      },

      icons = {
        breadcrumb = "»",
        separator = "➜",
        group = "+",
      },

      show_help = true,
      show_keys = true,

      -- ✅ modern syntax: explicit trigger list
      triggers = {
        { "<leader>", mode = { "n", "v" } },
        { "g", mode = { "n", "v" } },
        { "]", mode = "n" },
        { "[", mode = "n" },
      },

      -- ✅ replace deprecated ignore_missing
      filter = function(mapping)
        return true -- hiển thị toàn bộ mapping
      end,
    })

    -- Leader groups
    wk.add({
      { "<leader>f", group = "File" },
      { "<leader>g", group = "Git" },
      { "<leader>l", group = "LSP" },
      { "<leader>b", group = "Buffer" },
      { "<leader>t", group = "Tools" },
      { "<leader>q", group = "Quit" },
    })
  end,
}

