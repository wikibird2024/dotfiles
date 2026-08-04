return {
    {
        "akinsho/bufferline.nvim",
        version = "*",
        event = "VeryLazy",
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },

        config = function()
            require("bufferline").setup({
                options = {
                    mode = "buffers",
                    numbers = "ordinal",

                    ------------------------------------------------------------------
                    -- Tab / Buffer Width Limits
                    ------------------------------------------------------------------
                    tab_size = 18,               -- Maximum width for each tab (adjust as needed)
                    max_name_length = 15,        -- Truncate file names past 15 characters
                    enforce_regular_tabs = true, -- Set `true` to force fixed, equal-width tabs

                    ------------------------------------------------------------------
                    -- LSP diagnostics
                    ------------------------------------------------------------------
                    diagnostics = "nvim_lsp",
                    diagnostics_update_in_insert = false,

                    diagnostics_indicator = function(count, level)
                        local icon = level:match("error") and " " or " "
                        return string.format("%s%d", icon, count)
                    end,

                    ------------------------------------------------------------------
                    -- Buffer management
                    ------------------------------------------------------------------
                    persist_buffer_sort = true,
                    sort_by = "insert_after_current",

                    max_prefix_length = 15,
                    truncate_names = true,

                    ------------------------------------------------------------------
                    -- Appearance
                    ------------------------------------------------------------------
                    separator_style = "thin",
                    always_show_bufferline = true,

                    show_tab_indicators = true,
                    show_close_icon = false,
                    show_buffer_close_icons = false,

                    hover = {
                        enabled = false,
                    },

                    ------------------------------------------------------------------
                    -- Neo-tree integration
                    ------------------------------------------------------------------
                    offsets = {
                        {
                            filetype = "neo-tree",
                            text = "Explorer",
                            text_align = "left",
                            highlight = "Directory",
                            separator = true,
                        },
                    },
                },

                highlights = {
                    buffer_selected = { bold = true, italic = false },
                    numbers_selected = { bold = true },
                    diagnostic_selected = { bold = true },
                    hint_selected = { bold = true },
                    info_selected = { bold = true },
                    warning_selected = { bold = true },
                    error_selected = { bold = true },
                },
            })
        end,
    },
}
