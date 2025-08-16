
-- user/plugins/terminal.lua
return {
  {
    "akinsho/toggleterm.nvim",
    version = "*",
    keys = { [[<C-\>]] },
    config = function()
      require("toggleterm").setup()
    end,
  },
}
