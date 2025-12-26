local M = {}

function M.setup()
    local border = "rounded" -- Đổi sang rounded cho hiện đại và đồng bộ với CMP

    -- 1. Cấu hình giao diện cửa sổ nổi (Floating Windows)
    local float_cfg = {
        border = border,
        focusable = false, -- Tránh việc con trỏ nhảy vào cửa sổ hover vô ý
        style = "minimal",
    }

    vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, float_cfg)
    vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, float_cfg)

    -- 2. Định nghĩa các Icon cho lỗi (Diagnostic)
    local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = "󰋽 " }
    for type, icon in pairs(signs) do
        local hl = "DiagnosticSign" .. type
        vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
    end

    -- 3. Cấu hình cách hiển thị lỗi
    vim.diagnostic.config({
        virtual_text = {
            prefix = '●', -- Dấu chấm nhỏ cuối dòng code khi có lỗi
            spacing = 4,
        },
        signs = true,
        underline = true,
        update_in_insert = false, -- Chỉ hiện lỗi khi thoát Insert mode (giúp tập trung gõ)
        severity_sort = true,
        float = {
            border = border,
            source = "always", -- Hiện tên nguồn lỗi (ví dụ: rust-analyzer)
            header = "",
            prefix = "",
        },
    })
end

return M
