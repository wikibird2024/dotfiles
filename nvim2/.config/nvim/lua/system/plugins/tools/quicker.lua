-- ~/.config/nvim/lua/system/plugins/tools/quicker.lua

return {
  "stevearc/quicker.nvim",
  event = "FileType qf",
  opts = {
    max_height = 12,
    min_height = 6,
    follow_current_file = true, -- Automatically scrolls quickfix to your current file location

    -- Aesthetic enhancements
    borders = {
      vert = "│",
      horiz = "─",
      topleft = "┌",
      topright = "┐",
      bottomleft = "└",
      bottomright = "┘",
    },

    -- Modern UI status icons for diagnostics or text matches
    type_icons = {
      E = " 󰅚 ", -- Error
      W = " 󰀪 ", -- Warning
      I = " 󰋽 ", -- Info
      N = " 󰋽 ", -- Hint
    },

    highlight = {
      treesitter = true, -- Uses Treesitter parser highlighting within quickfix lines
    },
  },
  config = function(_, opts)
    require("quicker").setup(opts)
  end,
}
