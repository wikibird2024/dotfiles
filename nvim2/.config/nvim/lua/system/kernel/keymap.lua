local map = require("system.utils").map

-- ─────────────────────────────────────────────────────
-- 1. GLOBAL SETTINGS
-- ─────────────────────────────────────────────────────
vim.g.mapleader = " "
vim.opt.timeoutlen = 500

-- ─────────────────────────────────────────────────────
-- 2. INSERT MODE (minimal, safe)
-- ─────────────────────────────────────────────────────
map("i", "<A-q>", "<Esc>", { desc = "Exit Insert Mode" })
map("i", "<A-l>", "<Right>", { desc = "Move Right" })
map("i", "<C-l>", "<Right>", { desc = "Move Right" })
map("i", "<A-e>", "<Esc>A", { desc = "End of Line" })

-- ─────────────────────────────────────────────────────
-- 3. BUFFER NAVIGATION (IDE-like but clean)
-- ─────────────────────────────────────────────────────
map("n", "[b", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
map("n", "]b", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<leader>bd", "<cmd>bdelete<CR>", { desc = "Delete Buffer" })

map("n", "<Tab>", "<cmd>bnext<CR>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })

-- ─────────────────────────────────────────────────────
-- 4. WINDOW MANAGEMENT (clean split model)
-- ─────────────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", { desc = "Left Window" })
map("n", "<C-j>", "<C-w>j", { desc = "Down Window" })
map("n", "<C-k>", "<C-w>k", { desc = "Up Window" })
map("n", "<C-l>", "<C-w>l", { desc = "Right Window" })

map("n", "<C-Up>", "<cmd>resize +2<CR>", { desc = "Resize Up" })
map("n", "<C-Down>", "<cmd>resize -2<CR>", { desc = "Resize Down" })
map("n", "<C-Left>", "<cmd>vertical resize -2<CR>", { desc = "Resize Left" })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize Right" })

map("n", "<leader>|", "<cmd>vsplit<CR>", { desc = "Vertical Split" })
map("n", "<leader>-", "<cmd>split<CR>", { desc = "Horizontal Split" })

-- ─────────────────────────────────────────────────────
-- 5. FIND / SEARCH
-- ─────────────────────────────────────────────────────
map("n", "<leader>ff", "<cmd>FzfLua files<CR>", { desc = "Find Files" })
map("n", "<leader>fg", "<cmd>FzfLua live_grep<CR>", { desc = "Live Grep" })
map("n", "<leader>fh", "<cmd>FzfLua oldfiles<CR>", { desc = "History" })
map("n", "<leader>fb", "<cmd>FzfLua buffers<CR>", { desc = "Buffers" })

-- ─────────────────────────────────────────────────────
-- 6. EXPLORER
-- ─────────────────────────────────────────────────────
map("n", "<leader>e", "<cmd>Neotree toggle<CR>", { desc = "Explorer Toggle" })
map("n", "<leader>o", "<cmd>Neotree focus<CR>", { desc = "Explorer Focus" })
map("n", "<leader>r", "<cmd>Neotree reveal<CR>", { desc = "Reveal File" })

-- ─────────────────────────────────────────────────────
-- 7. DEBUG (DAP)
-- ─────────────────────────────────────────────────────
map("n", "<leader>dc", function()
	require("dap").continue()
end, { desc = "Continue" })
map("n", "<leader>ds", function()
	require("dap").step_over()
end, { desc = "Step Over" })
map("n", "<leader>di", function()
	require("dap").step_into()
end, { desc = "Step Into" })
map("n", "<leader>db", function()
	require("dap").toggle_breakpoint()
end, { desc = "Breakpoint" })
map("n", "<leader>du", function()
	require("dapui").toggle()
end, { desc = "DAP UI" })
map("n", "<leader>dr", function()
	require("dap").restart()
end, { desc = "Restart" })

-- ─────────────────────────────────────────────────────
-- 8. TERMINAL
-- ─────────────────────────────────────────────────────
map("n", "<leader>t", "<cmd>ToggleTerm<CR>", { desc = "Terminal" })
map("n", "<leader>tf", "<cmd>ToggleTerm direction=float<CR>", { desc = "Float Terminal" })
map("n", "<leader>th", "<cmd>ToggleTerm direction=horizontal<CR>", { desc = "Horizontal Terminal" })
map("n", "<leader>tv", "<cmd>ToggleTerm direction=vertical<CR>", { desc = "Vertical Terminal" })

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
	callback = set_terminal_keymaps,
	desc = "Terminal Keymaps",
})

-- ─────────────────────────────────────────────────────
-- 9. LSP (VIM CORE + MODERN UX)
-- ─────────────────────────────────────────────────────

-- Core Vim LSP standard (professional baseline)
map("n", "gd", "<cmd>FzfLua lsp_definitions<CR>", { desc = "Definition" })
map("n", "gr", "<cmd>FzfLua lsp_references<CR>", { desc = "References" })
map("n", "gi", "<cmd>FzfLua lsp_implementations<CR>", { desc = "Implementation" })
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" })

map("n", "[d", vim.diagnostic.goto_prev, { desc = "Prev Diagnostic" })
map("n", "]d", vim.diagnostic.goto_next, { desc = "Next Diagnostic" })

-- Extended LSP actions (leader-based)
map("n", "<leader>la", "<cmd>FzfLua lsp_code_actions<CR>", { desc = "Code Action" })
map("n", "<leader>ld", "<cmd>FzfLua lsp_definitions<CR>", { desc = "Definition (leader)" })
map("n", "<leader>lr", function()
	vim.lsp.buf.rename()
end, { desc = "Rename" })
map("n", "<leader>lf", function()
	vim.lsp.buf.format({ async = true })
end, { desc = "Format" })
map("n", "<leader>li", "<cmd>LspInfo<CR>", { desc = "LSP Info" })

map("n", "<leader>lo", "<cmd>AerialToggle!<CR>", { desc = "Outline" })

map("n", "<leader>Lc", "<cmd>VimtexCompile<CR>", { desc = "LaTeX Compile" })
map("n", "<leader>Lv", "<cmd>VimtexView<CR>", { desc = "LaTeX View" })

-- ─────────────────────────────────────────────────────
-- 10. VISUAL MODE
-- ─────────────────────────────────────────────────────
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Down" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Up" })
map("v", "<", "<gv", { desc = "Indent Left" })
map("v", ">", ">gv", { desc = "Indent Right" })

-- ─────────────────────────────────────────────────────
-- 11. CLIPBOARD
-- ─────────────────────────────────────────────────────
map({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank Clipboard" })
map("n", "<leader>yp", [["+p]], { desc = "Paste Clipboard" })

-- ─────────────────────────────────────────────────────
-- 12. VS CODE COMPATIBILITY (MINIMAL SAFE LAYER)
-- ─────────────────────────────────────────────────────
map("n", "<C-p>", "<cmd>FzfLua files<CR>", { desc = "Quick Open" })
map("n", "<C-b>", "<cmd>Neotree toggle<CR>", { desc = "Explorer Toggle" })

map("n", "<leader>p", "<cmd>FzfLua commands<CR>", { desc = "Command Palette" })
map("n", "<leader>sg", "<cmd>FzfLua live_grep<CR>", { desc = "Search Project" })

map("n", "<A-Left>", "<C-o>", { desc = "Jump Back" })
map("n", "<A-Right>", "<C-i>", { desc = "Jump Forward" })
