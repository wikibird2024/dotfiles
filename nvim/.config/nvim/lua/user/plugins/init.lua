-- ~/.config/nvim/lua/user/plugins/init.lua

return {
  -- Nhóm plugin rõ ràng (grouped folders/modules)
  { import = "user.plugins.cmp" },
  { import = "user.plugins.lsp" },
  { import = "user.plugins.tools" },
  { import = "user.plugins.ui" },
  { import = "user.plugins.snippets" },       -- ✅ Snippets group (e.g., LuaSnip)

  -- Các plugin lẻ nằm ngoài nhóm (single-file modules)
  { import = "user.plugins.colorscheme" },
  { import = "user.plugins.git" },
  { import = "user.plugins.latex" },
  { import = "user.plugins.terminal" },
  { import = "user.plugins.treesitter" },
  { import = "user.plugins.lint" },           -- ✅ Linters (e.g., nvim-lint or null-ls)
  { import = "user.plugins.format" },         -- ✅ Formatter (e.g., conform.nvim)
  { import = "user.plugins.ts_comment" }, 
  { "echasnovski/mini.icons" },
}
