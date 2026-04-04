-- Glue layer: load constitution -> kernel -> plugins
require("system.constitution.lsp_ui")   -- UI rules & hover
require("system.kernel")                -- Core system (options, keymaps, autocmd)
require("lazy").setup("system.plugins") -- Load plugins via lazy.nvim
print("✅ System architecture loaded!")
