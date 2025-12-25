-- File: ~/.config/nvim/lua/system/kernel/options.lua
local opt = vim.opt

opt.number = true           -- Hiện số dòng
opt.relativenumber = true   -- Số dòng tương đối giúp nhảy dòng nhanh
opt.mouse = "a"             -- Cho phép dùng chuột
opt.clipboard = "unnamedplus" -- Dùng chung clipboard với hệ điều hành
opt.tabstop = 4             -- 1 tab = 4 dấu cách
opt.shiftwidth = 4          -- Độ rộng thụt lề
opt.expandtab = true        -- Chuyển tab thành dấu cách
opt.smartindent = true      -- Tự động thụt lề thông minh
opt.termguicolors = true    -- Hỗ trợ màu sắc 24-bit
opt.signcolumn = "yes"      -- Luôn hiện cột bên trái để tránh giật UI
opt.cursorline = true       -- Highlight dòng hiện tại
opt.scrolloff = 8           -- Luôn giữ 8 dòng trống khi cuộn lên/xuống
opt.completeopt = { "menu", "menuone", "noselect" }
