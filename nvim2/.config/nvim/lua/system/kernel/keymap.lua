local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 1. THIẾT LẬP CHUNG
vim.g.mapleader = " "
vim.opt.timeoutlen = 300

-- Nhấn Space 2 lần để tắt Highlight tìm kiếm
map("n", "<leader><leader>", "<cmd>noh<CR>", { desc = "Clear Highlight" })

-- Thoát Insert mode nhanh
map("i", "jk", "<Esc>", opts)
map("i", "kj", "<Esc>", opts)

-- ──────────────────────────────────────────────────────────────────────
-- [SIÊU TỐC] NEO-TREE (Mở/Đóng/Tìm nhanh)
-- ──────────────────────────────────────────────────────────────────────
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Explorer Toggle" })
map("n", "<leader>o", "<cmd>Neotree focus<CR>", { desc = "Explorer Focus" })
map("n", "<leader>r", "<cmd>Neotree reveal<CR>", { desc = "Reveal Current File" })

-- ──────────────────────────────────────────────────────────────────────
-- [F] FIND / SEARCH (Sử dụng Fzf-lua)
-- ──────────────────────────────────────────────────────────────────────
map("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "Live Grep" })
map("n", "<leader>fh", "<cmd>FzfLua oldfiles<CR>", { desc = "History (Recent Files)" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Search Buffers" })
map("n", "<leader>fs", "<cmd>w<CR>", { desc = "Save File" })

-- ──────────────────────────────────────────────────────────────────────
-- [B] BUFFER (Quản lý các tệp đang mở)
-- ──────────────────────────────────────────────────────────────────────
map("n", "<leader>bn", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<leader>bp", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete Buffer" })
map("n", "<leader>ba", "<cmd>%bd|e#|bd#<CR>", { desc = "Close Other Buffers" })

-- Chuyển Tab nhanh bằng phím [ và ]
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next Buffer" })

-- ──────────────────────────────────────────────────────────────────────
-- [W] WINDOW (Điều hướng & Chia màn hình)
-- ──────────────────────────────────────────────────────────────────────
map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Split Vertical" })
map("n", "<leader>ws", "<cmd>split<CR>", { desc = "Split Horizontal" })
map("n", "<leader>wq", "<cmd>close<CR>", { desc = "Close Window" })

-- Di chuyển giữa các ô cửa sổ bằng Ctrl + h/j/k/l (Cực nhanh)
map("n", "<C-h>", "<C-w>h", { desc = "Focus Left" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus Right" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus Up" })

-- ──────────────────────────────────────────────────────────────────────
-- [T] TERMINAL (ToggleTerm)
-- ──────────────────────────────────────────────────────────────────────
map("n", "<leader>tt", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Terminal Horizontal" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal Float" })

-- Thoát Terminal mode nhanh
map("t", "<Esc>", [[<C-\><C-n>]], opts)
map("t", "jk", [[<C-\><C-n>]], opts)

-- ──────────────────────────────────────────────────────────────────────
-- [L] LSP / CODE (Hỗ trợ lập trình)
-- ──────────────────────────────────────────────────────────────────────
map("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<CR>", { desc = "Definition" })
map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename Symbol" })
map("n", "<leader>la", "<cmd>FzfLua lsp_code_actions<CR>", { desc = "Code Action" })
map("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover Info" })
map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({async=true})<CR>", { desc = "Format Code" })
map("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "LSP Information" })

-- ──────────────────────────────────────────────────────────────────────
-- [V] VISUAL MODE (Thao tác dòng thông minh)
-- ──────────────────────────────────────────────────────────────────────
-- Di chuyển khối code đã chọn lên/xuống bằng J/K
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block up" })
-- Giữ nguyên lựa chọn sau khi thụt dòng
map("v", "<", "<gv")
map("v", ">", ">gv")

-- ──────────────────────────────────────────────────────────────────────
-- [Y] SYSTEM CLIPBOARD (Arch Linux - Cần xclip/wl-clipboard)
-- ──────────────────────────────────────────────────────────────────────
map({"n", "v"}, "<leader>y", [["+y]], { desc = "Copy to System Clipboard" })
map("n", "<leader>Y", [["+Y]], { desc = "Copy Line to Clipboard" })
map("n", "<leader>p", [["+p]], { desc = "Paste from Clipboard" })

-- ──────────────────────────────────────────────────────────────────────
-- WHICH-KEY GROUPS (Cấu hình hiển thị menu Pro)
-- ──────────────────────────────────────────────────────────────────────
local ok_wk, wk = pcall(require, "which-key")
if ok_wk then
  wk.add({
    { "<leader>e", icon = "󰙅 ", desc = "Explorer (Toggle)" },
    { "<leader>o", icon = "󰽙 ", desc = "Explorer (Focus)" },
    { "<leader>r", icon = "󰈞 ", desc = "Explorer (Reveal)" },
    { "<leader>f", group = "Find/Search", icon = " " },
    { "<leader>b", group = "Buffer", icon = "󰓩 " },
    { "<leader>w", group = "Window", icon = "󱂬 " },
    { "<leader>l", group = "LSP/Code", icon = "󰅩 " },
    { "<leader>t", group = "Terminal", icon = "󱂇 " },
    { "<leader>p", group = "Clipboard/Plugins", icon = "󰅌 " },
    { "<leader><leader>", desc = "Clear Highlight", icon = "󰛉 " },
    -- Ẩn phím y trong menu chính cho gọn
    { "<leader>y", hidden = true },
  })
end
