return {
  "kevinhwang91/nvim-bqf",
  lazy = false, -- Changed from ft = "qf" to guarantee it catches Fzf-Lua outputs
  opts = {
    preview = {
      border = "rounded",
      win_height = 14,
    },
  },
} -- Added this missing closing brace
