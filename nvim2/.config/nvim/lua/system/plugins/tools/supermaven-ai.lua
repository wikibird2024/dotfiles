return {
  "supermaven-inc/supermaven-nvim",
  event = "InsertEnter",
  opts = {
    keymaps = {
      accept_suggestion = "<Tab>",       -- Accept inline completion
      clear_suggestion = "<C-]>",        -- Dismiss suggestion
      accept_word = "<C-Right>",         -- Accept word by word
    },
    ignore_filetypes = { cpp = true },   -- Optional: disable for specific filetypes if needed
    color = {
      suggestion_color = "#808080",      -- Muted grey ghost text color
      cterm = 244,
    },
    disable_inline_completion = false,   -- Keeps inline ghost text active
    disable_keymaps = false,
  },
}
