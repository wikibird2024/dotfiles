
-- File: lua/user/plugins/ui/lualine.lua
-- Pro-level dynamic Lualine setup

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",

  config = function()
    local lualine = require("lualine")

    ---------------------------------------------------------------------------
    -- Utility: LSP client names
    ---------------------------------------------------------------------------
    local function lsp_clients()
      local clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
      local names = {}
      for _, c in ipairs(clients) do
        if c.name ~= "null-ls" then
          table.insert(names, c.name)
        end
      end
      return (#names > 0) and (" " .. table.concat(names, ", ")) or " Off"
    end

    ---------------------------------------------------------------------------
    -- Dynamic color function based on filetype
    ---------------------------------------------------------------------------
    local function filetype_color()
      local ft = vim.bo.filetype
      local colors = {
        python = "#ff9e64",
        lua    = "#7aa2f7",
        sh     = "#9ece6a",
        javascript = "#e0af68",
        html   = "#f7768e",
        css    = "#bb9af7",
      }
      return colors[ft] or "#a9b1d6"
    end

    ---------------------------------------------------------------------------
    -- Floating mode highlights
    ---------------------------------------------------------------------------
    local function mode_color()
      local modes = {
        n = "#f7768e", i = "#7aa2f7", v = "#9ece6a",
        V = "#9ece6a", [""] = "#9ece6a", c = "#bb9af7",
        s = "#bb9af7", S = "#bb9af7", [""] = "#bb9af7",
        R = "#ff9e64", Rv = "#ff9e64", t = "#f7768e"
      }
      return modes[vim.fn.mode()] or "#ffffff"
    end

    ---------------------------------------------------------------------------
    -- Lualine setup
    ---------------------------------------------------------------------------
    lualine.setup({
      options = {
        theme = "auto", -- auto adapts to colorscheme
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators   = { left = "", right = "" },
      },

      sections = {
        lualine_a = { { "mode", color = { fg = "#1e1e2e", bg = mode_color(), gui = "bold" }, icon = "" } },
        lualine_b = {
          { "branch", icon = "" },
          { "diff", symbols = { added = " ", modified = " ", removed = " " } },
          { "diagnostics" },
        },
        lualine_c = { { "filename", path = 1, color = { fg = filetype_color(), bg = "#1e1e2e" } } },
        lualine_x = {
          { lsp_clients, cond = function() return vim.bo.buftype == "" and vim.bo.filetype ~= "" end },
          "encoding",
          "fileformat",
          "filetype",
        },
        lualine_y = { "progress" },
        lualine_z = { { "location", icon = "" } },
      },

      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { { "filename", path = 2 } },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },

      extensions = { "nvim-tree", "quickfix", "fugitive", "lazy" },
    })
  end,
}
