return {
  "nacro90/numb.nvim",
  event = "CmdlineEnter",
  config = function()
    require("numb").setup({
      show_numbers = true,
      show_cursorline = true,
    })
  end,
}

