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

-- ──────────────────────────────────────────────────────────────────────
-- [B] BUFFER (Quản lý các tệp đang mở)
-- ──────────────────────────────────────────────────────────────────────
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete Buffer" })
map("n", "<leader>ba", "<cmd>%bd|e#|bd#<CR>", { desc = "Close Other Buffers" })

-- ──────────────────────────────────────────────────────────────────────
-- [W] WINDOW & FILE OPERATIONS
-- ──────────────────────────────────────────────────────────────────────
-- Quick Save (Manual update)
map("n", "<leader>w", "<cmd>update<cr>", { desc = "Save current buffer" })

-- Window Splitting & Closing
map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Split window vertically" })
map("n", "<leader>ws", "<cmd>split<CR>", { desc = "Split window horizontally" })
map("n", "<leader>wq", "<cmd>close<CR>", { desc = "Close current window" })

-- Faster Window Navigation (Ctrl + hjkl)
-- This allows you to jump between splits without using Ctrl-w
map("n", "<C-h>", "<C-w>h", { desc = "Focus window left" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus window right" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus window up" })

-- Window Resizing (Ctrl + Arrows)
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- ──────────────────────────────────────────────────────────────────────
-- [T] TERMINAL (ToggleTerm)
-- ──────────────────────────────────────────────────────────────────────
map("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Terminal (Quick Toggle)" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal Float" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Terminal Horizontal" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Terminal Vertical" })

-- Terminal Mode keymaps (Sử dụng map tiện ích bên trong function)
function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	-- Thoát Terminal mode bằng jk (Giữ Esc để dùng cho các app bên trong Terminal)
	map("t", "jk", [[<C-\><C-n>]], opts)

	-- Điều hướng nhanh từ Terminal sang các Window khác
	map("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
	map("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
	map("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
	map("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
end

-- Dùng Lua API
vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	callback = function()
		set_terminal_keymaps()
	end,
	desc = "Set terminal-specific keymaps",
})
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
