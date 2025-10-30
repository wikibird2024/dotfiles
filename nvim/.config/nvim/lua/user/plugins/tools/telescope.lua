
-- File: ~/.config/nvim/lua/user/plugins/tools/telescope.lua
return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  config = function()
    local ok, telescope = pcall(require, "telescope")
    if not ok then
      vim.notify("Telescope not found!", vim.log.levels.WARN)
      return
    end

    local actions = require("telescope.actions")

    -- ╭────────────────────────────────────────────╮
    -- │ Telescope setup                             │
    -- ╰────────────────────────────────────────────╯
    telescope.setup({
      defaults = {
        prompt_prefix = "🔍 ",
        selection_caret = " ",
        path_display = { "smart" },
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
        layout_config = {
          horizontal = { prompt_position = "top", preview_width = 0.55 },
          vertical = { mirror = false },
        },
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-c>"] = actions.close,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },
      pickers = {
        find_files = { theme = "dropdown", previewer = true },
        buffers = { theme = "dropdown", previewer = true },
        live_grep = { theme = "ivy" },
        oldfiles = { theme = "dropdown" },
        help_tags = { theme = "dropdown" },
      },
    })

    -- Note: All keymaps for Telescope (ff, fg, fr, etc.) should be
    -- defined in core/keymaps.lua for maintainability and to avoid duplicates.
  end,
}
