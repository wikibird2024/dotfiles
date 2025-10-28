
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  dependencies = { "nvim-tree/nvim-web-devicons" },

  config = function()
    local nvim_tree = require("nvim-tree")
    local api = require("nvim-tree.api")

    -- 🧠 Setup
    nvim_tree.setup({
      sort_by = "case_sensitive",
      view = {
        width = 32,
        side = "left",
        preserve_window_proportions = true,
        signcolumn = "yes",
      },
      renderer = {
        group_empty = true,
        highlight_git = true,
        highlight_opened_files = "name",
        indent_markers = { enable = true },
        icons = {
          show = {
            file = true,
            folder = true,
            folder_arrow = true,
            git = true,
          },
        },
      },
      filters = {
        dotfiles = false,
        custom = { "^.git$", "node_modules", "dist" },
      },
      actions = {
        open_file = {
          quit_on_open = false,          -- ✅ giữ tree khi mở file
          resize_window = true,
          window_picker = { enable = false },
        },
      },
      git = {
        enable = true,
        ignore = false,
        show_on_dirs = true,
      },
      update_focused_file = {
        enable = true,                  -- ✅ tự highlight file đang mở
        update_cwd = true,
      },
      tab = {
        sync = { open = true, close = true },
      },
      diagnostics = {
        enable = true,
        show_on_dirs = false,
      },
    })

    -- 🧩 Auto mở Tree khi vào Neovim
    vim.api.nvim_create_autocmd("VimEnter", {
      callback = function(data)
        -- Nếu mở file, chỉ mở tree 1 lần
        if vim.fn.isdirectory(data.file) == 1 then
          vim.cmd.cd(data.file)
          api.tree.open()
        else
          api.tree.open()
        end
      end,
    })

    -- ⚙️ Keymaps chuyên nghiệp (Tree toggle & focus)
    local opts = { noremap = true, silent = true }
    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", opts)  -- Bật/tắt tree
    vim.keymap.set("n", "<leader>o", "<cmd>NvimTreeFocus<CR>", opts)   -- Nhảy focus sang tree
  end,
}
