
-- File: user/plugins/lsp/servers/clangd.lua
-- Purpose: Modern LSP configuration for C/C++ using clangd

local M = {}

--- Setup clangd language server for C/C++
-- @param on_attach    function to attach custom LSP behavior
-- @param capabilities LSP client capabilities (e.g., for completion)
function M.setup(on_attach, capabilities)
  local config = {
    cmd = { "clangd", "--background-index", "--clang-tidy" },
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "c", "cpp", "objc", "objcpp" },
    root_dir = vim.fs.dirname(
      vim.fs.find({ "compile_commands.json", "compile_flags.txt", ".git" }, { upward = true })[1]
    ),
  }

  -- Save config vào vim.lsp.config để có thể tái sử dụng
  vim.lsp.config.clangd = config

  -- Start clangd với config table
  vim.lsp.start(config)
end

return M
