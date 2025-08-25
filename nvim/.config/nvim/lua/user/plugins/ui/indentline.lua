-- lua/user/ui/indentline.lua
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    -- Load the plugin before reading the buffer content
    event = "BufReadPre",
    config = function()
      local ibl = require("ibl") -- Indent Blankline module

      -- 1. Define highlight groups for static Indent Lines (Subtle contrast)
      local indent_highlights = { "IndentLevel1", "IndentLevel2" }
      -- Define 2 colors for alternating effect: one darker, one lighter.
      local indent_colors = { "#555555", "#AAAAAA" } 
      
      -- Apply colors to the defined highlight groups
      for i, hl in ipairs(indent_highlights) do
        vim.api.nvim_set_hl(0, hl, { fg = indent_colors[i], nocombine = true })
      end

      -- 2. Define highlight group for the active Scope Line (Prominent accent color)
      local scope_highlight = "CurrentScopeHighlight"
      -- Accent color (e.g., bright green, blue, or yellow) for the current block
      vim.api.nvim_set_hl(0, scope_highlight, { fg = "#00BFFF", nocombine = true }) 

      ibl.setup({
        indent = {
          -- Character used for indent lines
          char = "│",
          tab_char = "│",
          -- Use the two contrasting colors for alternation
          highlight = indent_highlights, 
          -- Cap lines at the start of next line/end of current block
          smart_indent_cap = true,
        },
        scope = {
          enabled = true,
          show_start = true,
          show_end = true,
          -- Use the single, prominent accent color for the active scope line
          highlight = scope_highlight, 
        },
        exclude = {
          -- Filetypes where indent lines should be disabled (e.g., utility/docs windows)
          filetypes = {
            "help", "startify", "dashboard",
            "lazy", "neo-tree", "Trouble",
            "markdown", "text",
            "gitcommit", "diff",
          },
        },
      })
    end,
  },
}
