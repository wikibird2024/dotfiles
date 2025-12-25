return {
  "neovim/nvim-lspconfig",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    -- 1. Lấy on_attach từ folder system/runtime của bạn
    local ok_attach, lsp_runtime = pcall(require, "system.runtime.lsp_attach")
    local my_on_attach = ok_attach and (lsp_runtime.on_attach or lsp_runtime) or nil

    -- 2. Cấu hình hiển thị lỗi (UI) theo chuẩn mới
    vim.diagnostic.config({
      virtual_text = { prefix = "●" },
      signs = true,
      underline = true,
      update_in_insert = true,
      severity_sort = true,
    })

    -- 3. Đăng ký Autocmd LspAttach để kích hoạt Keymaps/Popup
    -- Đây là cách Neovim 0.11 kết nối logic của bạn với LSP
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local bufnr = args.buf
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if my_on_attach then
          my_on_attach(client, bufnr)
        end
      end,
    })

    -- 4. Cấu hình Server theo chuẩn vim.lsp.config (Mới nhất)
    local servers = { "rust_analyzer", "clangd", "pyright" }

    for _, name in ipairs(servers) do
      -- Thiết lập cấu hình tĩnh
      vim.lsp.config[name] = {
        cmd = { name == "rust_analyzer" and "rust-analyzer" or name },
        filetypes = (name == "rust_analyzer") and { "rust" } or nil,
        root_markers = { "Cargo.toml", ".git", "pyproject.toml" },
      }

      -- Nếu là Rust, thêm cấu hình bổ sung cho Clippy
      if name == "rust_analyzer" then
        vim.lsp.config.rust_analyzer.settings = {
          ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
          }
        }
      end

      -- Kích hoạt server
      vim.lsp.enable(name)
    end
  end,
}
