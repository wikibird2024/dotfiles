-- lua/user/core/options.lua
local opt = vim.opt

-- =============================================================================
-- UI & USER EXPERIENCE
-- =============================================================================
opt.number         = true           -- Show absolute line numbers
opt.relativenumber = true           -- Show relative line numbers for easier motion
opt.cursorline     = true           -- Highlight the current line
opt.termguicolors  = true           -- Enable 24-bit RGB colors
opt.signcolumn     = "yes"          -- Always show sign column to prevent layout shifts
opt.scrolloff      = 8              -- Keep 8 lines above/below cursor when scrolling
opt.mouse          = "a"            -- Enable mouse support in all modes
opt.wrap           = true           -- Enable line wrapping
opt.linebreak      = true           -- Wrap lines at convenient points (word boundaries)

-- =============================================================================
-- TABS & INDENTATION (Standard 4 spaces for Rust/Lua)
-- =============================================================================
opt.tabstop        = 4              -- Number of spaces a <Tab> counts for
opt.shiftwidth     = 4              -- Size of an indent
opt.expandtab      = true           -- Convert tabs to spaces
opt.smartindent    = true           -- Make indenting smart

-- =============================================================================
-- SEARCH & SYSTEM
-- =============================================================================
opt.ignorecase     = true           -- Ignore case in search patterns
opt.smartcase      = true           -- Override ignorecase if search contains capitals
opt.hlsearch       = true           -- Highlight all matches of previous search
opt.incsearch      = true           -- Show search matches while typing
opt.clipboard      = "unnamedplus"  -- Sync with system clipboard
opt.undofile       = true           -- Save undo history to a file
opt.updatetime     = 250            -- Faster completion and diagnostic display
opt.timeoutlen     = 300            -- Time to wait for a mapped sequence to complete
opt.splitright     = true           -- Open new vertical splits to the right
opt.splitbelow     = true           -- Open new horizontal splits below
