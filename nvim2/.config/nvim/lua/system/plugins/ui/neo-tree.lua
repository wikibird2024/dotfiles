return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  -- THAY ĐỔI QUAN TRỌNG:
  -- Vì bạn để phím tắt ở file keymap.lua riêng, hãy bỏ 'cmd = "Neotree"'
  -- và dùng 'lazy = false' kết hợp với 'priority'.
  -- Điều này đảm bảo khi bạn nhấn phím tắt, lệnh :Neotree đã tồn tại sẵn.
  lazy = false,
  priority = 1000,

  dependencies = {
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      window = {
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["v"] = "open_vsplit",
          ["s"] = "open_split",
          -- Thêm phím tắt để tránh nhầm lẫn khi thao tác
          ["P"] = { "toggle_preview", config = { use_float = true } },
        },
      },
      filesystem = {
        -- Tự động nhảy đến file đang mở trong buffer
        follow_current_file = { enabled = true },
        -- Theo dõi sự thay đổi của file hệ thống (tạo mới, xóa file)
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_dotfiles = false, -- Hiện file ẩn (.config, .env...)
          hide_gitignored = false,
        },
      },
    })
  end,
}
