
-- File: user/plugins/lsp/servers/clangd.lua
-- Purpose: LSP configuration module for C/C++ using clangd

local M = {}

--- Setup clangd language server for C/C++
-- @param lspconfig - the nvim-lspconfig module
-- @param on_attach - function to attach custom LSP behavior
-- @param capabilities - LSP client capabilities (e.g., for completion)
function M.setup(lspconfig, on_attach, capabilities)
  lspconfig.clangd.setup({
    cmd = { "clangd", "--background-index", "--clang-tidy" }, -- Optional: customizable arguments
    on_attach = on_attach,
    capabilities = capabilities,
    -- filetypes = { "c", "cpp", "objc", "objcpp" }, -- Optional: specify filetypes
    -- root_dir = lspconfig.util.root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
  })
end

return M
