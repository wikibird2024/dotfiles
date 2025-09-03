
return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPost", "BufNewFile" }, -- Lazy load on file open/new
  build = ":TSUpdate",
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },

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
        enable = true, -- Use Treesitter for highlights
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
          init_selection = "gnn",     -- Start incremental selection
          node_incremental = "grn",   -- Expand to next syntax node
          node_decremental = "grm",   -- Shrink to previous syntax node
          scope_incremental = "grc",  -- Expand to entire enclosing scope/block
        },
      },

      -- Enable textobjects (Vim-style motions like `af`, `if`, etc.)
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Jump forward to nearest matching textobject
          keymaps = {
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
            -- ["al"] = "@loop.outer",
            -- ["il"] = "@loop.inner",
            -- ["aa"] = "@parameter.outer",
            -- ["ia"] = "@parameter.inner",
          },
        },
      },
    })
  end,
}
