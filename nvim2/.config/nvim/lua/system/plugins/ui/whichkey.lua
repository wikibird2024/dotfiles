return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    delay = 300,
    win = {
      border = "rounded",
      padding = { 1, 2, 1, 2 },
    },
    icons = {
      breadcrumb = "»",
      separator = "➜",
      group = "+",
    },
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- Đăng ký các Group Name để menu hiện chữ thay vì chỉ hiện phím
  end,
}
