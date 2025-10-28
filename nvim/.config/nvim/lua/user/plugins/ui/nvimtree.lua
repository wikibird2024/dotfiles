
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Bắt buộc: tắt netrw để tránh xung đột
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    local nvim_tree = require("nvim-tree")

    nvim_tree.setup({
      sort_by = "case_sensitive",
      sync_root_with_cwd = true,
      respect_buf_cwd = true,

      view = {
        width = 32,
        side = "left",
        adaptive_size = true,
        preserve_window_proportions = true,
        signcolumn = "yes",
      },

      renderer = {
        group_empty = true,
        highlight_git = true,
        highlight_opened_files = "name",
        indent_markers = { enable = true },
        icons = {
          glyphs = {
            folder = {
              default = "",
              open = "",
              empty = "",
              empty_open = "",
            },
          },
        },
      },

      filters = {
        dotfiles = false,
        custom = { "^.git$", "node_modules" },
      },

      actions = {
        open_file = {
          quit_on_open = true, -- tự đóng tree khi mở file
          resize_window = true,
          window_picker = { enable = false },
        },
      },

      git = {
        enable = true,
        ignore = false,
        show_on_dirs = true,
        timeout = 400,
      },

      diagnostics = {
        enable = true,
        show_on_dirs = true,
        icons = {
          hint = "",
          info = "",
          warning = "",
          error = "",
        },
      },

      update_focused_file = {
        enable = true,
        update_root = true,
        update_cwd = true,
      },
    })

    ------------------------------------------------------------------
    -- 🔒 Auto close Nvim if NvimTree is last window
    ------------------------------------------------------------------
    vim.api.nvim_create_autocmd("BufEnter", {
      nested = true,
      callback = function()
        if
          #vim.api.nvim_list_wins() == 1
          and vim.bo.filetype == "NvimTree"
        then
          vim.cmd("quit")
        end
      end,
    })
  end,
}
