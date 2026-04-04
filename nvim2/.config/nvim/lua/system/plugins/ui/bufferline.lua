
-- user/plugins/ui/bufferline.lua
return {
  {
    "akinsho/bufferline.nvim",           -- Plugin repository
    version = "*",                       -- Use the latest available version
    event = "BufReadPre",                -- Lazy load before buffer is read (fast startup)
    dependencies = "nvim-tree/nvim-web-devicons", -- Icons for buffer labels
    config = function()
      require("bufferline").setup {
        options = {
          diagnostics = "nvim_lsp",      -- Show diagnostics (errors, warnings) per buffer
        },
      }
    end,
  },
}
