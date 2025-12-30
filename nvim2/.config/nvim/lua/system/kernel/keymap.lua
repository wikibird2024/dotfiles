local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- 1. THIẾT LẬP CHUNG
vim.g.mapleader = " "
vim.opt.timeoutlen = 300 -- Thời gian chờ phím (300ms là chuẩn để bấm nhanh ăn ngay)
-- Nhấn Space 2 lần để tắt Highlight tìm kiếm
map("n", "<leader><leader>", "<cmd>noh<CR>", { desc = "Clear Highlight" })

-- Thoát Insert mode nhanh
map("i", "jk", "<Esc>", opts)
map("i", "kj", "<Esc>", opts)

-- ──────────────────────────────────────────────────────────────────────
-- [E] EXPLORER (Neo-tree)
-- ──────────────────────────────────────────────────────────────────────
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Explorer Toggle" })
map("n", "<leader>o", "<cmd>Neotree focus<CR>", { desc = "Explorer Focus" })
map("n", "<leader>r", "<cmd>Neotree reveal<CR>", { desc = "Reveal Current File" })

-- ──────────────────────────────────────────────────────────────────────
-- [F] FIND / SEARCH (Sử dụng Fzf-lua)
-- ──────────────────────────────────────────────────────────────────────
map("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "Live Grep" })
map("n", "<leader>fh", "<cmd>FzfLua oldfiles<CR>", { desc = "History" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Search Buffers" })
map("n", "<leader>fs", "<cmd>w<CR>", { desc = "Save File" })

-- ──────────────────────────────────────────────────────────────────────
-- [B] BUFFER (Quản lý các tệp đang mở)
-- ──────────────────────────────────────────────────────────────────────
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete Buffer" })
map("n", "<leader>ba", "<cmd>%bd|e#|bd#<CR>", { desc = "Close Other Buffers" })

-- ──────────────────────────────────────────────────────────────────────
-- [W] WINDOW (Điều hướng & Chia màn hình)
-- ──────────────────────────────────────────────────────────────────────
map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Split Vertical" })
map("n", "<leader>ws", "<cmd>split<CR>", { desc = "Split Horizontal" })
map("n", "<leader>wq", "<cmd>close<CR>", { desc = "Close Window" })

-- Di chuyển giữa các ô cửa sổ (Ctrl + h/j/k/l)
map("n", "<C-h>", "<C-w>h", { desc = "Focus Left" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus Right" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus Up" })

-- ──────────────────────────────────────────────────────────────────────
-- [T] TERMINAL (ToggleTerm)
-- ──────────────────────────────────────────────────────────────────────
-- KEY QUAN TRỌNG: Nhấn Space + T nhanh sẽ chạy ngay lệnh này
map("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Terminal (Quick Toggle)" })

-- Các option phụ (Which-key sẽ hiện nếu nhấn chậm)
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal Float" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Terminal Horizontal" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Terminal Vertical" })

-- Thoát Terminal mode nhanh & Điều hướng thẳng từ Terminal
function _G.set_terminal_keymaps()
	local t_opts = { buffer = 0 }
	map("t", "<esc>", [[<C-\><C-n>]], t_opts)
	map("t", "jk", [[<C-\><C-n>]], t_opts)
	map("t", "<C-h>", [[<C-\><C-n><C-w>h]], t_opts)
	map("t", "<C-j>", [[<C-\><C-n><C-w>j]], t_opts)
	map("t", "<C-k>", [[<C-\><C-n><C-w>k]], t_opts)
	map("t", "<C-l>", [[<C-\><C-n><C-w>l]], t_opts)
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- ──────────────────────────────────────────────────────────────────────
-- [L] LSP / CODE / LaTeX
-- ──────────────────────────────────────────────────────────────────────
map("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<CR>", { desc = "Definition" })
map("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename Symbol" })
map("n", "<leader>la", "<cmd>FzfLua lsp_code_actions<CR>", { desc = "Code Action" })
map("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover Info" })
map("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({async=true})<CR>", { desc = "Format Code" })
map("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "LSP Information" })

-- Phím tắt cho LaTeX (Dùng L viết hoa để tách biệt với LSP l viết thường)
map("n", "<leader>Lc", "<cmd>VimtexCompile<CR>", { desc = "LaTeX Compile" })
map("n", "<leader>Lv", "<cmd>VimtexView<CR>", { desc = "LaTeX View" })

-- ──────────────────────────────────────────────────────────────────────
-- [V] VISUAL MODE (Thao tác thông minh)
-- ──────────────────────────────────────────────────────────────────────
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move block down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move block up" })
map("v", "<", "<gv", { desc = "Indent Left" })
map("v", ">", ">gv", { desc = "Indent Right" })

-- ──────────────────────────────────────────────────────────────────────
-- [Y] SYSTEM CLIPBOARD
-- ──────────────────────────────────────────────────────────────────────
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Copy to System Clipboard" })
map("n", "<leader>p", [["+p]], { desc = "Paste from Clipboard" })
