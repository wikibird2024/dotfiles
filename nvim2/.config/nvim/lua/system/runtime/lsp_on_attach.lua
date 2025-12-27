
local M = {}

M.on_attach = function(client, bufnr)
  -- Cấu hình viền và kích thước cửa sổ
  local border_style = "single"

  -- Tạo cấu hình chung cho các cửa sổ nổi để tránh bị cắt chữ
  local float_config = {
    border = border_style,
    max_width = 80,         -- Giới hạn chiều ngang để không tràn màn hình
    max_height = 20,        -- Giới hạn chiều cao
    wrap = true,            -- QUAN TRỌNG: Tự động xuống dòng khi văn bản quá dài
    focus_id = "lsp_float",
  }

  -- Áp dụng cho Hover (Phím K)
  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
    vim.lsp.handlers.hover, float_config
  )

  -- Áp dụng cho Signature Help
  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
    vim.lsp.handlers.signature_help, float_config
  )

  -- Cấu hình Diagnostic (Bảng báo lỗi)
  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
      border = border_style,
      source = "always",
      max_width = 80,
      wrap = true, -- Tự động xuống dòng cho bảng báo lỗi
      header = "",
      prefix = "",
    },
  })

  -- ... (Phần Keybindings và Autocmd giữ nguyên bên dưới)
end

return M
