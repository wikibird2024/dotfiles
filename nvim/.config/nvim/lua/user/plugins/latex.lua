-- File: latex.lua (Đã tối ưu hóa Which-key và Clean-up)

return {
  -- 1. VimTeX for LaTeX editing and compilation
  {
    "lervag/vimtex",
    ft = { "tex", "bib" },
    config = function()
      -- VimTeX compiler configuration
      vim.g.vimtex_compiler_method = "latexmk"
      vim.g.vimtex_compiler_latexmk = {
        executable = "latexmk",
        options = {
          "-xelatex",
          "-shell-escape",
          "-verbose",
          "-file-line-error",
          "-synctex=1",
          "-interaction=nonstopmode",
          "-outdir=build",
        },
      }

      -- PDF viewer configuration
      vim.g.vimtex_view_method = "general"
      vim.g.vimtex_view_general_viewer = "zathura"
      vim.g.vimtex_view_general_options = "--synctex-forward %l:1:%f %p"
      vim.g.vimtex_view_forward_search_on_start = 1
      vim.g.vimtex_quickfix_mode = 2

      -- Keymaps using which-key (Dùng wk.register/wk.add với cú pháp chuẩn)
      local wk_avail, wk = pcall(require, "which-key")
      if wk_avail then
        -- Sử dụng cú pháp flat spec/wk.register mà which-key yêu cầu
        -- Lưu ý: Không cần prefix nếu bạn muốn chúng xuất hiện ngay trong menu chính (không có <leader> đi kèm)
        wk.add({
          { mode = "n", group = "LaTeX", prefix = "l" }, -- Group cho 'l'
          { "lc", "<cmd>VimtexCompile<cr>", desc = "Compile", mode = "n" },
          { "lv", "<cmd>VimtexView<cr>", desc = "View", mode = "n" },
          { "ls", "<cmd>VimtexStop<cr>", desc = "Stop", mode = "n" },
          { "lC", "<cmd>VimtexClean<cr>", desc = "Clean", mode = "n" },
          { "le", "<cmd>copen<cr>", desc = "Open Quickfix list", mode = "n" },
        }, { prefix = "<leader>" }) -- Đăng ký dưới <leader>
      else
        -- Fallback keymaps (giữ nguyên, nhưng sử dụng <cmd> thay vì ':')
        local map = vim.keymap.set
        local opts = { silent = true, noremap = true, buffer = true }
        map("n", "lc", "<cmd>VimtexCompile<cr>", opts)
        map("n", "lv", "<cmd>VimtexView<cr>", opts)
        map("n", "ls", "<cmd>VimtexStop<cr>", opts)
        map("n", "lC", "<cmd>VimtexClean<cr>", opts)
        map("n", "le", "<cmd>copen<cr>", opts)
      end
    end,
  },

  -- 2. LSP integration with Texlab
  {
    "neovim/nvim-lspconfig",
    ft = { "tex", "bib" },
    dependencies = { "hrsh7th/nvim-cmp", "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local on_attach = function(_, bufnr)
        -- Keymaps cục bộ chỉ cho buffer này (gd, ca)
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, { buffer = bufnr, desc = "Go to definition" })
        vim.keymap.set("n", "ca", vim.lsp.buf.code_action, { buffer = bufnr, desc = "Code action" })

        vim.diagnostic.config({
          virtual_text = false,
          signs = true,
          underline = true,
          update_in_insert = false,
          severity_sort = true,
          float = { source = true, focusable = false },
        }, bufnr)

        vim.api.nvim_create_autocmd("CursorHold", {
          group = vim.api.nvim_create_augroup("lsp_diagnostics_popup", { clear = true }),
          buffer = bufnr,
          callback = function()
            vim.diagnostic.open_float({ focusable = false, close_on_mouse_enter = false })
          end,
        })
      end

      lspconfig.texlab.setup({
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
          texlab = {
            build = {
              executable = "latexmk",
              args = { "-xelatex", "-biber", "-file-line-error", "%f" },
              onSave = false,
            },
            forwardSearch = {
              executable = "zathura",
              args = { "--synctex-forward", "%l:1:%f", "%p" },
            },
          },
        },
      })
    end,
  },

  -- 3. LaTeX snippets
  {
    "iurimateus/luasnip-latex-snippets.nvim",
    dependencies = { "L3MON4D3/LuaSnip" },
    ft = { "tex", "bib" },
    config = function()
      require("luasnip-latex-snippets").setup({
        enable_markdown = true,
        use_treesitter = true,
      })
    end,
  },

  -- 4. Clean auxiliary files on exit
  {
    "nvim-lua/plenary.nvim", -- Hoặc bất kỳ plugin cơ bản nào khác
    config = function()
      vim.api.nvim_create_autocmd("VimLeavePre", { -- Sử dụng VimLeavePre để đảm bảo chạy trước khi đóng
        pattern = { "*.tex" },
        callback = function()
          local build_dir = "build"
          -- Chỉ chạy latexmk -c nếu thư mục build tồn tại
          if vim.fn.isdirectory(build_dir) == 1 then
            vim.fn.system("latexmk -c -silent -outdir=" .. build_dir)
          end
        end,
      })
    end,
  },
}
