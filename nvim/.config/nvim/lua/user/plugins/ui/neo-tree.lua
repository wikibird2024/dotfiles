
-- lua/ui/neo-tree.lua
-- Neo-tree configuration (no keymaps included)
-- Author: Ginko

return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- optional, for icons
    "MunifTanjim/nui.nvim",
  },

  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,

      filesystem = {
        filtered_items = {
          visible = false, -- Set to true to show hidden files by default
          hide_dotfiles = false,
          hide_gitignored = true,
        },
        follow_current_file = { enabled = true },
        group_empty_dirs = true,
        use_libuv_file_watcher = true,
      },

      buffers = {
        follow_current_file = { enabled = true },
        group_empty_dirs = true,
        show_unloaded = true,
      },

      git_status = {
        window = { position = "float" },
      },

      default_component_configs = {
        indent = {
          with_markers = true,
          with_expanders = true,
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "ﰊ",
          default = "",
        },
        name = { trailing_slash = true },
        modified = { symbol = "" },
        git_status = {
          symbols = {
            added     = "",
            modified  = "",
            deleted   = "",
            renamed   = "",
            untracked = "★",
            ignored   = "◌",
            unstaged  = "✗",
            staged    = "✓",
            conflict  = "",
          },
        },
      },
    })
  end,
}
