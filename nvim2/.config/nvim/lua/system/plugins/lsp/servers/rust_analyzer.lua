-- lua/system/plugins/lsp/servers/rust_analyzer.lua
local M = {}

function M.setup(on_attach, capabilities)
  -- ĐỔI: vim.lsp.servers -> vim.lsp.config
  vim.lsp.config.rust_analyzer = {
    cmd = { "rust-analyzer" },
    filetypes = { "rust" },
    root_markers = { "Cargo.toml", ".git" },

    -- Giữ nguyên logic truyền tham số của bạn
    on_attach = on_attach,
    capabilities = capabilities,

    settings = {
      ["rust-analyzer"] = {
        checkOnSave = true,
        check = { command = "clippy" },
        cargo = {
          allFeatures = true,
        }
      },
    },
  }

  -- Kích hoạt server
  vim.lsp.enable("rust_analyzer")
end

return M
