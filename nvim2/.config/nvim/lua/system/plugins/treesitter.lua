
return {
    "nvim-treesitter/nvim-treesitter",
    version = false,
    build = ":TSUpdate",
    -- Use events to load only when you open a file, improving startup speed
    event = { "BufReadPost", "BufNewFile" },
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        -- Safely require the config module
        local status_ok, configs = pcall(require, "nvim-treesitter.configs")
        if not status_ok then
            vim.notify("nvim-treesitter.configs not found!", vim.log.levels.ERROR)
            return
        end

        configs.setup({
            ensure_installed = {
                "c", "cpp", "rust", "python", "lua", "vim", "vimdoc",
                "query", "cmake", "markdown", "markdown_inline", "bash",
                "json", "bibtex"
            },
            auto_install = true,
            sync_install = false,

            highlight = {
                enable = true,
                disable = function(lang, buf)
                    local max_filesize = 500 * 1024 -- 500 KB
                    local ok, stat = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
                    if ok and stat and stat.size > max_filesize then
                        return true
                    end
                end,
                additional_vim_regex_highlighting = false,
            },

            indent = { enable = true },

            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<C-space>",
                    node_incremental = "<C-space>",
                    scope_incremental = false,
                    node_decremental = "<bs>",
                },
            },

            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["ai"] = "@conditional.outer",
                        ["ii"] = "@conditional.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["as"] = "@scope.outer",
                        ["is"] = "@scope.inner",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = { ["]f"] = "@function.outer", ["]c"] = "@class.outer" },
                    goto_previous_start = { ["[f"] = "@function.outer", ["[c"] = "@class.outer" },
                },
                swap = {
                    enable = true,
                    swap_next = { ["<leader>na"] = "@parameter.inner" },
                    swap_previous = { ["<leader>pa"] = "@parameter.inner" },
                },
            },
        })
    end,
}
