-- File: ~/.config/nvim/lua/system/plugins/tools/fzf.lua
return {
  "ibhagwan/fzf-lua",
  -- Load immediately when Neovim starts to keep picker availability instant
  cmd = "FzfLua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local fzf = require("fzf-lua")

    fzf.setup({
      -- Clean, floating aesthetic
      winopts = {
        height = 0.85,
        width = 0.80,
        row = 0.35,
        col = 0.50,
        preview = {
          layout = "vertical", -- Vertical layout is great for long code files
          vertical = "down:45%",
        },
      },
      keymap = {
        builtin = {
          -- Standardize scroll controls inside the preview window
          ["<C-d>"] = "preview-page-down",
          ["<C-u>"] = "preview-page-up",
        },
      },
      -- Force it to show hidden items (.dotfiles) by default, matching your preferences
      files = {
        cmd = "fd --type f --hidden --follow --exclude .git",
      },
      grep = {
        cmd = "rg --column --line-number --no-heading --color=always --smart-case --hidden",
      },
    })
  end,
}
