local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Hỗ trợ cho nvim-cmp (completion)
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Quan trọng cho Clangd: Tránh xung đột encoding giữa utf-8 và utf-16
capabilities.offsetEncoding = { "utf-16" }

M.capabilities = capabilities
return M
