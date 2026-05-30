-- ~/.config/nvim/lua/system/plugins/tools/fzf.lua

return {
  "ibhagwan/fzf-lua",
  cmd = "FzfLua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },

  opts = {
    winopts = {
      height = 0.90,
      width = 0.90,

      border = "rounded",
      title = false,

      preview = {
        layout = "vertical",
        vertical = "down:50%",
      },
    },

    fzf_opts = {
      ["--layout"] = "reverse",
      ["--info"] = "inline",
    },

    files = {
      hidden = true,
      cwd_prompt = false,
    },

    grep = {
      hidden = true,
    },

    oldfiles = {
      cwd_only = true,
    },

    buffers = {
      sort_lastused = true,
      show_unloaded = false,
    },

    keymap = {
      builtin = {
        ["<C-d>"] = "preview-page-down",
        ["<C-u>"] = "preview-page-up",
      },

      fzf = {
        ["ctrl-d"] = "preview-page-down",
        ["ctrl-u"] = "preview-page-up",
      },
    },

    lsp = {
      jump1 = true,
      async_or_timeout = 3000,
    },
  },
}
