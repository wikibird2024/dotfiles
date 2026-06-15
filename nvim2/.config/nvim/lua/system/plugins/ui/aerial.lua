-- File: ~/.config/nvim/lua/plugins/ui/aerial.lua
return {
    "stevearc/aerial.nvim",
    -- FIX: Use native upstream Neovim events instead of custom frameworks
    event = { "BufReadPost", "BufNewFile" },
    keys = {
        { "<leader>lo", "<cmd>AerialToggle!<CR>", desc = "Outline" },
    },
    dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons"
    },
    opts = {
        backends = { "treesitter", "lsp" },
        layout = {
            max_width = { 40, 0.2 },
            min_width = 25,
            default_direction = "right", -- Docks on the right side
        },
        show_guides = true,
    },
}
