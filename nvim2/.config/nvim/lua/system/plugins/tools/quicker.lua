return {
    "stevearc/quicker.nvim",
    event = "FileType qf",
    keys = {
        { "<leader>q", function() require("quicker").toggle() end,                    desc = "Toggle quickfix" },
        { "<leader>l", function() require("quicker").toggle({ loclist = true }) end,  desc = "Toggle loclist" },
        {
            "]q",
            function()
                local ok, err = pcall(vim.cmd, "cnext")
                if not ok and err:find("E553") then vim.cmd("cfirst") end
            end,
            desc = "Quickfix: next (wrap)",
        },
        {
            "[q",
            function()
                local ok, err = pcall(vim.cmd, "cprev")
                if not ok and err:find("E553") then vim.cmd("clast") end
            end,
            desc = "Quickfix: prev (wrap)",
        },
    },
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {
        max_height = 12,
        min_height = 6,
        follow     = { enabled = true },
        borders    = {
            vert          = "│",
            strong_header = "━",
            strong_cross  = "╋",
            strong_end    = "┫",
            soft_header   = "╌",
            soft_cross    = "╂",
            soft_end      = "┨",
        },
        type_icons = {
            E = "󰅚 ",
            W = "󰀪 ",
            I = " ",
            N = " ",
            H = " ",
        },
        highlight = {
            treesitter   = true,
            lsp          = true,
            load_buffers = false,
        },
        -- Buffer-local keys managed by quicker itself
        keys = {
            {
                ">",
                function() require("quicker").expand({ before = 2, after = 2, add_to_existing = true }) end,
                desc = "Expand context",
            },
            {
                "<",
                function() require("quicker").collapse() end,
                desc = "Collapse context",
            },
        },
    },
    config = function(_, opts)
        require("quicker").setup(opts)
    end,
}
