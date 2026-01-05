-- Gọi hàm map từ module tiện ích
local map = require("system.utils").map

-- 1. THIẾT LẬP CHUNG
vim.g.mapleader = " "
vim.opt.timeoutlen = 250

-- Nhấn Space 2 lần để tắt Highlight tìm kiếm
-- (M.map sẽ tự động gộp {desc} với các option silent/noremap mặc định)
map("n", "<leader><leader>", "<cmd>noh<CR>", { desc = "Clear Highlight" })

-- Thoát Insert mode nhanh
map("i", "jk", "<Esc>")
map("i", "kj", "<Esc>")

-- ──────────────────────────────────────────────────────────────────────
-- [I] INSERT MODE NAVIGATION (Dùng chung cho mọi ngôn ngữ)
-- ──────────────────────────────────────────────────────────────────────

-- Nhảy qua phải 1 ký tự (nhảy qua dấu ngoặc, dấu nháy hoặc bất kỳ ký tự nào)
map("i", "<C-l>", "<Right>", { desc = "Move Right" })

-- Nhảy nhanh xuống cuối dòng (để kết thúc câu, gõ dấu chấm phẩy, v.v.)
map("i", "<C-e>", "<Esc>A", { desc = "Jump to End of Line" })

-- Xuống dòng thông minh cho các cặp ngoặc (C/C++, JS, Lua, CSS, v.v.)
-- Khi nhấn Enter giữa { }, nó sẽ tự đẩy dấu } xuống và thụt lề ở giữa
map("i", "{<CR>", "{<CR>}<Esc>O", { desc = "Smart Brace Break" })

-- LOGIC GÕ ĐÈ DẤU ĐÓNG (Smart Jump Over)
-- Nếu ký tự phía trước con trỏ giống với phím bạn vừa gõ, nó sẽ nhảy qua thay vì gõ đè.
local smart_pairs = { [")"] = ")", ["]"] = "]", ["}"] = "}", ['"'] = '"', ["'"] = "'" }
for _, close in pairs(smart_pairs) do
    map("i", close, function()
        local col = vim.fn.col('.')
        local line = vim.fn.getline('.')
        if line:sub(col, col) == close then
            return "<Right>"
        else
            return close
        end
    end, { expr = true, desc = "Jump over " .. close })
end

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

map("n", "<C-h>", "<C-w>h", { desc = "Focus Left" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus Right" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus Up" })

-- ──────────────────────────────────────────────────────────────────────
-- [T] TERMINAL (ToggleTerm)
-- ──────────────────────────────────────────────────────────────────────
map("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Terminal (Quick Toggle)" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal Float" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Terminal Horizontal" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Terminal Vertical" })

-- Terminal Mode keymaps (Sử dụng map tiện ích bên trong function)
function _G.set_terminal_keymaps()
	-- Vẫn dùng map() nhưng truyền thêm { buffer = 0 } cho file hiện tại
	map("t", "<esc>", [[<C-\><C-n>]], { buffer = 0 })
	map("t", "jk", [[<C-\><C-n>]], { buffer = 0 })
	map("t", "<C-h>", [[<C-\><C-n><C-w>h]], { buffer = 0 })
	map("t", "<C-j>", [[<C-\><C-n><C-w>j]], { buffer = 0 })
	map("t", "<C-k>", [[<C-\><C-n><C-w>k]], { buffer = 0 })
	map("t", "<C-l>", [[<C-\><C-n><C-w>l]], { buffer = 0 })
end
vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")

-- ──────────────────────────────────────────────────────────────────────
-- [L] LSP / CODE / LaTeX
-- ──────────────────────────────────────────────────────────────────────
map("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<CR>", { desc = "Definition" })
map("n", "<leader>lr", function()
	vim.lsp.buf.rename()
end, { desc = "Rename Symbol" })
map("n", "<leader>la", "<cmd>FzfLua lsp_code_actions<CR>", { desc = "Code Action" })
map("n", "<leader>lh", function()
	vim.lsp.buf.hover()
end, { desc = "Hover Info" })
map("n", "<leader>lf", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format Code" })
map("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "LSP Information" })

map("n", "<leader>Lc", "<cmd>VimtexCompile<CR>", { desc = "LaTeX Compile" })
map("n", "<leader>Lv", "<cmd>VimtexView<CR>", { desc = "LaTeX View" })

-- ──────────────────────────────────────────────────────────────────────
-- [V] VISUAL MODE
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
