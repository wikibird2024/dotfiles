-- ~/.config/nvim/lua/system/plugins/tools/fzf.lua

return {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = {
        winopts = {
            height = 0.90,
            width = 0.90,
            border = "rounded",
            preview = {
                layout = "vertical",
                vertical = "down:50%",
            },
        },
        files = {
            hidden = true,
            cwd_prompt = false,
            formatter = "path.filename_first",
        },
        grep = {
            hidden = true,
        },

        -- THE FOOLPROOF SOLUTION: Pass safe functional wrappers to standard actions
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
        -- Keep it clean: directly parse options table into setup
        require("fzf-lua").setup(opts)
    end,
}
