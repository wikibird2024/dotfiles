
-- ======================================================================
-- 🧠 Ginko Keymap System – Professional Embedded Developer Layout
-- ======================================================================

vim.g.mapleader = " "
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ╭────────────────────────────────────────────╮
-- │ Helper function                            │
-- ╰────────────────────────────────────────────╯
local function nmap(lhs, rhs, desc)
  map("n", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end
local function vmap(lhs, rhs, desc)
  map("v", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end
local function tmap(lhs, rhs, desc)
  map("t", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end

-- ╭────────────────────────────────────────────╮
-- │ FILE / FIND / FORMAT                       │
-- ╰────────────────────────────────────────────╯
nmap("<leader>ff", "<cmd>Telescope find_files<CR>", "Find files")
nmap("<leader>fg", "<cmd>Telescope live_grep<CR>", "Live grep")
nmap("<leader>fr", "<cmd>Telescope oldfiles<CR>", "Recent files")
nmap("<leader>fs", "<cmd>w<CR>", "Save file")
nmap("<leader>fS", "<cmd>wa<CR>", "Save all files")
nmap("<leader>f", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")

-- ╭────────────────────────────────────────────╮
-- │ BUFFER MANAGEMENT                          │
-- ╰────────────────────────────────────────────╯
nmap("<leader>bn", "<cmd>bnext<CR>", "Next buffer")
nmap("<leader>bp", "<cmd>bprevious<CR>", "Previous buffer")
nmap("<leader>bd", "<cmd>bdelete<CR>", "Delete buffer")
nmap("<leader>bo", "<cmd>BufferLineCloseOthers<CR>", "Close other buffers")

-- ╭────────────────────────────────────────────╮
-- │ WINDOW / SPLIT                             │
-- ╰────────────────────────────────────────────╯
nmap("<leader>ws", "<cmd>split<CR>", "Horizontal split")
nmap("<leader>wv", "<cmd>vsplit<CR>", "Vertical split")
nmap("<leader>wc", "<cmd>close<CR>", "Close window")
nmap("<leader>wh", "<C-w>h", "Move left")
nmap("<leader>wl", "<C-w>l", "Move right")
nmap("<leader>wj", "<C-w>j", "Move down")
nmap("<leader>wk", "<C-w>k", "Move up")

-- ╭────────────────────────────────────────────╮
-- │ LSP / INTELLISENSE                         │
-- ╰────────────────────────────────────────────╯
nmap("<leader>ld", vim.lsp.buf.definition, "Go to definition")
nmap("<leader>lr", vim.lsp.buf.rename, "Rename symbol")
nmap("<leader>lh", vim.lsp.buf.hover, "Hover info")
nmap("<leader>li", vim.lsp.buf.implementation, "Go to implementation")
nmap("<leader>la", vim.lsp.buf.code_action, "Code action")
nmap("<leader>le", "<cmd>Telescope diagnostics bufnr=0<CR>", "Show diagnostics")

-- ╭────────────────────────────────────────────╮
-- │ DEBUGGING (DAP)                            │
-- ╰────────────────────────────────────────────╯
nmap("<leader>db", "<cmd>lua require'dap'.toggle_breakpoint()<CR>", "Toggle breakpoint")
nmap("<leader>dc", "<cmd>lua require'dap'.continue()<CR>", "Continue")
nmap("<leader>do", "<cmd>lua require'dap'.step_over()<CR>", "Step over")
nmap("<leader>di", "<cmd>lua require'dap'.step_into()<CR>", "Step into")
nmap("<leader>dr", "<cmd>lua require'dap'.repl.open()<CR>", "Open DAP REPL")

-- ╭────────────────────────────────────────────╮
-- │ ESP32 RUN / BUILD / FLASH                  │
-- ╰────────────────────────────────────────────╯
nmap("<leader>rb", "<cmd>1ToggleTerm direction=float<CR>idf.py build<CR>", "Build project")
nmap("<leader>rf", "<cmd>2ToggleTerm direction=float<CR>idf.py flash<CR>", "Flash firmware")
nmap("<leader>rm", "<cmd>3ToggleTerm direction=float<CR>idf.py monitor<CR>", "Serial monitor")
nmap("<leader>ra", "<cmd>4ToggleTerm direction=float<CR>idf.py build flash monitor<CR>", "Build+Flash+Monitor")

-- ╭────────────────────────────────────────────╮
-- │ GIT                                        │
-- ╰────────────────────────────────────────────╯
nmap("<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk")
nmap("<leader>gb", "<cmd>Gitsigns blame_line<CR>", "Blame line")
nmap("<leader>gd", "<cmd>Gitsigns diffthis<CR>", "Diff hunk")
nmap("<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk")

-- ╭────────────────────────────────────────────╮
-- │ TERMINAL / TREE / TOGGLE                   │
-- ╰────────────────────────────────────────────╯
nmap("<leader>tt", "<cmd>ToggleTerm<CR>", "Toggle terminal")
nmap("<leader>te", "<cmd>NvimTreeToggle<CR>", "Toggle file tree")
nmap("<leader>tf", "<cmd>NvimTreeFocus<CR>", "Focus file tree")

tmap("<Esc>", [[<C-\><C-n>]], "Exit terminal mode")
tmap("jk", [[<C-\><C-n>]], "Exit terminal mode")

-- ╭────────────────────────────────────────────╮
-- │ PLUGIN MANAGEMENT                          │
-- ╰────────────────────────────────────────────╯
nmap("<leader>ps", "<cmd>Lazy<CR>", "Lazy menu")
nmap("<leader>pi", "<cmd>Lazy install<CR>", "Install plugins")
nmap("<leader>pu", "<cmd>Lazy update<CR>", "Update plugins")
nmap("<leader>pc", "<cmd>Lazy clean<CR>", "Clean plugins")

-- ╭────────────────────────────────────────────╮
-- │ COMMENT / CODE TOOLS                       │
-- ╰────────────────────────────────────────────╯
nmap("<leader>cc", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "Toggle comment line")
vmap("<leader>cc", "<esc><cmd>lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "Toggle comment block")

-- ╭────────────────────────────────────────────╮
-- │ SEARCH / SYMBOL / SESSION                  │
-- ╰────────────────────────────────────────────╯
nmap("<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", "Document symbols")
nmap("<leader>sr", "<cmd>Telescope resume<CR>", "Resume search")
nmap("<leader>sh", "<cmd>Telescope help_tags<CR>", "Help tags")
nmap("<leader>sk", "<cmd>Telescope keymaps<CR>", "Show keymaps")

-- ╭────────────────────────────────────────────╮
-- │ MISC                                       │
-- ╰────────────────────────────────────────────╯
nmap("<leader><space>", "<cmd>nohlsearch<CR>", "Clear search highlight")
