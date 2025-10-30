
return {
  "folke/ts-comments.nvim",
  event = "VeryLazy",
  enabled = vim.fn.has("nvim-0.10") == 1,
  opts = {
    lang = {
      javascript = { "// %s", "/* %s */", jsx_element = "{/* %s */}", jsx_fragment = "{/* %s */}" },
      typescript = "// %s",
    },
  },
}
