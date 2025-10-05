
vim.g.mapleader = " "

local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ╭────────────────────────────────────────────╮
-- │ <leader>f – FILE / FIND / FORMAT           │
-- ╰────────────────────────────────────────────╯
keymap("n", "<leader>ff", "<cmd>Telescope find_files<CR>", opts)
keymap("n", "<leader>fg", "<cmd>Telescope live_grep<CR>", opts)
keymap("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, opts)

-- ╭────────────────────────────────────────────╮
-- │ <leader>g – GIT                             │
-- ╰────────────────────────────────────────────╯
keymap("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", opts)
keymap("n", "<leader>gb", "<cmd>Gitsigns blame_line<CR>", opts)

-- ╭────────────────────────────────────────────╮
-- │ <leader>b – BUFFER                          │
-- ╰────────────────────────────────────────────╯
keymap("n", "<leader>bd", "<cmd>bdelete<CR>", opts)
keymap("n", "<leader>bn", "<cmd>bnext<CR>", opts)
keymap("n", "<leader>bp", "<cmd>bprevious<CR>", opts)

-- ╭────────────────────────────────────────────╮
-- │ <leader>w – WINDOW                          │
-- ╰────────────────────────────────────────────╯
keymap("n", "<leader>ws", "<cmd>split<CR>", opts)
keymap("n", "<leader>wv", "<cmd>vsplit<CR>", opts)
keymap("n", "<leader>wc", "<cmd>close<CR>", opts)

-- ╭────────────────────────────────────────────╮
-- │ <leader>l – LSP                              │
-- ╰────────────────────────────────────────────╯
keymap("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
keymap("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
keymap("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
keymap("n", "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

-- ╭────────────────────────────────────────────╮
-- │ <leader>d – DEBUG / DAP                     │
-- ╰────────────────────────────────────────────╯
keymap("n", "<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", opts)
keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<CR>", opts)
keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<CR>", opts)
keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<CR>", opts)

-- ╭────────────────────────────────────────────╮
-- │ <leader>t – TERMINAL & TOGGLE              │
-- ╰────────────────────────────────────────────╯
local keymap = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Terminal toggle bình thường
keymap("n", "<leader>tt", "<cmd>ToggleTerm<CR>", opts)

-- Thoát terminal mode nhanh
keymap("t", "<Esc>", [[<C-\><C-n>]], opts)
keymap("t", "jk", [[<C-\><C-n>]], opts)

-- NvimTree toggle
keymap("n", "<leader>tn", "<cmd>NvimTreeToggle<CR>", opts)  -- đổi từ <leader>n để tránh trùng

-- ╭────────────────────────────────────────────╮
-- │ IDF Terminal Integrations (ESP32)          │
-- ╰────────────────────────────────────────────╯
-- Mỗi lệnh chạy trong terminal float riêng, tiện theo dõi log
keymap("n", "<leader>tb", "<cmd>1ToggleTerm direction=float<CR>idf.py build<CR>", opts)
keymap("n", "<leader>tf", "<cmd>2ToggleTerm direction=float<CR>idf.py flash<CR>", opts)
keymap("n", "<leader>tm", "<cmd>3ToggleTerm direction=float<CR>idf.py monitor<CR>", opts)

-- ╭────────────────────────────────────────────╮
-- │ <leader>p – PLUGIN / PROJECT MANAGEMENT     │
-- ╰────────────────────────────────────────────╯
keymap("n", "<leader>ps", "<cmd>Lazy<CR>", opts)
keymap("n", "<leader>pi", "<cmd>Lazy install<CR>", opts)
keymap("n", "<leader>pu", "<cmd>Lazy update<CR>", opts)

-- ╭────────────────────────────────────────────╮
-- │ <leader>c – COMMENT / CODE TOOLS            │
-- ╰────────────────────────────────────────────╯
keymap("n", "<leader>cc", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", opts)
keymap("v", "<leader>cc", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", opts)
keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)

-- ╭────────────────────────────────────────────╮
-- │ <leader>s – SEARCH / SYMBOL / SESSION       │
-- ╰────────────────────────────────────────────╯
keymap("n", "<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", opts)
keymap("n", "<leader>sr", "<cmd>Telescope resume<CR>", opts)
keymap("n", "<leader>sh", "<cmd>Telescope help_tags<CR>", opts)

-- ╭────────────────────────────────────────────╮
-- │ <leader><space> – CLEAR SEARCH HIGHLIGHT    │
-- ╰────────────────────────────────────────────╯
keymap("n", "<leader><space>", "<cmd>nohlsearch<CR>", opts)
