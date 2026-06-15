local M = {}

local capabilities = vim.lsp.protocol.make_client_capabilities()

-- Required for nvim-cmp snippet completion
capabilities.textDocument.completion.completionItem.snippetSupport = true

-- Required for clangd: avoids utf-8 / utf-16 encoding conflict
capabilities.offsetEncoding = { "utf-16" }

M.capabilities = capabilities
return M
