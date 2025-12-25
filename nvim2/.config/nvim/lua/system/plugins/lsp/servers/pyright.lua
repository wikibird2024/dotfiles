return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    vim.g._lsp_kernel_enabled = vim.g._lsp_kernel_enabled or {}
    local enabled = vim.g._lsp_kernel_enabled

    -- THAY ĐỔI Ở ĐÂY: Sửa đường dẫn cho đúng vị trí thực tế của file
    -- Nếu nó nằm trong lua/system/constitution/ thì viết:
    local on_attach = require("system.constitution.lsp_on_attach").on_attach
    local capabilities = require("system.constitution.lsp_capabilities")

    local servers = { "pyright", "clangd", "rust_analyzer" }

    for _, name in ipairs(servers) do
      if not enabled[name] then
        -- THAY ĐỔI Ở ĐÂY: Sửa đường dẫn tới các file server lẻ
        local ok, server_mod = pcall(require, "system.plugins.lsp.servers." .. name)

        if ok and type(server_mod.setup) == "function" then
          server_mod.setup(on_attach, capabilities)
        else
          vim.lsp.config[name] = {
            on_attach = on_attach,
            capabilities = capabilities,
            root_markers = { ".git" },
          }
        end

        vim.lsp.enable(name)
        enabled[name] = true
      end
    end
  end,
}
