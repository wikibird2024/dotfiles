-- File: lua/user/config/lsp_on_attach.lua (FIXED: Đảm bảo LHS không rỗng)

local M = {}

M.on_attach = function(client, bufnr)
  -- Hàm trợ giúp để thiết lập keymap cục bộ cho buffer
  local function bufmap(mode, lhs, rhs, opts)
    -- ✅ KIỂM TRA AN TOÀN: Đảm bảo phím ánh xạ (lhs) không rỗng
    if lhs and lhs ~= "" then
      local keymap_opts = vim.tbl_extend("force", { noremap = true, silent = true }, opts or {})
      vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, keymap_opts)
    end
  end

  -- ===================================================
  -- Ánh xạ LSP cơ bản (Global cho tất cả LSP buffers)
  -- ===================================================
  bufmap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", { desc = "Go to Definition" })
  bufmap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", { desc = "Hover Documentation" })
  
  -- Ánh xạ các keymap LSP bổ sung (Nếu bạn muốn thêm, hãy đảm bảo phím tắt không rỗng)
  bufmap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { desc = "Go to Declaration" })
  bufmap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", { desc = "Go to Implementation" })
  bufmap("n", "gr", "<cmd>Telescope lsp_references<CR>", { desc = "Show References" })
  bufmap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", { desc = "Rename" })
  bufmap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", { desc = "Code Action" })
  bufmap("n", "<leader>D", "<cmd>Telescope lsp_document_symbols<CR>", { desc = "Document Symbols" })
  bufmap("n", "<leader>W", "<cmd>Telescope lsp_workspace_symbols<CR>", { desc = "Workspace Symbols" })
end

return M
