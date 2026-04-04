
local M = {}

function M.setup()
    local border = "single"

    local float_cfg = {
        border = border,
        max_width = 80,
        max_height = 20,
        wrap = true,
        focus_id = "lsp_float",
    }

    vim.lsp.handlers["textDocument/hover"] =
        vim.lsp.with(vim.lsp.handlers.hover, float_cfg)

    vim.lsp.handlers["textDocument/signatureHelp"] =
        vim.lsp.with(vim.lsp.handlers.signature_help, float_cfg)

    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
        float = {
            border = border,
            source = "always",
            max_width = 80,
            wrap = true,
            header = "",
            prefix = "",
        },
    })
end

return M
