
-- ~/.config/nvim/lua/user/plugins/ts_comment.lua
-- Treesitter-aware comment plugin

return {
  "folke/ts-comments.nvim",
  event = "VeryLazy",
  enabled = vim.fn.has("nvim-0.10") == 1,
  opts = {
    lang = {
      -- Low-level languages
      c = "// %s",
      cpp = "// %s",
      rust = "// %s",

      -- Document Preparation
      latex = "%% %s", -- Double % is needed to escape in Lua
      tex = "%% %s",
      bib = "%% %s",

      -- Web & Scripting
      javascript = {
        "// %s",
        "/* %s */",
        jsx_element = "{/* %s */}",
        jsx_fragment = "{/* %s */}",
      },
      typescript = "// %s",
      lua = "-- %s",
      python = "# %s",

      -- Config & Shell
      bash = "# %s",
      sh = "# %s",
      toml = "# %s", -- Very common for Rust (Cargo.toml)
      yaml = "# %s",
    },
  },
}
