
return {
  {
    "nvim-tree/nvim-tree.lua",                 -- Core plugin
    cmd = { "NvimTreeToggle", "NvimTreeFocus" }, -- Load on these commands
    dependencies = { "nvim-tree/nvim-web-devicons" }, -- Optional: file icons
    config = function()
      require("nvim-tree").setup({
        view = {
          width = 30,      -- Set sidebar width
          side = "left",   -- Position on the left side
        },
        renderer = {
          group_empty = true, -- Collapse empty folders into a single line
        },
        filters = {
          dotfiles = false,   -- Show hidden files (e.g. .gitignore)
        },
      })
    end,
  },
}
