return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    -- 1. Đã thay 'window' bằng 'win'
    win = {
      border = "rounded",
    },
  },
  -- 2. Không cần thay đổi gì về mini.icons nếu bạn hài lòng với nvim-web-devicons
  -- 3. Cấu hình phím tắt theo chuẩn mới
  keys = {
    { "<leader>f", group = "File / Find / Format" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>", desc = "Grep" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent Files" },
    { "<leader>fc", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Tags" },
  },
}
