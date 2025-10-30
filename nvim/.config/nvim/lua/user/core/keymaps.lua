
-- File: core/keymaps.lua
-- ======================================================================
-- Professional & Maintainable Keymaps Layout
-- Everything in a single, organized file
-- Author: Ginko

vim.g.mapleader = " "
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ╭────────────────────────────────────────────╮
-- │ Helper functions                            │
-- ╰────────────────────────────────────────────╯
local function nmap(lhs, rhs, desc) map("n", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc })) end
local function vmap(lhs, rhs, desc) map("v", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc })) end
local function tmap(lhs, rhs, desc) map("t", lhs, rhs, vim.tbl_extend("force", opts, { desc = desc })) end

-- ╭────────────────────────────────────────────╮
-- │ Core Keymaps                                │
-- ╰────────────────────────────────────────────╯
local function setup_core()
  -- FILE / FIND / FORMAT
  nmap("<leader>ff", "<cmd>Telescope find_files<CR>", "Find files")
  nmap("<leader>fg", "<cmd>Telescope live_grep<CR>", "Live grep")
  nmap("<leader>fr", "<cmd>Telescope oldfiles<CR>", "Recent files")
  nmap("<leader>fs", "<cmd>w<CR>", "Save file")
  nmap("<leader>fS", "<cmd>wa<CR>", "Save all files")
  nmap("<leader>fF", function() vim.lsp.buf.format({ async = true }) end, "Format buffer")

  -- BUFFER MANAGEMENT
  nmap("<leader>bn", "<cmd>bnext<CR>", "Next buffer")
  nmap("<leader>bp", "<cmd>bprevious<CR>", "Previous buffer")
  nmap("<leader>bd", "<cmd>bdelete<CR>", "Delete buffer")
  nmap("<leader>bo", "<cmd>BufferLineCloseOthers<CR>", "Close other buffers")

  -- WINDOW / SPLIT
  nmap("<leader>ws", "<cmd>split<CR>", "Horizontal split")
  nmap("<leader>wv", "<cmd>vsplit<CR>", "Vertical split")
  nmap("<leader>wc", "<cmd>close<CR>", "Close window")
  nmap("<leader>wh", "<C-w>h", "Move left")
  nmap("<leader>wl", "<C-w>l", "Move right")
  nmap("<leader>wj", "<C-w>j", "Move down")
  nmap("<leader>wk", "<C-w>k", "Move up")

  -- TERMINAL MODE
  tmap("<Esc>", [[<C-\><C-n>]], "Exit terminal mode")
  tmap("jk", [[<C-\><C-n>]], "Exit terminal mode")
end

