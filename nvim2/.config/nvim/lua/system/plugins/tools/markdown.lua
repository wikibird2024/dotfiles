return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown", "codecompanion" }, -- Thêm codecompanion nếu bạn dùng AI
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" },
  opts = {
    -- Core performance & safety
    enabled = true,
    max_file_size = 10.0,
    debounce = 100,
    -- Modes where rendering is active (keeps Insert mode clean)
    render_modes = { "n", "v", "c" },
    -- Headings: distinctive but clean
    heading = {
      enabled = true,
      sign = false,
      position = "overlay",
      icons = { "󰲡 ", "󰲣 ", "󰲥 ", "󰲧 ", "󰲩 ", "󰲫 " },
      signs = { "󰫎 " },
    },
    -- Code blocks: Professional look
    code = {
      enabled = true,
      sign = false,
      style = "language",
      position = "left",
      width = "block",
      left_pad = 2,
      right_pad = 2,
      border = "thin",
    },
    -- Task lists
    checkbox = {
      enabled = true,
      unchecked = { icon = "󰄱 " },
      checked   = { icon = "󰄵 " },
    },
    -- Bullets
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
      left_pad = 0,
      right_pad = 1,
    },
    -- Tables: Grid style
    pipe_table = {
      enabled = true,
      preset = "round",
      style = "full",
      cell = "trimmed",
    },
    -- Callouts (GitHub style)
    callout = {
      note      = { raw = "[!NOTE]",      rendered = "󰋽 Note",     highlight = "RenderMarkdownInfo" },
      tip       = { raw = "[!TIP]",       rendered = "󰌶 Tip",      highlight = "RenderMarkdownSuccess" },
      important = { raw = "[!IMPORTANT]", rendered = "󰅚 Important", highlight = "RenderMarkdownError" },
      warning   = { raw = "[!WARNING]",   rendered = "󰀪 Warning",   highlight = "RenderMarkdownWarn" },
      caution   = { raw = "[!CAUTION]",   rendered = "󰳦 Caution",   highlight = "RenderMarkdownError" },
    },
    -- Integration with Neovim UI
    win_options = {
      conceallevel = { default = 0, rendered = 2 },
      concealcursor = { default = "", rendered = "nc" },
    },
  },
  config = function(_, opts)
    require("render-markdown").setup(opts)
    -- Keymap to toggle rendering
    vim.keymap.set("n", "<leader>tm", "<cmd>RenderMarkdown toggle<cr>", { desc = "Toggle Markdown Render" })
  end,
}
