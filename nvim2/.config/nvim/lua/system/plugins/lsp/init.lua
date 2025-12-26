return {
{
    "neovim/nvim-lspconfig",
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    config = function()
        require("system.constitution.lsp_ui").setup()
        local lspconfig = require("lspconfig")
        local caps = require("system.constitution.lsp_capabilities").get_capabilities()

        -- Danh sách server bạn muốn dùng
        local servers = { "rust_analyzer", "clangd", "pyright", "lua_ls" }

        require("mason").setup()
        require("mason-lspconfig").setup({ ensure_installed = servers })

        for _, server in ipairs(servers) do
            local opts = { capabilities = caps }
            -- Kiểm tra nếu có file config riêng trong servers/
            local has_custom_opts, custom_opts = pcall(require, "system.plugins.lsp.servers." .. server)
            if has_custom_opts then
                opts = vim.tbl_deep_extend("force", opts, custom_opts)
            end
            lspconfig[server].setup(opts)
        end
    end
}
}
