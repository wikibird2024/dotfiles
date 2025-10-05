
-- user/plugins/lsp/init.lua
-- Modern LSP configuration using Neovim's native vim.lsp.config API

return {
  -- Core LSP support
  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      -- Shared config (capabilities & on_attach)
      local on_attach = require("user.config.lsp_on_attach").on_attach
      local capabilities = require("user.config.lsp_capabilities")

      -- List of LSP servers to enable
      local servers = {
        "pyright",
        "clangd",
        "rust_analyzer",
        -- add more servers here
      }

      for _, server in ipairs(servers) do
        local ok, custom = pcall(require, "user.plugins.lsp.servers." .. server)

        if ok and type(custom.setup) == "function" then
          -- Nếu có file cấu hình riêng (custom), thì dùng nó
          custom.setup(on_attach, capabilities)
        else
          -- Dùng default setup
          vim.lsp.config[server] = {
            on_attach = on_attach,
            capabilities = capabilities,
          }
          vim.lsp.start(server)
        end
      end
    end,
  },

  -- Mason: manage LSP, DAP, Linters, Formatters binaries
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason bridge to nvim-lspconfig
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
