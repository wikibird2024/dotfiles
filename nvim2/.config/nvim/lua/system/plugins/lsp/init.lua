return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- Guard: Đảm bảo chỉ khởi tạo một lần duy nhất mỗi session
    vim.g._lsp_kernel_enabled = vim.g._lsp_kernel_enabled or {}
    local enabled = vim.g._lsp_kernel_enabled

    -- Dependencies (Đảm bảo các file này tồn tại trong user/config/)
    local on_attach = require("system.runtime.lsp_on_attach").on_attach
    local capabilities = require("system.constitution.lsp_capabilities")

    local servers = { "pyright", "clangd", "rust_analyzer" }

    for _, name in ipairs(servers) do
      if not enabled[name] then
        local ok, server_mod = pcall(require, "system.plugins.lsp.servers." .. name)

        if ok and type(server_mod.setup) == "function" then
          server_mod.setup(on_attach, capabilities)
        else
          -- Fallback nếu không tìm thấy file cấu hình riêng
          vim.lsp.config[name] = {
            on_attach = on_attach,
            capabilities = capabilities,
            root_markers = { ".git" },
          }
        end

        -- Kích hoạt và đánh dấu đã enable
        vim.lsp.enable(name)
        enabled[name] = true
      end
    end
  end,
}

