
-- Plugin Group: Developer Tools
-- File: ~/.config/nvim/lua/user/plugins/tools/init.lua

return {
  -- 🔍 Telescope: Highly extendable fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    cmd = "Telescope",
    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix = "🔍 ",
          selection_caret = " ",
          path_display = { "smart" },
        },
        pickers = {
          find_files = { theme = "dropdown", previewer = true },
          buffers = { theme = "dropdown", previewer = true },
        },
      })
    end,
  },

  -- ✅ todo-comments.nvim
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    event = "BufReadPost",
    config = true,
  },

  -- 🔢 numb.nvim: Highlight line when jumping to a line via :<number>
  {
    "nacro90/numb.nvim",
    event = "CmdlineEnter",
    config = function()
      require("numb").setup({
        show_numbers = true,    -- highlight the number being typed
        show_cursorline = true, -- highlight the line
      })
    end,
  },
}
