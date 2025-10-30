-- File: lua/user/plugins/ui/lualine.lua
-- Plugin: nvim-lualine/lualine.nvim

return {
  "nvim-lualine/lualine.nvim",
  -- ĐÃ XÓA DÒNG DEPENDENCIES: Icon sẽ được xử lý bởi mini.icons đã cài đặt ở file init.lua
  event = "VeryLazy",

  config = function()
    ---------------------------------------------------------------------------
    -- LSP client detector (Đã Tối ưu hóa)
    ---------------------------------------------------------------------------
    -- Sử dụng cách ngắn gọn hơn để lấy tên client LSP
    local function lsp_names_for_current_buf()
      local bufnr = vim.api.nvim_get_current_buf()
      local clients = vim.lsp.get_clients({ bufnr = bufnr })
      local names = {}
      
      for _, c in ipairs(clients) do
        -- Lọc null-ls (nếu có)
        if c and c.name and c.name ~= "null-ls" then
          table.insert(names, c.name)
        end
      end
      
      -- Trả về icon  (Gear) và tên clients, hoặc " Off"
      return (#names > 0) and (" " .. table.concat(names, ", ")) or " Off"
    end

    ---------------------------------------------------------------------------
    -- Custom theme (Giữ nguyên - Đã được tùy chỉnh rất tốt)
    ---------------------------------------------------------------------------
    local custom_theme = {
      normal = {
        a = { fg = "#282828", bg = "#fabd2f", gui = "bold" }, -- bright yellow
        b = { fg = "#ebdbb2", bg = "#d65d0e" },               -- orange
        c = { fg = "#ebdbb2", bg = "#3c3836" },               -- subtle dark
      },
      insert = {
        a = { fg = "#282828", bg = "#3fdcee", gui = "bold" }, -- vivid cyan
        b = { fg = "#282828", bg = "#3fdcee" },
        c = { fg = "#282828", bg = "#3fdcee" },
      },
      visual = {
        a = { fg = "#282828", bg = "#d3869b", gui = "bold" }, -- purple
        b = { fg = "#282828", bg = "#d3869b" },
        c = { fg = "#282828", bg = "#d3869b" },
      },
      replace = {
        a = { fg = "#282828", bg = "#fb4934", gui = "bold" }, -- hot red
        b = { fg = "#282828", bg = "#fb4934" },
        c = { fg = "#282828", bg = "#fb4934" },
      },
      command = {
        a = { fg = "#282828", bg = "#b8bb26", gui = "bold" }, -- neon green
        b = { fg = "#282828", bg = "#b8bb26" },
        c = { fg = "#282828", bg = "#b8bb26" },
      },
      inactive = {
        a = { fg = "#a89984", bg = "#3c3836", gui = "bold" },
        b = { fg = "#a89984", bg = "#3c3836" },
        c = { fg = "#a89984", bg = "#3c3836" },
      },
    }

    ---------------------------------------------------------------------------
    -- Setup (Giữ nguyên cấu trúc)
    ---------------------------------------------------------------------------
    require("lualine").setup({
      options = {
        theme = custom_theme,
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators   = { left = "", right = "" },
      },

      sections = {
        lualine_a = { { "mode", icon = "" } },
        lualine_b = {
          { "branch", icon = "" },
          { "diff", symbols = { added = " ", modified = " ", removed = " " } },
          { "diagnostics" },
        },
        lualine_c = {
          { "filename", path = 1, symbols = { modified = "●", readonly = "" } },
        },
        lualine_x = {
          -- Sử dụng hàm LSP đã tối ưu
          { lsp_names_for_current_buf, cond = function() return vim.bo.buftype == "" and vim.bo.filetype ~= "" end },
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { { "location", icon = "" } },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 0 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },

      extensions = { "nvim-tree", "quickfix", "fugitive", "lazy" },
    })
  end,
}
