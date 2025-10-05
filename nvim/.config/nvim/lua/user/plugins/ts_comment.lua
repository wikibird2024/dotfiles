
-- ~/.config/nvim/lua/user/plugins/ts_comments.lua
-- Treesitter-aware comments plugin

return {
  "folke/ts-comments.nvim",
  event = "VeryLazy",
  enabled = vim.fn.has("nvim-0.10") == 1, -- check version >= 0.10
  opts = {
    lang = {
      javascript = {
        "// %s",       -- line comment
        "/* %s */",   -- block comment fallback
        jsx_element = "{/* %s */}",
        jsx_fragment = "{/* %s */}",
      },
      typescript = "// %s",
      -- thêm ngôn ngữ khác nếu cần
    },
  },
}
