
-- ~/.config/nvim/lua/user/plugins/snippets.lua
-- Snippet engine + loader for custom snippets

return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  dependencies = {
    "rafamadriz/friendly-snippets",
  },

  config = function()
    local ls = require("luasnip")
    local loader = require("luasnip.loaders.from_lua")

    -- Enable LuaSnip keymaps (expand, jump)
    vim.keymap.set({ "i", "s" }, "<Tab>", function()
      if ls.expand_or_jumpable() then
        ls.expand_or_jump()
      else
        return "<Tab>"
      end
    end, { expr = true, silent = true })

    vim.keymap.set({ "i", "s" }, "<S-Tab>", function()
      if ls.jumpable(-1) then
        ls.jump(-1)
      end
    end, { silent = true })

    -- Load snippets in ~/.config/nvim/lua/user/plugins/snippets_data/
    loader.load({
      paths = vim.fn.stdpath("config") .. "/lua/user/plugins/snippets_data",
    })

    -- Optional: enable autosnippets
    ls.config.set_config({
      history = true,
      updateevents = "TextChanged,TextChangedI",
      enable_autosnippets = true,
    })
  end,
}
