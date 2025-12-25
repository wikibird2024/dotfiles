return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = { "hrsh7th/cmp-nvim-lsp" }, -- Cần thiết để lấy capabilities
  config = function()
    -- 1. Lấy capabilities từ cmp-nvim-lsp
    -- Dòng này là "chìa khóa" để popup tự động hiện khi gõ
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    local ok_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
    if ok_cmp then
      capabilities = cmp_lsp.default_capabilities(capabilities)
    end

    -- 2. Đăng ký Autocmd LspAttach (Keymaps & UI)
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        local bufnr = args.buf

        local ok, lsp_runtime = pcall(require, "system.runtime.lsp_attach")
        if ok then
          local on_attach = lsp_runtime.on_attach or lsp_runtime
          if type(on_attach) == "function" then
            on_attach(client, bufnr)
          end
        end
      end,
    })

    -- 3. Cấu hình Diagnostic UI
    vim.diagnostic.config({
      virtual_text = { prefix = "●" },
      float = { border = "rounded", source = "always" },
      severity_sort = true,
    })

    -- 4. Danh sách Servers với Capabilities tích hợp
    local servers = {
      rust_analyzer = {
        cmd = { "rust-analyzer" },
        filetypes = { "rust" },
        root_markers = { "Cargo.toml", ".git" },
        capabilities = capabilities, -- <--- Thêm vào đây
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
          },
        },
      },
      clangd = {
        cmd = { "clangd" },
        filetypes = { "c", "cpp", "objc", "objcpp" },
        capabilities = capabilities, -- <--- Thêm vào đây
        root_markers = { ".clangd", ".git" },
      },
      pyright = {
        cmd = { "pyright-langserver", "--stdio" },
        filetypes = { "python" },
        capabilities = capabilities, -- <--- Thêm vào đây
        root_markers = { "pyproject.toml", "setup.py", ".git" },
      },
    }

    -- 5. Đăng ký và Kích hoạt (Chuẩn 0.11)
    for name, config in pairs(servers) do
      vim.lsp.config[name] = config
      vim.lsp.enable(name)
    end

    -- 6. Cấu hình thêm cho Border của Hover (K)
    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
      border = "rounded",
    })
  end,
}
