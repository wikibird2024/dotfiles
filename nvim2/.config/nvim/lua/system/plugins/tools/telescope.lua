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

                -- Flex natively drops to vertical if width limits are hit
                layout_strategy = "flex",

                layout_config = {
                    -- Global static baselines
                    width = 0.90,
                    height = 0.85,
                    preview_cutoff = 0, -- Prevents Telescope from dropping the preview pane entirely

                    horizontal = {
                        prompt_position = "top",
                        preview_width = 0.55,
                    },
                    vertical = {
                        mirror = true,
                        prompt_position = "top",
                        preview_height = 0.50, -- 50% of the height goes cleanly to preview
                    },
                    flex = {
                        flip_columns = 120, -- Breakpoint width for stacking
                    },
                },

                mappings = {
                    i = {
                        ["<C-j>"] = actions.move_selection_next,
                        ["<C-k>"] = actions.move_selection_previous,
                        ["<Esc>"] = actions.close,
                        ["<C-u>"] = false,
                        -- Use C-f and C-b to read up/down inside file previews without switching windows
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
                    ignore_current_buffer = true,
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
