
-- ~/.config/nvim/lua/user/plugins/tools/telescope.lua

return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },

  keys = {
    { "<leader>ff", "<cmd>Telescope find_files<cr>" },
    { "<leader>fg", "<cmd>Telescope live_grep<cr>" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>" },
  },

  config = function()
    local telescope = require("telescope")
    local actions = require("telescope.actions")

    telescope.setup({
      defaults = {
        prompt_prefix     = "> ",
        selection_caret   = ">> ",
        sorting_strategy  = "descending",
        path_display      = { "truncate" },
        layout_strategy   = "horizontal",

        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width   = 0.55,
          },
        },

        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<Esc>"] = actions.close,
          },
          n = {
            ["q"] = actions.close,
          },
        },
      },

      pickers = {
        find_files = {
          theme = "dropdown",
          previewer = false,
        },
        buffers = {
          theme = "dropdown",
          sort_lastused = true,
          previewer = false,
        },
        live_grep = {
          theme = "ivy",
        },
        oldfiles = {
          theme = "dropdown",
        },
      },
    })
  end,
}
