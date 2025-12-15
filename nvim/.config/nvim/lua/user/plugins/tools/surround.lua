-- ~/.config/nvim/lua/user/plugins/tools/surround.lua

return {
  -- Plugin: nvim-surround
  {
    "kylechui/nvim-surround",
    version = "*",
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup({
        -- Có thể thêm các cấu hình tùy chỉnh ở đây nếu bạn cần
      })
    end,
  },
}
