local M = {}

M.on_attach = function(client, bufnr)
  -- Tạo Group ID duy nhất theo ID buffer
  local group_id = vim.api.nvim_create_augroup("LspKernel_" .. bufnr, { clear = true })
  local opts = { buffer = bufnr, silent = true }

  -- Keybindings
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
  vim.keymap.set("n", "K",  vim.lsp.buf.hover, opts)
  vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

  -- Formatter Election: Chỉ cho phép server uy tín format
  local allow_format = { clangd = true, rust_analyzer = true, pyright = true }

  if client.supports_method("textDocument/formatting") and allow_format[client.name] then
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = group_id,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr, async = false })
      end,
    })
  end

  -- Detach Cleanup: Giải phóng bộ nhớ khi tắt LSP
  vim.api.nvim_create_autocmd("LspDetach", {
    group = group_id,
    buffer = bufnr,
    callback = function()
      vim.api.nvim_clear_autocmds({ group = group_id, buffer = bufnr })
    end,
  })
end

return M
