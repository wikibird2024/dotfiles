
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

      -- Keymaps using which-key (corrected spec)
      local wk_avail, wk = pcall(require, "which-key")
      if wk_avail then
        wk.add({
          { "l", group = "LaTeX", mode = "n", prefix = "" },
          { "lc", "VimtexCompile", desc = "Compile", mode = "n", prefix = "" },
          { "lv", "VimtexView", desc = "View", mode = "n", prefix = "" },
          { "ls", "VimtexStop", desc = "Stop", mode = "n", prefix = "" },
          { "lC", "VimtexClean", desc = "Clean", mode = "n", prefix = "" },
          { "le", "copen", desc = "Open Quickfix list", mode = "n", prefix = "" },
        })
      else
        -- Fallback keymaps (if which-key is not available)
        local map = vim.keymap.set
        local opts = { silent = true, noremap = true, buffer = true }
        map("n", "lc", "VimtexCompile", opts)
        map("n", "lv", "VimtexView", opts)
        map("n", "ls", "VimtexStop", opts)
        map("n", "lC", "VimtexClean", opts)
        map("n", "le", ":copen", opts)
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
    "nvim-lua/plenary.nvim",
    config = function()
      vim.api.nvim_create_autocmd("VimLeave", {
        pattern = { "*.tex" },
        callback = function()
          local build_dir = "build"
          if vim.fn.isdirectory(build_dir) == 1 then
            vim.fn.system("latexmk -c -outdir=" .. build_dir)
          end
        end,
      })
    end,
  },
}
