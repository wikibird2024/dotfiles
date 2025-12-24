-- File: user/plugins/lsp/servers/clangd.lua
local M = {}

function M.setup(on_attach, capabilities)
  -- 1. Tìm root directory một cách an toàn
  local root_file = vim.fs.find(
    { "compile_commands.json", "compile_flags.txt", ".git" },
    { upward = true, stop = vim.uv.os_homedir() }
  )[1]

  local root_dir = root_file and vim.fs.dirname(root_file) or vim.fn.getcwd()

  local config = {
    name = "clangd", -- Tên hiển thị của server
    cmd = {
      "clangd",
      "--background-index",
      "--clang-tidy",
      "--header-insertion=iwyu", -- Gợi ý chèn header thông minh
      "--completion-style=detailed",
      "--function-arg-placeholders",
      "--fallback-style=llvm",
    },
    root_dir = root_dir,
    on_attach = on_attach,
    capabilities = capabilities,
    filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
  }

  -- 2. Lưu cấu hình để tham chiếu
  vim.lsp.config.clangd = config

  -- 3. Khởi chạy/Đính kèm server
  vim.lsp.start(config)
end

return M
