
-- ~/.config/nvim/lua/user/plugins/tools/telescope.lua
return {
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
}
