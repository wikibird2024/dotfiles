return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    cmd = "Telescope",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    config = function()
        local telescope = require("telescope")
        local actions = require("telescope.actions")

        telescope.setup({
            defaults = {
                prompt_prefix = "   ",
                selection_caret = "❯ ",
                sorting_strategy = "ascending",
                path_display = { "smart" },

                -- Flex shifts layouts automatically when you change window dimensions or monitor setups
                layout_strategy = "flex",

                layout_config = {
                    -- Base layout dimensions across any responsive strategies
                    width = 0.90,
                    height = 0.85,
                    preview_cutoff = 1,

                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                    },
                    vertical = {
                        mirror = true,
                        prompt_position = "top",
                        preview_height = 0.50,
                    },
                    flex = {
                        flip_columns = 120, -- Snaps vertical when layout space < 120 columns
                    },
                },

                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<Esc>"] = actions.close,
                        ["<C-u>"] = false,
                        -- Continuous terminal workflow utility: scroll previews directly from input mode
                        ["<C-f>"] = actions.preview_scrolling_down,
                        ["<C-b>"] = actions.preview_scrolling_up,
                    },
                    n = {
                        ["q"] = actions.close,
                        ["<C-f>"] = actions.preview_scrolling_down,
                        ["<C-b>"] = actions.preview_scrolling_up,
                    },
                },
            },

            pickers = {
                find_files = {
                    hidden = true,
                    no_ignore = false,
                },
                buffers = {
                    sort_lastused = true,
                    ignore_current_buffer = false,
                    mappings = {
                        i = { ["<C-d>"] = actions.delete_buffer },
                        n = { ["d"] = actions.delete_buffer },
                    },
                },
                live_grep = {
                    previewer = true,
                },
                oldfiles = {
                    prompt_title = "History",
                },
            },
        })

        pcall(telescope.load_extension, "fzf")
    end,
}
