return {
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",
      "onsails/lspkind.nvim", -- Thêm cái này để có icon đẹp trong popup
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      local lspkind = require("lspkind")

      cmp.setup({
        -- 1. Cải thiện giao diện popup (Bo góc cho chuyên nghiệp)
        window = {
          completion = cmp.config.window.rounded(),
          documentation = cmp.config.window.rounded(),
        },

        -- 2. Hành vi hiện popup
        completion = {
          -- Tự động hiện popup khi gõ (Default là 0ms, rất nhanh)
          completeopt = "menu,menuone,noinsert",
        },

        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },

        -- 3. Tối ưu Mapping
        mapping = cmp.mapping.preset.insert({
          ["<Tab>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
          ["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
          -- Cuộn tài liệu bên trong popup nếu nó quá dài
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        }),

        -- 4. Định dạng hiển thị (Icon + Loại biến/hàm)
        formatting = {
          format = lspkind.cmp_format({
            mode = 'symbol_text',
            maxwidth = 50,
            ellipsis_char = '...',
          })
        },

        sources = cmp.config.sources({
          { name = "nvim_lsp", priority = 1000 }, -- Ưu tiên gợi ý từ Code (LSP)
          { name = "luasnip", priority = 750 },
          { name = "buffer", priority = 500, keyword_length = 3 },
          { name = "path", priority = 250 },
        }),
      })
    end,
  },
}
