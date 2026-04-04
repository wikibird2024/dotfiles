
-- lua/user/plugins/snippets.lua
return {
  "L3MON4D3/LuaSnip",
  event = "InsertEnter",
  dependencies = { "rafamadriz/friendly-snippets" },

  init = function()
    -- Module-scope guard, KHÔNG dùng _G
    local loaded = false

    vim.api.nvim_create_autocmd("InsertEnter", {
      once = true,
      callback = function()
        if loaded then return end
        loaded = true

        local loader = require("luasnip.loaders.from_lua")
        loader.load({
          paths = vim.fn.stdpath("config") .. "/lua/user/plugins/snippets_data",
          include = { "rust", "c", "cpp", "python" },
        })
      end,
    })
  end,

  config = function()
    local ls = require("luasnip")

    ls.config.set_config({
      history = true,
      updateevents = "TextChangedI",
      enable_autosnippets = false,
    })
  end,
}
