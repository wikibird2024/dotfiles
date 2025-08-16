
-- user/plugins/lsp/init.lua

return {
  -- LSP configuration using lspconfig
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lspconfig = require("lspconfig")

      -- Load shared config (capabilities & on_attach)
      local on_attach = require("user.config.lsp_on_attach").on_attach
      local capabilities = require("user.config.lsp_capabilities")

      -- List of LSP servers to set up
      local servers = {
        "pyright",
        "clangd",
        "rust_analyzer",
        -- Add more servers here
      }

      for _, server in ipairs(servers) do
        local ok, custom = pcall(require, "user.plugins.lsp.servers." .. server)

        if ok and type(custom.setup) == "function" then
          -- Use custom setup if it exists
          custom.setup(lspconfig, on_attach, capabilities)
        else
          -- Default fallback
          lspconfig[server].setup({
            on_attach = on_attach,
            capabilities = capabilities,
          })
        end
      end
    end,
  },

  -- Mason - install & manage LSP binaries
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason bridge to lspconfig
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "pyright",
          "clangd",
          "rust_analyzer",
        },
        automatic_installation = true,
      })
    end,
  },
}
