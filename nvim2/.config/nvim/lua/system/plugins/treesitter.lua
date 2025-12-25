-- lua/system/plugins/treesitter.lua
return {
  "nvim-treesitter/nvim-treesitter",
  -- KHÔNG dùng version = false nữa → chuyển sang branch master (ổn định hơn main ở thời điểm hiện tại)
  branch = "master",  -- hoặc bỏ dòng này nếu muốn dùng release tag mới nhất (nhưng master thường ổn)

  -- Hoặc nếu muốn lock version cụ thể (an toàn nhất):
  -- tag = "v0.9.5",  -- check github để lấy tag mới nhất nếu có

  build = ":TSUpdate",   -- vẫn giữ, rất quan trọng

  lazy = false,          -- treesitter nên load sớm

  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = {
        "c",
        "cpp",
        "rust",
        "python",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "markdown",
        "markdown_inline",
        "bash",
        "diff",
        "json",
        "jsonc",
        "yaml",
        "toml",
        -- thêm dần nếu cần
      },

      highlight = {
        enable = true,

        -- disable thông minh cho file lớn (giữ nguyên của bạn)
        disable = function(lang, buf)
          local max_filesize = 500 * 1024 -- 500 KB
          local ok, stat = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stat and stat.size > max_filesize then
            return true
          end
        end,

        additional_vim_regex_highlighting = { "markdown" },
      },

      indent = { enable = true },

      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    })
  end,
}
