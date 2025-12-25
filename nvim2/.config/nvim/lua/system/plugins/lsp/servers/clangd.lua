local M = {}

function M.setup(_, capabilities)
  -- ĐỊNH NGHĨA TRỰC TIẾP VÀO CORE (Không thông qua biến lspconfig trung gian)
  vim.lsp.config.clangd = {
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu",
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    -- Neovim 0.11 dùng root_markers thay cho root_pattern
    root_markers = {
      "compile_commands.json",
      "compile_flags.txt",
      ".clangd",
      ".git",
    },
    capabilities = capabilities,
  }

  -- KÍCH HOẠT
  vim.lsp.enable("clangd")
end

return M
