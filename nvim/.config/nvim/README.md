
~/.config/nvim/
├── init.lua                  <-- Entry point
├── lazy-lock.json            <-- Plugin lock file (auto-generated)
└── lua/
    └── user/
        ├── options.lua       <-- Neovim settings (set, opt)
        ├── keymaps.lua       <-- Global keymaps
        ├── colorscheme.lua   <-- Color scheme config
        ├── lsp.lua           <-- LSP settings/config
        ├── cmp.lua           <-- Completion config
        ├── telescope.lua     <-- Telescope config
        ├── treesitter.lua    <-- Treesitter config
        ├── git.lua           <-- Gitsigns config
        ├── formatter.lua     <-- Formatting tools config
        ├── terminal.lua      <-- Terminal toggle config
        ├── bufferline.lua    <-- Bufferline UI config
        ├── lualine.lua       <-- Statusline config
        ├── nvimtree.lua      <-- File explorer config
        ├── dap.lua           <-- Debug Adapter Protocol config
        ├── latex.lua         <-- LaTeX tools config
        └── plugins/          <-- 🔌 Plugin declarations only
            ├── init.lua      <-- lazy.nvim bootstrap + plugin imports
            ├── ui.lua        <-- Gruvbox, lualine, bufferline, etc.
            ├── lsp.lua       <-- nvim-lspconfig, cmp, etc.
            ├── tools.lua     <-- treesitter, terminal, formatter, dap
            ├── git.lua       <-- gitsigns, fugitive, etc.
            └── latex.lua     <-- vimtex, texlab config
