
-- ~/.config/nvim/lua/user/plugins/ts_comment.lua
-- Treesitter-aware comment plugin

return {
  "folke/ts-comments.nvim",
  event = "VeryLazy",
  enabled = vim.fn.has("nvim-0.10") == 1, -- chỉ dùng nếu nvim >= 0.10
  opts = {
    lang = {
      javascript = {
        "// %s",                 -- line comment
        "/* %s */",             -- block comment
        jsx_element = "{/* %s */}",
        jsx_fragment = "{/* %s */}",
      },
      typescript = "// %s",
      lua = "-- %s",
      python = "# %s",
    },
  },
}
