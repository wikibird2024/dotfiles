
local M = {}

function M.setup(on_attach, capabilities)
  vim.lsp.config.clangd = {
    cmd = { "clangd", "--background-index", "--clang-tidy", "--header-insertion=iwyu" },
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
    root_markers = { "compile_commands.json", "compile_flags.txt", ".clangd", ".git" },
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

return M
