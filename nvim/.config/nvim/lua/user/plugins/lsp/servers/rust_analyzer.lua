local M = {}

function M.setup(on_attach, capabilities)
  -- Sử dụng API native của Neovim 0.11
  vim.lsp.config("rust_analyzer", {
    -- Tự động nhận diện gốc dự án (chuẩn hơn việc dùng vim.fn.filereadable)
    root_dir = vim.fs.root(0, { "Cargo.toml", "rust-project.json" }),

    on_attach = on_attach,
    capabilities = capabilities,

    settings = {
      ["rust-analyzer"] = {
        -- Giải quyết lỗi: expected a boolean
        checkOnSave = true,

        -- Cấu hình clippy chuyên sâu (nếu muốn)
        check = {
          command = "clippy",
          extraArgs = { "--no-deps" },
        },

        cargo = {
          allFeatures = true,
          loadOutDirsFromCheck = true,
        },
        procMacro = {
          enable = true,
        },
      },
    },
  })

  -- Kích hoạt server
  vim.lsp.enable("rust_analyzer")
end

return M
