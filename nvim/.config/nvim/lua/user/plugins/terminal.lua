return {
  "akinsho/toggleterm.nvim",
  version = "*",
  event = "VeryLazy",
  config = function()
    require("toggleterm").setup({
      -- Kích thước động dựa trên hướng mở
      size = function(term)
        if term.direction == "horizontal" then
          return 15
        elseif term.direction == "vertical" then
          return vim.o.columns * 0.4
        end
      end,

      -- Giao diện & Trải nghiệm gõ
      hide_numbers = true,      -- Ẩn số dòng cho terminal sạch sẽ
      shade_terminals = true,   -- Làm tối màu nền terminal để phân biệt với code
      shading_factor = 2,       -- Độ đậm nhạt (1-3)
      start_in_insert = true,   -- Luôn vào Insert mode khi mở
      insert_mappings = true,   -- Quan trọng: cho phép phím toggle hoạt động trong Insert mode
      terminal_mappings = true, -- Quan trọng: cho phép phím toggle hoạt động trong Terminal mode
      persist_size = true,      -- Nhớ kích thước cũ
      persist_mode = false,     -- Không nhớ mode (để luôn bắt đầu bằng Insert cho tiện)
      direction = "horizontal", -- Hướng mặc định (có thể đổi thành 'float' hoặc 'vertical')
      close_on_exit = true,     -- Tự động đóng nếu lệnh chạy thành công (exit 0)
      auto_scroll = true,       -- Tự động cuộn xuống khi có output mới

      -- Cấu hình chuyên sâu cho Floating Terminal (nếu bạn dùng direction = "float")
      float_opts = {
        border = "curved",      -- Bo góc cong (curved) nhìn rất hiện đại
        winblend = 3,           -- Độ trong suốt nhẹ
        highlights = {
          border = "Normal",
          background = "Normal",
        },
      },

      -- Winbar (Thanh trạng thái nhỏ phía trên terminal - cực pro)
      winbar = {
        enabled = true,
        name_formatter = function(term)
          return " Terminal #" .. term.id
        end,
      },
    })
  end,
}
