vim.g.mapleader = " "
local map  = vim.keymap.set
local opts = { noremap = true, silent = true }

-- ─────────────────────────────────────────────
-- Safe require
-- ─────────────────────────────────────────────
local function safe_require(name)
  local ok, mod = pcall(require, name)
  return ok and mod or nil
end

local wk      = safe_require("which-key")
local cmp      = safe_require("cmp")
local luasnip = safe_require("luasnip")
local ufo      = safe_require("ufo")

-- ─────────────────────────────────────────────
-- Core Engine: Hệ thống đăng ký "Sạch"
-- ─────────────────────────────────────────────

-- Hàm đăng ký lõi: Tách biệt hoàn toàn việc Map và Hiển thị
local function register_core_logic(prefix, maps)
  for k, v in pairs(maps) do
    if k ~= "name" then
      local key = (k == "") and prefix or (prefix .. k)

      if type(v) == "table" then
        register_core_logic(key, v)
      else
        -- Desc luôn lấy từ maps.name của nhóm để tránh loạn thông tin
        map("n", key, v, { noremap = true, silent = true, desc = maps.name })
      end
    end
  end
end

-- ─────────────────────────────────────────────
-- ARCHITECTURE: Leader Maps Definition (The Truth)
-- ─────────────────────────────────────────────
local leader_maps = {
  f = {
    name = "File/Find",
    [""] = "<cmd>Telescope find_files<CR>",
    g    = "<cmd>Telescope live_grep<CR>",
    r    = "<cmd>Telescope oldfiles<CR>",
    s    = "<cmd>w<CR>",
    e    = "<cmd>NvimTreeToggle<CR>",
    f    = function() vim.lsp.buf.format({ async = true }) end,
    t    = "<cmd>TodoTelescope<CR>",
  },
  b = {
    name = "Buffer",
    [""] = "<cmd>Telescope buffers<CR>",
    n    = "<cmd>bnext<CR>",
    p    = "<cmd>bprevious<CR>",
    d    = "<cmd>bdelete<CR>",
    o    = "<cmd>BufferLineCloseOthers<CR>",
  },
  w = {
    name = "Window",
    [""] = "<C-w>w",
    s    = "<cmd>split<CR>",
    v    = "<cmd>vsplit<CR>",
    q    = "<cmd>close<CR>",
    h    = "<C-w>h",
    l    = "<C-w>l",
    j    = "<C-w>j",
    k    = "<C-w>k",
  },
  t = {
    name = "Terminal",
    [""] = "<cmd>ToggleTerm<CR>",
    f    = "<cmd>ToggleTerm direction=float<CR>",
    s    = "<cmd>ToggleTerm direction=horizontal<CR>",
    v    = "<cmd>ToggleTerm direction=vertical<CR>",
    ["1"] = "<cmd>1ToggleTerm<CR>",
    ["2"] = "<cmd>2ToggleTerm<CR>",
  },
  l = {
    name = "LSP/Code",
    d = vim.lsp.buf.definition,
    r = vim.lsp.buf.rename,
    h = vim.lsp.buf.hover,
    a = vim.lsp.buf.code_action,
    e = "<cmd>Telescope diagnostics bufnr=0<CR>",
  },
  g = {
    name = "Git",
    s = "<cmd>Gitsigns stage_hunk<CR>",
    b = "<cmd>Gitsigns blame_line<CR>",
    d = "<cmd>Gitsigns diffthis<CR>",
    p = "<cmd>Gitsigns preview_hunk<CR>",
  },
  p = {
    name = "Plugins",
    [""] = "<cmd>Lazy<CR>",
    u    = "<cmd>Lazy update<CR>",
  },
}

-- Thực hiện đăng ký phím trực tiếp vào Neovim
register_core_logic("<leader>", leader_maps)

-- ─────────────────────────────────────────────
-- UI: Which-key Branding (Chỉ hiển thị menu)
-- ─────────────────────────────────────────────
if wk then
  wk.register({
    ["<leader>f"] = { name = "+File/Find" },
    ["<leader>b"] = { name = "+Buffer" },
    ["<leader>w"] = { name = "+Window" },
    ["<leader>t"] = { name = "+Terminal" },
    ["<leader>l"] = { name = "+LSP" },
    ["<leader>g"] = { name = "+Git" },
    ["<leader>p"] = { name = "+Plugins" },
  })
end

-- ─────────────────────────────────────────────
-- Extra Logic: Tối ưu hóa phản xạ
-- ─────────────────────────────────────────────

-- Tốc độ phản ứng của tổ hợp phím (ms)
vim.opt.timeoutlen = 300

-- Terminal: Thoát mode nhanh bằng Esc/jk
vim.api.nvim_create_autocmd("TermOpen", {
  callback = function(ev)
    local t_opts = { buffer = ev.buf, noremap = true, silent = true }
    map("t", "<Esc>", [[<C-\><C-n>]], t_opts)
    map("t", "jk", [[<C-\><C-n>]], t_opts)
  end,
})

-- Completion Pipeline
if cmp and luasnip then
  map("i", "<Tab>", function()
    if cmp.visible() then cmp.select_next_item()
    elseif luasnip.expand_or_jumpable() then luasnip.expand_or_jump()
    else vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Tab>", true, true, true), "n", true) end
  end, opts)
  map("i", "<S-Tab>", function()
    if cmp.visible() then cmp.select_prev_item()
    elseif luasnip.jumpable(-1) then luasnip.jump(-1) end
  end, opts)
  map("i", "<CR>", function()
    if cmp.visible() then cmp.confirm({ select = true })
    else vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<CR>", true, true, true), "n", true) end
  end, opts)
end

-- UFO Folding
if ufo then
  map("n", "zR", ufo.openAllFolds, { desc = "Open all folds" })
  map("n", "zM", ufo.closeAllFolds, { desc = "Close all folds" })
end
