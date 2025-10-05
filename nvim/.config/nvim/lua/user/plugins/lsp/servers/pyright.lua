-- File: user/plugins/lsp/servers/pyright.lua
-- Purpose: LSP configuration for Python using Pyright (modern Neovim API)

local M = {}

--- Setup the Pyright language server
-- @param on_attach     Function that sets keymaps, etc.
-- @param capabilities  Capabilities for completion and LSP features
function M.setup(on_attach, capabilities)
  local config = {
    name = "pyright",
    cmd = { "pyright-langserver", "--stdio" },
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
      python = {
        analysis = {
          autoSearchPaths = true,
          useLibraryCodeForTypes = true,
          diagnosticMode = "workspace", -- or "openFilesOnly"
          typeCheckingMode = "basic",   -- "off" | "basic" | "strict"
        },
      },
    },
    -- filetypes = { "python" },
    -- root_dir = vim.fs.dirname(vim.fs.find({ "pyproject.toml", "setup.py", ".git" }, { upward = true })[1]),
  }

  vim.lsp.config.pyright = config
  vim.lsp.start(config)
end

return M

