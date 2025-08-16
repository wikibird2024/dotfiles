
-- LSP setup for rust-analyzer
local M = {}

function M.setup(lspconfig, on_attach, capabilities)
  lspconfig.rust_analyzer.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        checkOnSave = {
          command = "clippy", -- Run linter on save
        },
        cargo = {
          allFeatures = true,
        },
      },
    },
  })
end

return M
