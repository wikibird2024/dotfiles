
-- Plugin Group: Developer Tools
-- File: ~/.config/nvim/lua/user/plugins/tools/init.lua

return {
  -- 🔍 Telescope: Highly extendable fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Required utility library for Telescope
    cmd = "Telescope",                          -- Lazy-load Telescope when :Telescope is executed
    config = function()
      require("telescope").setup({
        defaults = {
          prompt_prefix = "🔍 ",                 -- Prefix symbol for prompt
          selection_caret = " ",               -- Symbol used to mark the selected item
          path_display = { "smart" },           -- Display paths smartly (truncate as needed)
        },
        pickers = {
          -- Configure the built-in file picker to use the dropdown theme (compact UI)
          find_files = {
            theme = "dropdown",                 -- Use dropdown theme for file finder
            previewer = true,                  -- Disable preview window (optional)
          },
          -- Configure buffer switcher with same theme
          buffers = {
            theme = "dropdown",
            previewer = true,
          },
        },
      })
    end,
  },

  -- ✅ todo-comments.nvim: Highlight and search TODO, FIX, NOTE, etc. in code comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Depends on plenary for async utilities
    event = "BufReadPost",                      -- Load after a file is read into buffer
    config = true,                              -- Use default configuration
  },
}
