
-- Plugin: nvim-treesitter – Advanced syntax parsing and semantic highlighting
return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate", -- Auto update language parsers on install/update
    event = { "BufReadPost", "BufNewFile" }, -- Lazy load on file open/new

    config = function()
      require("nvim-treesitter.configs").setup({
        -- Language parsers to install and auto-manage
        ensure_installed = {
          "lua", "python", "c", "cpp", "bash",
          "json", "html", "css", "javascript",
          "yaml", "markdown",
        },

        -- Enable semantic syntax highlighting (Tree-sitter based)
        highlight = {
          enable = true,                         -- Use Treesitter for highlights
          additional_vim_regex_highlighting = false, -- Disable legacy regex engine
        },

        -- Enable better indentation (some languages may still need manual tweaks)
        indent = {
          enable = true,
        },

        -- Enable incremental selection (semantic visual mode, node-aware)
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",     -- Start incremental selection (like 'v' but semantic)
            node_incremental = "grn",   -- Expand to next syntax node
            node_decremental = "grm",   -- Shrink to previous node
            scope_incremental = "grc",  -- Expand to entire enclosing scope/block
          },
        },

        -- Enable textobjects (Vim-style motions like `af`, `if`, `ac`, `ic`, etc.)
        textobjects = {
          select = {
            enable = true,
            lookahead = true, -- Jump forward to the nearest matching textobject

            keymaps = {
              ["af"] = "@function.outer", -- Around function (def + body)
              ["if"] = "@function.inner", -- Inside function body
              ["ac"] = "@class.outer",    -- Around class (header + body)
              ["ic"] = "@class.inner",    -- Inside class body
              -- Extendable:
              -- ["al"] = "@loop.outer",
              -- ["il"] = "@loop.inner",
              -- ["aa"] = "@parameter.outer",
              -- ["ia"] = "@parameter.inner",
              -- ["acn"] = "@conditional.outer",
              -- ["icn"] = "@conditional.inner",
            },
          },
        },
      })
    end,
  },
}
