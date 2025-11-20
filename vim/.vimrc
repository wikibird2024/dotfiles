
"=============================================================================
" VIM-PLUG: Plugin Manager
"=============================================================================
call plug#begin('~/.vim/plugged')

" Core Tools
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" UI / Statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" LSP / IntelliSense
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Colors
Plug 'joshdick/onedark.vim'

call plug#end()

"=============================================================================
" General Settings
"=============================================================================
set number relativenumber
set autoindent
set smartindent
set shiftwidth=4
set tabstop=4
set expandtab
set mouse=a
set incsearch
set ignorecase
set smartcase
set hlsearch
set fileencoding=utf-8
set wildmenu
set clipboard=unnamedplus
set ttyfast
syntax on
filetype plugin indent on

" Leader Key
let mapleader = " "

" Theme
colorscheme onedark

"=============================================================================
" Optimizations
"=============================================================================
set lazyredraw
set shortmess+=c
set updatetime=300
set synmaxcol=300

"=============================================================================
" Keymaps (Two-Layer Neovim Style)
"=============================================================================

"======================================
" FILE GROUP: <leader>f
"======================================
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fr :Rg<CR>
nnoremap <leader>fb :Buffers<CR>

"======================================
" TREE GROUP: <leader>t
"======================================
nnoremap <leader>te :NERDTreeToggle<CR>
nnoremap <leader>tf :NERDTreeFind<CR>

"======================================
" GIT GROUP: <leader>g
"======================================
nnoremap <leader>gs :Git<CR>
nnoremap <leader>gb :Git blame<CR>

"======================================
" LSP / COC GROUP: <leader>l
"======================================
nmap <leader>ld <Plug>(coc-definition)
nmap <leader>lr <Plug>(coc-references)
nmap <leader>li <Plug>(coc-implementation)
nnoremap <leader>lf :call CocAction('format')<CR>

"======================================
" SYSTEM GROUP: <leader>s
"======================================
nnoremap <leader>sw :w<CR>
nnoremap <leader>sq :q<CR>

"======================================
" TOGGLE GROUP: <leader>o
"======================================
nnoremap <leader>oh :set hlsearch!<CR>
nnoremap <leader>on :set relativenumber!<CR>

"=============================================================================
" Airline
"=============================================================================
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'

"=============================================================================
" GitGutter
"=============================================================================
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'

"=============================================================================
" Coc (LSP, Completion, Diagnostics)
"=============================================================================
set completeopt=menu,menuone,noselect

inoremap <silent><expr> <TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <leader>fm :call CocAction('format')<CR>

"=============================================================================
" Filetype-Specific Tweaks
"=============================================================================
autocmd FileType c,cpp,h setlocal shiftwidth=4 tabstop=4 expandtab
autocmd FileType python setlocal shiftwidth=4 tabstop=4 expandtab
