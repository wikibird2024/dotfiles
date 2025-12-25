return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "FzfLua", -- Chỉ load khi gọi lệnh FzfLua
  opts = {
    -- Cấu hình giao diện popup
    winopts = {
      height = 0.85,
      width  = 0.80,
      border = "rounded",
    },
    files = {
      formatter = "path.filename_first", -- Hiện tên file trước, đường dẫn sau
    },
  },
  config = function(_, opts)
    require("fzf-lua").setup(opts)
  end,
}