-- ╭────────────────────────────────────────────╮
-- │ LSP / Completion / Snippets                 │
-- ╰────────────────────────────────────────────╯
local function setup_lsp_cmp()
  -- LSP / INTELLISENSE
  nmap("<leader>ld", vim.lsp.buf.definition, "Go to definition")
  nmap("<leader>lr", vim.lsp.buf.rename, "Rename symbol")
  nmap("<leader>lh", vim.lsp.buf.hover, "Hover info")
  nmap("<leader>li", vim.lsp.buf.implementation, "Go to implementation")
  nmap("<leader>la", vim.lsp.buf.code_action, "Code action")
  nmap("<leader>le", "<cmd>Telescope diagnostics bufnr=0<CR>", "Diagnostics")

  -- CMP Completion navigation (assuming nvim-cmp)
  local cmp_ok, cmp = pcall(require, "cmp")
  if cmp_ok then
    map("i", "<C-n>", function() if cmp.visible() then cmp.select_next_item() else vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Down>", true, true, true), "n", true) end end, opts)
    map("i", "<C-p>", function() if cmp.visible() then cmp.select_prev_item() else vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Up>", true, true, true), "n", true) end end, opts)
    map("i", "<CR>", function() if cmp.visible() then cmp.confirm({ select = true }) else vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", true) end end, opts)
    map("i", "<Tab>", function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end, { noremap = true, silent = true })
    map("i", "<S-Tab>", function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end, { noremap = true, silent = true })
  end
end

-- ╭────────────────────────────────────────────╮
-- │ Git / Plugin Management                      │
-- ╰────────────────────────────────────────────╯
local function setup_git_plugins()
  nmap("<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", "Stage hunk")
  nmap("<leader>gb", "<cmd>Gitsigns blame_line<CR>", "Blame line")
  nmap("<leader>gd", "<cmd>Gitsigns diffthis<CR>", "Diff hunk")
  nmap("<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", "Preview hunk")

  nmap("<leader>ps", "<cmd>Lazy<CR>", "Lazy menu")
  nmap("<leader>pi", "<cmd>Lazy install<CR>", "Install plugins")
  nmap("<leader>pu", "<cmd>Lazy update<CR>", "Update plugins")
  nmap("<leader>pc", "<cmd>Lazy clean<CR>", "Clean plugins")
end

-- ╭────────────────────────────────────────────╮
-- │ Terminal / File Tree / Comment / Search     │
-- ╰────────────────────────────────────────────╯
local function setup_tools_ui()
  -- Terminal / Tree
  nmap("<leader>tt", "<cmd>ToggleTerm<CR>", "Toggle terminal")
  nmap("<leader>te", "<cmd>NvimTreeToggle<CR>", "Toggle file tree")
  nmap("<leader>tf", "<cmd>NvimTreeFocus<CR>", "Focus file tree")

  -- Comment
  nmap("<leader>cc", "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>", "Toggle line comment")

  -- Search / Symbol / Session
  nmap("<leader>ss", "<cmd>Telescope lsp_document_symbols<CR>", "Document symbols")
  nmap("<leader>sr", "<cmd>Telescope resume<CR>", "Resume search")
  nmap("<leader>sh", "<cmd>Telescope help_tags<CR>", "Help tags")
  nmap("<leader>sk", "<cmd>Telescope keymaps<CR>", "Show keymaps")
end

-- ╭────────────────────────────────────────────╮
-- │ Treesitter / Folding                          │
-- ╰────────────────────────────────────────────╯
local function setup_treesitter()
  nmap("zR", "<cmd>lua require('ufo').openAllFolds()<CR>", "Open all folds")
  nmap("zM", "<cmd>lua require('ufo').closeAllFolds()<CR>", "Close all folds")
  -- Add more treesitter-based textobj/motion mappings here
end

-- ╭────────────────────────────────────────────╮
-- │ Telescope / TODO / NUMB / Tools             │
-- ╰────────────────────────────────────────────╯
local function setup_tools()
  nmap("<leader>fb", "<cmd>Telescope buffers<CR>", "Buffers")
  nmap("<leader>ft", "<cmd>Telescope tags<CR>", "Tags")
  nmap("<leader>fgs", "<cmd>Telescope git_status<CR>", "Git status")
  nmap("<leader>ftodo", "<cmd>TodoTelescope<CR>", "TODOs")
end

-- ╭────────────────────────────────────────────╮
-- │ Which-key registration                       │
-- ╰────────────────────────────────────────────╯
local function setup_whichkey()
  local wk_ok, wk = pcall(require, "which-key")
  if wk_ok then
    wk.register({
      -- All mappings will show in which-key menu
    }, { prefix = "<leader>" })
  end
end

-- ╭────────────────────────────────────────────╮
-- │ Initialize all mappings                     │
-- ╰────────────────────────────────────────────╯
local function setup_all()
  setup_core()
  setup_lsp_cmp()
  setup_git_plugins()
  setup_tools_ui()
  setup_treesitter()
  setup_tools()
  setup_whichkey()
end

setup_all()

-- Export helpers if needed by other modules
return { nmap = nmap, vmap = vmap, tmap = tmap }
