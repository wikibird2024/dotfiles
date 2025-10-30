
-- File: core/keymaps.lua
-- ======================================================================
-- Professional & Maintainable Keymaps Layout
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

local function safe_require(name)
  local ok, mod = pcall(require, name)
  if ok then return mod end
end

-- Ensure fallback description is always a string
local function ensure_desc(rhs)
  if type(rhs) == "string" then return rhs end
  return "Keymap"
end

-- ╭────────────────────────────────────────────╮
-- │ Leader keymaps definitions                  │
-- ╰────────────────────────────────────────────╯
local leader_maps = {
  -- FILE / FIND / FORMAT
  f = {
    name = "File",
    ff = "<cmd>Telescope find_files<CR>",
    fg = "<cmd>Telescope live_grep<CR>",
    fr = "<cmd>Telescope oldfiles<CR>",
    fs = "<cmd>w<CR>",
    fS = "<cmd>wa<CR>",
    fF = function() vim.lsp.buf.format({ async = true }) end,
    fb = "<cmd>Telescope buffers<CR>",
    ft = "<cmd>Telescope tags<CR>",
    fgs = "<cmd>Telescope git_status<CR>",
    ftodo = "<cmd>TodoTelescope<CR>",
  },

  -- BUFFER
  b = {
    name = "Buffer",
    bn = "<cmd>bnext<CR>",
    bp = "<cmd>bprevious<CR>",
    bd = "<cmd>bdelete<CR>",
    bo = "<cmd>BufferLineCloseOthers<CR>",
  },

  -- WINDOW / SPLIT
  w = {
    name = "Window",
    ws = "<cmd>split<CR>",
    wv = "<cmd>vsplit<CR>",
    wc = "<cmd>close<CR>",
    wh = "<C-w>h",
    wl = "<C-w>l",
    wj = "<C-w>j",
    wk = "<C-w>k",
  },

  -- TERMINAL / TREE / UI
  t = {
    name = "Terminal/Tree",
    tt = "<cmd>ToggleTerm<CR>",
    te = "<cmd>NvimTreeToggle<CR>",
    tf = "<cmd>NvimTreeFocus<CR>",
  },

  -- COMMENT
  c = {
    name = "Comment",
    cc = "<cmd>lua require('Comment.api').toggle.linewise.current()<CR>",
  },

  -- SEARCH / SYMBOL / SESSION
  s = {
    name = "Search",
    ss = "<cmd>Telescope lsp_document_symbols<CR>",
    sr = "<cmd>Telescope resume<CR>",
    sh = "<cmd>Telescope help_tags<CR>",
    sk = "<cmd>Telescope keymaps<CR>",
  },

  -- LSP
  l = {
    name = "LSP",
    ld = vim.lsp.buf.definition,
    lr = vim.lsp.buf.rename,
    lh = vim.lsp.buf.hover,
    li = vim.lsp.buf.implementation,
    la = vim.lsp.buf.code_action,
    le = "<cmd>Telescope diagnostics bufnr=0<CR>",
  },

  -- GIT
  g = {
    name = "Git",
    gs = "<cmd>Gitsigns stage_hunk<CR>",
    gb = "<cmd>Gitsigns blame_line<CR>",
    gd = "<cmd>Gitsigns diffthis<CR>",
    gp = "<cmd>Gitsigns preview_hunk<CR>",
  },

  -- PLUGINS
  p = {
    name = "Plugins",
    ps = "<cmd>Lazy<CR>",
    pi = "<cmd>Lazy install<CR>",
    pu = "<cmd>Lazy update<CR>",
    pc = "<cmd>Lazy clean<CR>",
  },
}

-- ╭────────────────────────────────────────────╮
-- │ Register leader keymaps with which-key      │
-- ╰────────────────────────────────────────────╯
local wk_ok, wk = pcall(require, "which-key")
if wk_ok then
  wk.register(leader_maps, { prefix = "<leader>" })
else
  -- fallback nếu which-key chưa cài
  for group, maps in pairs(leader_maps) do
    for k, rhs in pairs(maps) do
      if k ~= "name" then
        nmap("<leader>" .. k, rhs, ensure_desc(rhs))
      end
    end
  end
end

-- ╭────────────────────────────────────────────╮
-- │ Terminal mode escape                        │
-- ╰────────────────────────────────────────────╯
tmap("<Esc>", [[<C-\><C-n>]], "Exit terminal mode")
tmap("jk", [[<C-\><C-n>]], "Exit terminal mode")

-- ╭────────────────────────────────────────────╮
-- │ CMP (completion) helpers                     │
-- ╰────────────────────────────────────────────╯
local cmp_ok, cmp = pcall(require, "cmp")
if cmp_ok then
  map("i", "<C-n>", function()
    if cmp.visible() then cmp.select_next_item()
    else vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Down>", true, true, true), "n", true) end
  end, opts)

  map("i", "<C-p>", function()
    if cmp.visible() then cmp.select_prev_item()
    else vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Up>", true, true, true), "n", true) end
  end, opts)

  map("i", "<CR>", function()
    if cmp.visible() then cmp.confirm({ select = true })
    else vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", true) end
  end, opts)

  map("i", "<Tab>", function(fallback) if cmp.visible() then cmp.select_next_item() else fallback() end end, opts)
  map("i", "<S-Tab>", function(fallback) if cmp.visible() then cmp.select_prev_item() else fallback() end end, opts)
end

-- ╭────────────────────────────────────────────╮
-- │ Treesitter / UFO folding                     │
-- ╰────────────────────────────────────────────╯
local ufo_ok = pcall(require, "ufo")
if ufo_ok then
  nmap("zR", "<cmd>lua require('ufo').openAllFolds()<CR>", "Open all folds")
  nmap("zM", "<cmd>lua require('ufo').closeAllFolds()<CR>", "Close all folds")
end

-- Export helpers
return { nmap = nmap, vmap = vmap, tmap = tmap }
