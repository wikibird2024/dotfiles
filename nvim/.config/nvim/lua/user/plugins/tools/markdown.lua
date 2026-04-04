return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      -- Core safety
      enabled = true,
      max_file_size = 8.0,
      debounce = 120,
      -- Render only when thinking, not typing
      render_modes = { "n", "v" },
      -- Headings: structural, not decorative
      heading = {
        enabled = true,
        sign = false,
        icons = { "▌ ", "▌▌ ", "▌▌▌ ", "▌▌▌▌ " },
      },
      -- Code blocks: calm, readable, predictable
      code = {
        enabled = true,
        sign = false,
        style = "normal",
        position = "left",
        width = "block",
        left_pad = 0,
        right_pad = 1,
        min_width = 0,
        border = "none",
        highlight = "RenderMarkdownCode",
        highlight_inline = "RenderMarkdownCodeInline",
      },
      -- Task lists: semantic only
      checkbox = {
        enabled = true,
        unchecked = { icon = "[ ] " },
        checked   = { icon = "[x] " },
      },
      -- Lists: no noise
      bullet = {
        enabled = true,
        icons = { "•" },
      },
      -- Quotes: subtle structural marker
      quote = {
        enabled = true,
        icon = "▏",
        repeat_linebreak = false,
      },
      -- Horizontal rules: simple separator
      dash = {
        enabled = true,
        icon = "─",
        width = "full",
      },
      -- Tables: readable, no box-drawing art
      pipe_table = {
        enabled = true,
        style = "normal",
        cell = "trimmed",
      },
      -- Callouts: minimal, text-first
      callout = {
        note      = { raw = "[!NOTE]",      rendered = "NOTE:" },
        tip       = { raw = "[!TIP]",       rendered = "TIP:" },
        important = { raw = "[!IMPORTANT]", rendered = "IMPORTANT:" },
        warning   = { raw = "[!WARNING]",   rendered = "WARNING:" },
        caution   = { raw = "[!CAUTION]",   rendered = "CAUTION:" },
      },
      -- Links: no icons, no tricks
      link = {
        enabled = true,
      },
      -- No sign column pollution
      sign = {
        enabled = false,
      },
      -- Inline emphasis only
      inline = {
        enabled = true,
      },
      -- Conceal: controlled and reversible
      win_options = {
        conceallevel = {
          default = vim.api.nvim_get_option_value("conceallevel", {}),
          rendered = 2,
        },
        concealcursor = {
          default = vim.api.nvim_get_option_value("concealcursor", {}),
          rendered = "nc",
        },
      },
    },
    config = function(_, opts)
      require("render-markdown").setup(opts)
      vim.keymap.set(
        "n",
        "<leader>rm",
        "<cmd>RenderMarkdown toggle<cr>",
        { desc = "Toggle Markdown Render" }
      )
    end,
  },
}
