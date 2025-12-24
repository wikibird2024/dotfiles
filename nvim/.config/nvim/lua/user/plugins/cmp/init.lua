
-- Autocompletion engine setup using nvim-cmp
-- File: ~/.config/nvim/lua/user/plugins/cmp/init.lua

return {
  {
    "hrsh7th/nvim-cmp", -- Main completion engine
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- LSP source
      "hrsh7th/cmp-buffer",   -- Buffer words
      "hrsh7th/cmp-path",     -- Filesystem paths
      "L3MON4D3/LuaSnip",     -- Snippet engine (required for snippet expansion)
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      -- Load your own source configuration from a separate file
      local sources = require("user.config.cmp_sources") -- Ensure this file exists

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body) -- Expand snippet using LuaSnip
          end,
        },

        -- Key mappings for autocompletion menu
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.confirm({ select = true }), -- Confirm current item
          ["<C-Space>"] = cmp.mapping.complete(),              -- Manually trigger completion
        }),

        -- Completion sources
        sources = sources,
      })
    end,
  },
}
