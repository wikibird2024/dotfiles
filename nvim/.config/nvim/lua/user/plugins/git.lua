
-- Git integration plugin configuration using gitsigns.nvim
-- File: ~/.config/nvim/lua/user/plugins/git.lua

return {
  "lewis6991/gitsigns.nvim",  -- Plugin: Show Git changes in the sign column
  event = { "BufReadPre", "BufNewFile" }, -- Lazy-load when a buffer is opened or created
  config = function()
    require("gitsigns").setup({
      -- You can customize more here if needed
      -- e.g., signs, keymaps, current_line_blame, etc.
    })
  end,
}
