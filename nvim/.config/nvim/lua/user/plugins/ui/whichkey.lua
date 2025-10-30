
-- ========================================================================
-- WHICH-KEY: Professional Modular Configuration (Stable for Lazy.nvim)
-- Author : Ginko
-- Purpose: Clean, Flat Syntax + Proper Window Config + LSP integration
-- ========================================================================

return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  priority = 999,
  opts = {
    plugins = {
      marks = true,
      registers = true,
      spelling = { enabled = true, suggestions = 15 },
      presets = {
        operators = false,
        motions = true,
        text_objects = true,
        windows = true,
        nav = true,
        z = true,
        g = true,
      },
    },

    -- [✔] Đổi "win" → "window" để tương thích bản chính thức
    window = {
      border = "rounded",
      position = "bottom",
      margin = { 1, 0, 1, 0 },
      padding = { 1, 2, 1, 2 },
      winblend = 10,
      zindex = 1000,
    },

    layout = {
      height = { min = 4, max = 25 },
      width = { min = 20, max = 50 },
      spacing = 4,
      align = "left",
    },

    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },

    show_help = true,
    show_keys = true,
    triggers = "auto", -- [✔] Khôi phục auto detection
    ignore_modes = { "i", "v" },
  },

  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    ----------------------------------------------------------------------
    -- 1️⃣  Core LSP bindings
    ----------------------------------------------------------------------
    vim.keymap.set("n", "<leader>lr", vim.lsp.buf.rename, { desc = "Rename Symbol" })
    vim.keymap.set("n", "<leader>la", vim.lsp.buf.code_action, { desc = "Code Action" })
    vim.keymap.set("n", "<leader>F", function() vim.lsp.buf.format({ async = true }) end,
      { desc = "Format buffer" })

    ----------------------------------------------------------------------
    -- 2️⃣  Flat Syntax Menu Registration
    ----------------------------------------------------------------------
    wk.add({
      -- Buffer
      { "<leader>b", group = "Buffer" },
      { "<leader>bd", "<cmd>bd<cr>", desc = "Delete Buffer" },
      { "<leader>bl", "<cmd>Telescope buffers<cr>", desc = "List Buffers" },
      { "<leader>bn", "<cmd>bnext<cr>", desc = "Next Buffer" },
      { "<leader>bp", "<cmd>bprevious<cr>", desc = "Previous Buffer" },

      -- File
      { "<leader>f", group = "File" },
      { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find File" },
      { "<leader>fn", "<cmd>enew<cr>", desc = "New File" },
      { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
      { "<leader>fs", "<cmd>w<cr>", desc = "Save File" },
      { "<leader>F", desc = "Format buffer", hidden = true }, -- tránh hiển thị lặp

      -- Git
      { "<leader>g", group = "Git" },
      { "<leader>gs", "<cmd>Neogit kind=split<cr>", desc = "Status" },
      { "<leader>gc", "<cmd>Git commit<cr>", desc = "Commit" },
      { "<leader>gp", "<cmd>Git push<cr>", desc = "Push" },
      { "<leader>gl", "<cmd>Git pull<cr>", desc = "Pull" },

      -- LSP
      { "<leader>l", group = "LSP" },
      { "<leader>la", desc = "Code Action" },
      { "<leader>ld", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
      { "<leader>lr", desc = "Rename Symbol" },

      -- Search
      { "<leader>s", group = "Search" },
      { "<leader>sg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
      { "<leader>sb", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer Search" },

      -- Quit
      { "<leader>q", group = "Quit" },
      { "<leader>qq", "<cmd>qa!<cr>", desc = "Quit All" },
      { "<leader>qs", "<cmd>wqa<cr>", desc = "Save & Quit" },
    })
  end,
}
