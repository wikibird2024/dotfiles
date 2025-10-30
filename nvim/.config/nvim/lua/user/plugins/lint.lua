-- ~/.config/nvim/lua/user/plugins/lint.lua
--error check souce code.
return {
  {
    "mfussenegger/nvim-lint",
    -- The events you want to trigger linting.
    -- These are the events that will cause the plugin to load.
    event = { "BufReadPost", "BufWritePost", "InsertLeave" },
    config = function()
      local lint = require("lint")

      -- Define your linters for each filetype.
      lint.linters_by_ft = {
        python = { "flake8" },
        sh = { "shellcheck" },
        -- Add more linters as needed.
      }

      -- Create an autocommand to trigger linting.
      -- A single autocommand group is a clean way to manage this.
      vim.api.nvim_create_autocmd(
        { "BufReadPost", "BufWritePost", "InsertLeave" },
        {
          group = vim.api.nvim_create_augroup("nvim-lint-group", { clear = true }),
          callback = function()
            -- lint.try_lint() runs the linters for the current filetype.
            lint.try_lint()
          end,
        }
      )
    end,
  },
}
