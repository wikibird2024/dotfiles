-- File: lua/user/plugins/ui/lualine.lua
-- Fully optimized dynamic status layout

return {
  "nvim-lualine/lualine.nvim",
  event = "VeryLazy",
  config = function()
    local lualine = require("lualine")

    ---------------------------------------------------------------------------
    -- Utility: High-Speed LSP Client Name Parser
    ---------------------------------------------------------------------------
    local function lsp_clients()
      local buf_clients = vim.lsp.get_clients({ bufnr = vim.api.nvim_get_current_buf() })
      if next(buf_clients) == nil then
        return "Explanation:  Off"
      end

      local names = {}
      for _, client in ipairs(buf_clients) do
        if client.name ~= "null-ls" and client.name ~= "copilot" then
          table.insert(names, client.name)
        end
      end
      return #names > 0 and (" " .. table.concat(names, ", ")) or " Off"
    end

    ---------------------------------------------------------------------------
    -- Optimized Dynamic Theme Hooks (Eliminates Evaluation Overhead)
    ---------------------------------------------------------------------------
    local mode_colors = {
      n      = "#f7768e", i      = "#7aa2f7", v      = "#9ece6a",
      V      = "#9ece6a", [""] = "#9ece6a", c      = "#bb9af7",
      s      = "#bb9af7", S      = "#bb9af7", [""] = "#bb9af7",
      R      = "#ff9e64", Rv     = "#ff9e64", t      = "#f7768e"
    }

    local filetype_colors = {
      python     = "#ff9e64",
      lua        = "#7aa2f7",
      sh         = "#9ece6a",
      c          = "#56b6c2",
      cpp        = "#51afef",
      rust       = "#de5b49",
      javascript = "#e0af68",
      html       = "#f7768e",
      css        = "#bb9af7",
    }

    ---------------------------------------------------------------------------
    -- Main Config Matrix
    ---------------------------------------------------------------------------
    lualine.setup({
      options = {
        theme = "auto",
        globalstatus = true,
        icons_enabled = true,
        component_separators = { left = "", right = "" },
        section_separators   = { left = "", right = "" },
      },
      sections = {
        lualine_a = {
          {
            "mode",
            icon = "",
            -- Fix: Wrap in a dynamic function callback evaluated safely by Lualine per frame
            color = function()
              return { bg = mode_colors[vim.fn.mode()] or "#ffffff", fg = "#1e1e2e", gui = "bold" }
            end,
          },
        },
        lualine_b = {
          { "branch", icon = "" },
          { "diff", symbols = { added = " ", modified = " ", removed = " " } },
          { "diagnostics" },
        },
        lualine_c = {
          {
            "filename",
            path = 1,
            color = function()
              return { fg = filetype_colors[vim.bo.filetype] or "#a9b1d6" }
            end,
          },
        },
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
      -- Fix: Changed out "nvim-tree" for "neo-tree" to match actual active system stack
      extensions = { "neo-tree", "quickfix", "fugitive", "lazy" },
    })
  end,
}
