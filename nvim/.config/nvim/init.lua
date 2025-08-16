
-- ~/.config/nvim/init.lua

-- 1. Set leader key sớm
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- 2. Load cấu hình core: options, keymaps, autocommands
require("user.core")

-- 3. Khởi động Lazy.nvim và load plugin từ user.plugins
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  print("Installing lazy.nvim ...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup("user.plugins")

-- 4. Load utils, autocmd, v.v. nếu cần thêm
-- (nếu đã gọi trong core thì không cần gọi lại)

