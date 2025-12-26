local M = {}
M.get_capabilities = function()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- Thêm hỗ trợ snippet và completion từ cmp
    local status, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
    if status then
        capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    end
    return capabilities
end
return M
