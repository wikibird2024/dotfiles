
-- ~/.config/nvim/lua/user/plugins/tools/surround.lua

return {
  {
    "kylechui/nvim-surround",
    event = "BufReadPost",
    config = function()
      require("nvim-surround").setup({

        keymaps = {
          insert = "<C-g>s",
          insert_line = "<C-g>S",
          normal = "ys",
          normal_cur = "yss",
          normal_line = "yS",
          normal_cur_line = "ySS",
          visual = "S",
          visual_line = "gS",
          delete = "ds",
          change = "cs",
        },

        surrounds = {
          ["("] = {
            add = { "( ", " )" },
            find = "%b()",
            delete = "^(.?)().-(.)()$",
          },

          ["{"] = {
            add = { "{ ", " }" },
            find = "%b{}",
            delete = "^(.?)().-(.)()$",
          },

          ["<"] = {
            add = { "<", ">" },
            find = "%b<>",
            delete = "^(.?)().-(.)()$",
          },

          ["l"] = {
            add = function()
              return { "ESP_LOGI(TAG, \"", "\");" }
            end,
          },
        },
      })
    end,
  },
}
