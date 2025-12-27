

-- lua/user/core/options.lua

-- local opt = vim.opt
-- =============================
-- UI & Visual Settings
-- =============================
vim.opt.number = true          -- Show absolute line numbers
vim.opt.relativenumber = true  -- Show relative line numbers (useful for motions like 5j, 3k)
vim.opt.cursorline = true      -- Highlight the current line for better focus
vim.opt.wrap = true            -- Enable line wrapping for long lines
vim.opt.linebreak = true       -- Wrap lines at word boundaries instead of breaking mid-word
vim.opt.scrolloff = 5          -- Keep 5 lines visible above and below the cursor when scrolling
vim.opt.termguicolors = true   -- Enable true color support (24-bit RGB)

-- =============================
-- Indentation & Tabs
-- =============================
vim.opt.tabstop = 4       -- Number of spaces that a <Tab> counts for
vim.opt.shiftwidth = 4    -- Number of spaces to use for autoindent
vim.opt.expandtab = true  -- Convert tabs to spaces for consistent formatting

-- =============================
-- Search
-- =============================
vim.opt.hlsearch = true   -- Highlight all matches of the last search
vim.opt.incsearch = true  -- Show search matches as you type

-- =============================
-- Mouse & Clipboard
-- =============================
vim.opt.mouse = 'a'           -- Enable mouse support in all modes (normal, visual, insert)
vim.opt.clipboard = 'unnamedplus' -- Use the system clipboard for copy/paste
