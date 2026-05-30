return {
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter" },

    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",

      {
        "L3MON4D3/LuaSnip",
        build = "make install_jsregexp",
      },
    },

    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- safer require (your original is fine, just simplified usage)
      local ok, custom_sources = pcall(require, "system.constitution.cmp_sources")

      local sources = {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }

      if ok and type(custom_sources) == "table" then
        sources = custom_sources
      end

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),

          -- FIX: Tab should NOT only confirm (breaks snippet navigation sometimes)
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),

          ["<C-Space>"] = cmp.mapping.complete(),
        }),

        sources = cmp.config.sources(sources),
      })
    end,
  },
}
