-- Call function fron utils modul
local map = require("system.utils").map

-- ─────────────────────────────────────────────────────
-- 1. GLOBAL SETTINGS
-- ─────────────────────────────────────────────────────
vim.g.mapleader = " "
vim.opt.timeoutlen = 500

-- ─────────────────────────────────────────────────────
-- [HUB] COMMAND DISPATCHER
-- ─────────────────────────────────────────────────────
map("n", "<leader><leader>", "<nop>", { desc = "Command Hub" })
map("n", "<leader><leader>h", "<cmd>noh<CR>", { desc = "Clear Highlight" })
map("n", "<leader><leader>f", "<cmd>FzfLua files<CR>", { desc = "Hub: Find Files" })
map("n", "<leader><leader>b", "<cmd>FzfLua buffers<CR>", { desc = "Hub: Buffers" })
map("n", "<leader><leader>l", "<cmd>FzfLua lsp_document_symbols<CR>", { desc = "Hub: LSP Symbols" })
map("n", "<leader><leader>t", "<cmd>ToggleTerm<CR>", { desc = "Hub: Terminal" })

-- ─────────────────────────────────────────────────────
-- [I] INSERT MODE
-- ─────────────────────────────────────────────────────
map("i", "<A-q>", "<Esc>", { desc = "Exit Insert Mode" })
map("i", "<A-l>", "<Right>", { desc = "Move Right" })
map("i", "<A-e>", "<Esc>A", { desc = "Jump to End of Line" })

-- ─────────────────────────────────────────────────────
-- [E] EXPLORER (Neo-tree)
-- ─────────────────────────────────────────────────────
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Explorer Toggle" })
map("n", "<leader>o", "<cmd>Neotree focus<CR>", { desc = "Explorer Focus" })
map("n", "<leader>r", "<cmd>Neotree reveal<CR>", { desc = "Reveal Current File" })

-- ─────────────────────────────────────────────────────
-- [F] FIND / SEARCH (Fzf-lua)
-- ─────────────────────────────────────────────────────
map("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "Live Grep" })
map("n", "<leader>fh", "<cmd>FzfLua oldfiles<CR>", { desc = "History" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Search Buffers" })

-- ─────────────────────────────────────────────────────
-- [B] BUFFERS
-- ─────────────────────────────────────────────────────
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete Buffer" })
map(
	"n",
	"<leader>ba",
	"<cmd>bufdo if buflisted(bufnr('%')) && bufnr('%') != bufnr('#') | silent! bdelete | endif<CR>",
	{ desc = "Close Other Buffers (safe)" }
)

-- ─────────────────────────────────────────────────────
-- [W] WINDOWS
-- ─────────────────────────────────────────────────────
map("n", "<leader>ww", "<cmd>update<cr>", { desc = "Save Buffer" })
map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Vertical Split" })
map("n", "<leader>ws", "<cmd>split<CR>", { desc = "Horizontal Split" })
map("n", "<leader>wq", "<cmd>close<CR>", { desc = "Close Window" })

map("n", "<C-h>", "<C-w>h", { desc = "Focus Left" })
map("n", "<C-j>", "<C-w>j", { desc = "Focus Down" })
map("n", "<C-k>", "<C-w>k", { desc = "Focus Up" })
map("n", "<C-l>", "<C-w>l", { desc = "Focus Right" })

map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Width" })

-- ─────────────────────────────────────────────────────
-- [T] TERMINAL (ToggleTerm)
-- ─────────────────────────────────────────────────────
map("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Toggle Terminal" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Terminal Float" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Terminal Horizontal" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Terminal Vertical" })

function _G.set_terminal_keymaps()
	local opts = { buffer = 0 }
	map("t", "<Esc><Esc>", [[<C-\><C-n>]], opts)
	map("t", "<C-h>", [[<C-\><C-n><C-w>h]], opts)
	map("t", "<C-j>", [[<C-\><C-n><C-w>j]], opts)
	map("t", "<C-k>", [[<C-\><C-n><C-w>k]], opts)
	map("t", "<C-l>", [[<C-\><C-n><C-w>l]], opts)
end

vim.api.nvim_create_autocmd("TermOpen", {
	pattern = "term://*",
	callback = function()
		set_terminal_keymaps()
	end,
	desc = "Terminal keymaps",
})

-- ─────────────────────────────────────────────────────
-- [L] LSP / LaTeX
-- ─────────────────────────────────────────────────────
map("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<CR>", { desc = "Definition" })
map("n", "<leader>lr", function()
	vim.lsp.buf.rename()
end, { desc = "Rename" })
map("n", "<leader>la", "<cmd>FzfLua lsp_code_actions<CR>", { desc = "Code Action" })
map("n", "<leader>lh", function()
	vim.lsp.buf.hover()
end, { desc = "Hover" })
map("n", "<leader>lf", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format" })
map("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "LSP Info" })

map("n", "<leader>Lc", "<cmd>VimtexCompile<CR>", { desc = "LaTeX Compile" })
map("n", "<leader>Lv", "<cmd>VimtexView<CR>", { desc = "LaTeX View" })

-- ─────────────────────────────────────────────────────
-- [V] VISUAL
-- ─────────────────────────────────────────────────────
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Up" })
map("v", "<", "<gv", { desc = "Indent Left" })
map("v", ">", ">gv", { desc = "Indent Right" })

-- ─────────────────────────────────────────────────────
-- [Y] CLIPBOARD
-- ─────────────────────────────────────────────────────
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank to Clipboard" })
map("n", "<leader>yp", [["+p]], { desc = "Paste from Clipboard" })
