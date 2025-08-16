
-- File: user/plugins/lsp/servers/pyright.lua
-- Purpose: LSP configuration for Python using Pyright

local M = {}

--- Setup the Pyright language server
-- @param lspconfig     The lspconfig module
-- @param on_attach     Function that sets keymaps, etc.
-- @param capabilities  Capabilities for completion and LSP features
function M.setup(lspconfig, on_attach, capabilities)
  lspconfig.pyright.setup({
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace", -- or "openFilesOnly"
          typeCheckingMode = "basic",   -- other options: "off", "strict"
        },
      },
    },
    -- filetypes = { "python" }, -- Optional explicit filetype declaration
    -- root_dir = lspconfig.util.root_pattern("pyproject.toml", "setup.py", ".git"),
  })
end

return M
