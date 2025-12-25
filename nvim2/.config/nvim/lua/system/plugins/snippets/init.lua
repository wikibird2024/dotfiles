
-- lua/system/plugins/snippets/init.lua
return {
  {
    "L3MON4D3/LuaSnip",
    event = "InsertEnter",
    config = function()
      local luasnip = require("luasnip")
      luasnip.config.set_config({
        history = true,
        updateevents = "TextChanged,TextChangedI",
      })

      -- Load snippets từ folder snippets_data
      require("luasnip.loaders.from_lua").lazy_load({ paths = vim.fn.stdpath("config") .. "/lua/system/plugins/snippets/snippets_data" })
    end,
  },
}
