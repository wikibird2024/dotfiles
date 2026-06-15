
return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    on_attach = function(bufnr)
      local gs = require("gitsigns")
      local map = function(mode, lhs, rhs, desc)
        vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true })
      end

      -- Hunk navigation
      map("n", "]h", function()
        if vim.wo.diff then vim.cmd.normal({ "]c", bang = true })
        else gs.nav_hunk("next") end
      end, "Next Hunk")
      map("n", "[h", function()
        if vim.wo.diff then vim.cmd.normal({ "[c", bang = true })
        else gs.nav_hunk("prev") end
      end, "Prev Hunk")

      -- Actions
      map("n", "<leader>gs", gs.stage_hunk,                           "Stage Hunk")
      map("n", "<leader>gr", gs.reset_hunk,                           "Reset Hunk")
      map("v", "<leader>gs", function() gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Stage Hunk")
      map("v", "<leader>gr", function() gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") }) end, "Reset Hunk")
      map("n", "<leader>gS", gs.stage_buffer,                         "Stage Buffer")
      map("n", "<leader>gR", gs.reset_buffer,                         "Reset Buffer")
      map("n", "<leader>gu", gs.undo_stage_hunk,                      "Undo Stage Hunk")
      map("n", "<leader>gp", gs.preview_hunk,                         "Preview Hunk")
      map("n", "<leader>gb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>gd", gs.diffthis,                             "Diff This")

      -- Text object
      map({ "o", "x" }, "ih", gs.select_hunk, "Select Hunk")
    end,
  },
}
