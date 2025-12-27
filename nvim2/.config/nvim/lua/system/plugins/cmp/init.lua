return {
  {
    "hrsh7th/nvim-cmp",
    -- CRITICAL: This tells Lazy to load cmp the moment you start typing
    event = { "InsertEnter", "CmdlineEnter" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      {
        "L3MON4D3/LuaSnip",
        -- Fixes the jsregexp warning from your healthcheck
        build = "make install_jsregexp",
      },
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Attempt to load your custom sources file
      local ok, custom_sources = pcall(require, "system.constitution.cmp_sources")

      local sources = ok and custom_sources or {
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "buffer" },
        { name = "path" },
      }

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-j>"] = cmp.mapping.select_next_item(),
          ["<C-k>"] = cmp.mapping.select_prev_item(),
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
        sources = cmp.config.sources(sources),
      })
    end,
  },
}
