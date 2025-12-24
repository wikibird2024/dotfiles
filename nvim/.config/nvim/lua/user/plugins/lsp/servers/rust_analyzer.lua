local M = {}

function M.setup(on_attach, capabilities)
  -- Chỉ bật rust-analyzer nếu có Cargo.toml
  if vim.fn.filereadable("Cargo.toml") == 1 then

    -- Use the new native Neovim 0.11 API
    vim.lsp.config("rust_analyzer", {
      on_attach = on_attach,
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          cargo = { allFeatures = true },
          checkOnSave = { command = "clippy" },
        },
      },
    })

    -- Start/Enable the config
    vim.lsp.enable("rust_analyzer")
  end
end

return M
