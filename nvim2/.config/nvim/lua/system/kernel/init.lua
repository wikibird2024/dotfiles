-- lua/system/kernel/init.lua

-- 1. Load các cài đặt nền tảng
require("system.kernel.options")
require("system.kernel.keymap")
require("system.kernel.autocommands")

-- 2. Bootstrap Lazy.nvim (Code cài đặt tự động)
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    vim.fn.system({
        "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath
    })
end
vim.opt.rtp:prepend(lazypath)

-- 3. Khởi chạy Lazy và nạp Specs từ plugins/init.lua
require("lazy").setup({
    spec = {
        -- Đây là lúc Lazy gọi đến file plugins/init.lua của bạn
        { import = "system.plugins" },
    },
    defaults = { lazy = true },
    -- Thay đổi màu sắc thông báo lỗi cho dễ nhìn
    ui = { border = "rounded" },
})
