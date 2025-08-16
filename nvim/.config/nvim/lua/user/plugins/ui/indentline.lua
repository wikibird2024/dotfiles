
-- Plugin: Show indentation guides with smart scope & filetype filters
return {
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufReadPre",
    config = function()
      local highlight = {
        "IndentScopeLevel1",
        "IndentScopeLevel2",
        "IndentScopeLevel3",
        "IndentScopeLevel4",
      }

      -- Optional: Setup highlight groups (with fallback if not themed)
      for i, name in ipairs(highlight) do
        vim.api.nvim_set_hl(0, name, { fg = "#555555" }) -- change color if needed
      end

      require("ibl").setup({
        indent = {
          char = "│",
          highlight = highlight,
        },
        scope = {
          enabled = true,           -- Highlight scope levels
          show_start = false,
          show_end = false,
          highlight = highlight,
        },
        exclude = {
          filetypes = {
            "help", "startify", "dashboard",
            "lazy", "neo-tree", "Trouble",
            "markdown", "text",
          },
        },
      })
    end,
  },
}
