local opt = vim.opt

-- =============================================================================
-- UI & USER EXPERIENCE
-- =============================================================================
opt.number         = true   -- Absolute line numbers
opt.relativenumber = true   -- Relative line numbers for easier motion
opt.cursorline     = true   -- Highlight current line
opt.termguicolors  = true   -- 24-bit RGB colors
opt.signcolumn     = "yes"  -- Always show sign column to prevent layout shifts
opt.scrolloff      = 8      -- Keep 8 lines of context above/below cursor
opt.mouse          = "a"    -- Mouse support in all modes
opt.wrap           = false  -- Do not wrap long lines (scroll horizontally instead)
opt.linebreak      = false  -- Only relevant when wrap is on

-- =============================================================================
-- TABS & INDENTATION
-- =============================================================================
opt.tabstop    = 4      -- Tab width
opt.shiftwidth = 4      -- Indent size
opt.expandtab  = true   -- Use spaces instead of tabs
opt.autoindent = true
opt.smartindent = false -- Disabled: treesitter handles indentation

-- =============================================================================
-- SEARCH & SYSTEM
-- =============================================================================
opt.ignorecase = true           -- Case-insensitive search
opt.smartcase  = true           -- Override ignorecase when pattern has capitals
opt.hlsearch   = true           -- Highlight all search matches
opt.incsearch  = true           -- Show matches while typing
opt.clipboard  = "unnamedplus"  -- Sync with system clipboard
opt.undofile   = true           -- Persist undo history across sessions
opt.updatetime = 250            -- Faster completion and diagnostic updates
opt.timeoutlen = 300            -- Time to wait for a key sequence to complete
opt.splitright = true           -- New vertical splits open to the right
opt.splitbelow = true           -- New horizontal splits open below

-- =============================================================================
-- SPELL CHECK (disabled by default, toggle with <leader>us)
-- =============================================================================
opt.spelllang = "en_us"
opt.spell     = false
