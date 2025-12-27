
local M = {}

function M.setup(on_attach, capabilities)
  vim.lsp.config.rust_analyzer = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", "rust-project.json" },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      ["rust-analyzer"] = {
        cargo = { allFeatures = true },
        -- Fix: checkOnSave must be a boolean
        checkOnSave = true,
        -- Fix: Move the command configuration here
        check = {
          command = "clippy",
        },
        procMacro = { enable = true },
      },
    },
  }
end

return M
