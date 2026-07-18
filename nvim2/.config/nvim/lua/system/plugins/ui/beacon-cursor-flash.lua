local ignore_filetypes = { "neo-tree", "aerial", "trouble", "lazy" }

return {
    "DanilaMihailov/beacon.nvim",
    event = "VeryLazy",
    opts = {
        width = 40,
        enabled = function()
            return not vim.list_contains(ignore_filetypes, vim.bo.filetype)
        end,
    },
}
