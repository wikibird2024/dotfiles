local map = require("system.utils").map

-- ─────────────────────────────────────────────────────
-- 1. BUFFER NAVIGATION
-- ─────────────────────────────────────────────────────
map("n", "[b",      "<cmd>bprevious<CR>", { desc = "Prev Buffer" })
map("n", "]b",      "<cmd>bnext<CR>",     { desc = "Next Buffer" })
map("n", "<Tab>",   "<cmd>bnext<CR>",     { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<CR>", { desc = "Prev Buffer" })

-- Smart buffer delete: switch away first so the window stays open
map("n", "<leader>bd", function()
	local bufs = vim.fn.getbufinfo({ buflisted = 1 })
	if #bufs > 1 then vim.cmd("bprevious") end
	vim.cmd("bdelete #")
end, { desc = "Delete Buffer" })

-- ─────────────────────────────────────────────────────
-- 2. WINDOW MANAGEMENT
-- ─────────────────────────────────────────────────────
map("n", "<C-h>", "<C-w>h", { desc = "Left Window"  })
map("n", "<C-j>", "<C-w>j", { desc = "Down Window"  })
map("n", "<C-k>", "<C-w>k", { desc = "Up Window"    })
map("n", "<C-l>", "<C-w>l", { desc = "Right Window" })

map("n", "<C-Up>",    "<cmd>resize +2<CR>",          { desc = "Resize Up"    })
map("n", "<C-Down>",  "<cmd>resize -2<CR>",          { desc = "Resize Down"  })
map("n", "<C-Left>",  "<cmd>vertical resize -2<CR>", { desc = "Resize Left"  })
map("n", "<C-Right>", "<cmd>vertical resize +2<CR>", { desc = "Resize Right" })

map("n", "<leader>|",  "<cmd>vsplit<CR>", { desc = "Vertical Split"       })
map("n", "<leader>-",  "<cmd>split<CR>",  { desc = "Horizontal Split"     })
map("n", "<leader>wv", "<cmd>vsplit<CR>", { desc = "Vertical Split"       })
map("n", "<leader>wh", "<cmd>split<CR>",  { desc = "Horizontal Split"     })
map("n", "<leader>wq", "<cmd>close<CR>",  { desc = "Close Window"         })
map("n", "<leader>wo", "<cmd>only<CR>",   { desc = "Close Other Windows"  })
map("n", "<leader>w=", "<C-w>=",          { desc = "Equal Window Sizes"   })

-- ─────────────────────────────────────────────────────
-- 3. SEARCH
-- ─────────────────────────────────────────────────────
map("n", "<Esc>", "<cmd>nohlsearch<CR><Esc>", { desc = "Clear Highlights" })

-- ─────────────────────────────────────────────────────
-- 4. VISUAL MODE
-- ─────────────────────────────────────────────────────
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "Move Down"   })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "Move Up"     })
map("v", "<", "<gv",               { desc = "Indent Left" })
map("v", ">", ">gv",               { desc = "Indent Right"})

-- ─────────────────────────────────────────────────────
-- 5. CLIPBOARD
-- ─────────────────────────────────────────────────────
map({ "n", "v" }, "<leader>y",  [["+y]], { desc = "Yank to Clipboard"   })
map("n",          "<leader>yp", [["+p]], { desc = "Paste from Clipboard" })

-- ─────────────────────────────────────────────────────
-- 6. INSERT MODE
-- ─────────────────────────────────────────────────────
map("i", "<A-e>", "<Esc>A", { desc = "End of Line" })

-- ─────────────────────────────────────────────────────
-- 7. TOGGLES
-- ─────────────────────────────────────────────────────
map("n", "<leader>us", function()
	vim.opt.spell = not vim.opt.spell:get()
	vim.notify("Spell check: " .. (vim.opt.spell:get() and "ON" or "OFF"))
end, { desc = "Toggle Spell Check" })
