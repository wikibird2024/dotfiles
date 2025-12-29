return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
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
        width = 28, -- Mặc định Neo-tree khá rộng, cần giới hạn lại cho gọn
        mappings = {
          ["l"] = "open",
          ["h"] = "close_node",
          ["v"] = "open_vsplit",
          ["s"] = "open_split",
          ["P"] = { "toggle_preview", config = { use_float = true } },
        },
      },
      filesystem = {
        -- Tự động highlight file đang mở (Mặc định không bật sẵn)
        follow_current_file = { enabled = true },
        -- Tự động cập nhật cây thư mục khi tạo/xóa file bên ngoài (Cần thiết)
        use_libuv_file_watcher = true,
        filtered_items = {
          -- Mặc định Neo-tree ẩn file . (dotfiles), phải bật lên mới thấy config
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            ".git", -- Folder này cực kỳ rác, ẩn đi cho chuyên nghiệp
          },
        },
      },
    })
  end,
}
