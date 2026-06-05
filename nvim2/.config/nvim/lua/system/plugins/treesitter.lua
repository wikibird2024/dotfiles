return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  branch = "main", -- Ensure you lock onto the newest default branch
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  dependencies = {
    "nvim-treesitter/nvim-treesitter-textobjects",
  },
  config = function()
    -- 1. Setup declarative parser installations using the modern API standard
    local configs = require("nvim-treesitter.config")
    local installed = configs.get_installed()

    local ensure_installed = {
      "c", "cpp", "rust", "python", "lua", "vim", "vimdoc",
      "query", "cmake", "markdown", "markdown_inline", "bash",
      "json", "bibtex"
    }

    local to_install = vim.iter(ensure_installed):filter(function(p)
      return not vim.tbl_contains(installed, p)
    end):totable()

    if #to_install > 0 then
      require("nvim-treesitter").install(to_install)
    end

    -- 2. Configure native features & limits on buffer attachment
    vim.api.nvim_create_autocmd("FileType", {
      callback = function(args)
        -- File size cap optimization (500 KB)
        local max_filesize = 500 * 1024
        local ok, stat = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(args.buf))
        if ok and stat and stat.size > max_filesize then
          return
        end

        -- Native Highlighting & Indentation
        pcall(vim.treesitter.start)
        vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end,
    })

    -- 3. Incremental Selection configuration mapping via native APIs
    vim.keymap.set("n", "<C-space>", function() require("nvim-treesitter.incremental_selection").init_selection() end, { silent = true })
    vim.keymap.set("x", "<C-space>", function() require("nvim-treesitter.incremental_selection").node_incremental() end, { silent = true })
    vim.keymap.set("x", "<bs>", function() require("nvim-treesitter.incremental_selection").node_decremental() end, { silent = true })

    -- 4. Pass downstream settings safely to your textobjects dependency
    -- (Textobjects still uses standard plugin structures, initialized directly)
    require("nvim-treesitter").setup({
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
