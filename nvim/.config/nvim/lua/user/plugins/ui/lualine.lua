
-- Plugin: Statusline with rich mode, diagnostics, LSP, and file info
return {
  "nvim-lualine/lualine.nvim",

  -- Optional dependency: filetype icons
  dependencies = {
    "nvim-tree/nvim-web-devicons", -- Icons for file types
  },

  -- Load plugin lazily after UI is ready
  event = "VeryLazy",

  config = function()
    require("lualine").setup({
      options = {
        theme = "auto",              -- Automatically match current colorscheme
        globalstatus = true,        -- Single statusline across splits
        icons_enabled = true,       -- Enable file and mode icons

        -- Define separators between components and sections
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },

        -- Disable lualine for specific filetypes if needed
        disabled_filetypes = {
          statusline = {},          -- No specific exclusions
          winbar = {},              -- Winbar not used
        },
      },

      -- Active buffer layout
      sections = {
        lualine_a = { { "mode", icon = "" } }, -- Current mode (e.g., NORMAL)
        lualine_b = { "branch", "diff", "diagnostics" }, -- Git + diagnostics

        lualine_c = {
          {
            "filename", -- Display filename with path
            path = 1,   -- 0 = just name, 1 = relative, 2 = absolute
            symbols = {
              modified = "●",      -- Show when buffer is modified
              readonly = "",      -- Show if file is readonly
              unnamed = "[No Name]", -- If no file name is set
            },
          },
        },

        lualine_x = {
          {
            -- Custom component: show active LSP clients
            function()
              local clients = vim.lsp.get_clients({ bufnr = 0 })
              if #clients == 0 then return "LSP: Off" end
              local names = {}
              for _, c in ipairs(clients) do
                if c.name ~= "null-ls" then -- Filter out null-ls
                  table.insert(names, c.name)
                end
              end
              return "LSP: " .. table.concat(names, ", ")
            end,
            icon = "", -- Gear icon for LSP
            cond = function()
              return vim.bo.filetype ~= "" and vim.bo.buftype == "" -- Only on normal buffers
            end,
          },
          "encoding",    -- File encoding (e.g., UTF-8)
          "fileformat",  -- Line endings (unix, dos)
          "filetype",    -- Filetype (e.g., lua, python)
        },

        lualine_y = { "progress" }, -- File progress: % through file
        lualine_z = {
          { "location", icon = "" }, -- Cursor position: line:column
        },
      },

      -- Inactive window layout (minimal)
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "filename",
            path = 0, -- Show just the filename
            symbols = {
              modified = "●",
              readonly = "",
              unnamed = "[No Name]",
            },
          },
        },
        lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },

      -- Load extra integrations for specific plugins
      extensions = {
        "nvim-tree",    -- Support for file tree panel
        "quickfix",     -- Show info when quickfix list is active
        "fugitive",     -- Git integration support
      },
    })
  end,
}
