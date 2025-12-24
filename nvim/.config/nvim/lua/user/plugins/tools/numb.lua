
-- ~/.config/nvim/lua/user/plugins/tools/numb.lua

return {
  "nacro90/numb.nvim",
  event = "CmdlineEnter",
  config = function()
    require("numb").setup({

      -- Không bật khi dùng macro, tránh phá flow automation
      show_numbers = true,
      show_cursorline = true,

      number_only = true,          -- Chỉ kích hoạt khi gõ số
      centered_peeking = true,     -- Preview luôn nằm giữa màn hình
      delay = 40,                  -- ms, cảm giác “tức thì” nhưng không giật

      hide_relativenumbers = true, -- Khi preview thì tắt relative number
    })
  end,
}
