
-- LSP setup for rust-analyzer
local M = {}

function M.setup(lspconfig, on_attach, capabilities)
  -- Chỉ bật rust-analyzer nếu có Cargo.toml trong thư mục hiện tại
  if vim.fn.filereadable("Cargo.toml") == 1 then
    lspconfig.rust_analyzer.setup({
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          cargo = { allFeatures = true },
          checkOnSave = { command = "clippy" }, -- chạy linter khi save
        },
      },
    })
  end
end

return M
