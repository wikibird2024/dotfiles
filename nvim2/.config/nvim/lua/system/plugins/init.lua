
-- lua/system/plugins/init.lua
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  spec = {
    { import = "system.plugins.colorscheme" },
    { import = "system.plugins.ui" },
    { import = "system.plugins.tools" },
    { import = "system.plugins.cmp" },
    { import = "system.plugins.lsp" },
    { import = "system.plugins.git" },
    { import = "system.plugins.format" },
    { import = "system.plugins.treesitter" },
    { import = "system.plugins.snippets" },
    { import = "system.plugins.terminal" },
    { import = "system.plugins.ts_comment" },
  },
  defaults = { lazy = true },
  debug = false,
})
