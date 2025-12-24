local M = {}

function M.setup(on_attach, capabilities)
  vim.lsp.config.rust_analyzer = {
    cmd = { "rust-analyzer" }, -- Đảm bảo đã cài qua Mason hoặc hệ thống
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", "rust-project.json" },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        checkOnSave = { command = "clippy" },
        procMacro = { enable = true },
      },
    },
  }
end

return M
