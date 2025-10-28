
-- ~/.config/nvim/lua/user/plugins/tools/todo.lua
return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  event = "BufReadPost",
  config = true,
}
