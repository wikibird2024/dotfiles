return {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = {
        { "<leader>ff", "<cmd>FzfLua files<CR>",     desc = "Find files" },
        { "<leader>fh", "<cmd>FzfLua oldfiles<CR>",  desc = "File history" },
        { "<leader>fb", "<cmd>FzfLua buffers<CR>",   desc = "Buffers" },
        { "<leader>fg", "<cmd>FzfLua live_grep<CR>", desc = "Live grep" },
        { "<leader>p",  "<cmd>FzfLua commands<CR>",  desc = "Command Palette" },
        {
            "<leader>f*",
            function()
                -- Select ALL results, send to quickfix, then open quicker.
                -- vim.schedule defers quicker.toggle() to next event loop tick
                -- so fzf-lua has finished writing the quickfix list (async).
                require("fzf-lua").grep_cword({
                    actions = {
                        ["default"] = {
                            fn = function(selected, opts)
                                require("fzf-lua").actions.file_sel_to_qf(selected, opts)
                                vim.schedule(function()
                                    require("quicker").toggle({ focus = false })
                                end)
                            end,
                            prefix = "select-all",
                        },
                    },
                })
            end,
            desc = "Grep cursor word → quickfix",
        },
    },
    opts = {
        winopts = {
            height  = 0.90,
            width   = 0.90,
            border  = "rounded",
            preview = {
                layout   = "vertical",
                vertical = "down:50%",
            },
        },
        files = {
            hidden     = true,
            cwd_prompt = false,
            formatter  = "path.filename_first",
        },
        grep = { hidden = true },
        actions = {
            files = {
                ["ctrl-q"] = function(selected, opts) require("fzf-lua").actions.file_sel_to_qf(selected, opts) end,
                ["alt-q"]  = function(selected, opts) require("fzf-lua").actions.file_sel_to_qf(selected, opts) end,
            },
            grep = {
                ["ctrl-q"] = function(selected, opts) require("fzf-lua").actions.file_sel_to_qf(selected, opts) end,
                ["alt-q"]  = function(selected, opts) require("fzf-lua").actions.file_sel_to_qf(selected, opts) end,
            },
        },
        keymap = {
            fzf = {
                ["ctrl-d"] = "preview-page-down",
                ["ctrl-u"] = "preview-page-up",
            },
        },
    },
    config = function(_, opts)
        require("fzf-lua").setup(opts)
    end,
}
