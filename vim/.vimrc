
"=============================================================================
" VIM-PLUG: Plugin Manager
"=============================================================================
call plug#begin('~/.vim/plugged')

" The Essentials
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax and Formatting
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'

" Aesthetics
Plug 'joshdick/onedark.vim'

call plug#end()

"=============================================================================
" General Settings
"=============================================================================
set nocompatible
set number relativenumber
set autoindent
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
syntax on
filetype plugin indent on

" Set leader key to space
let mapleader = ' '
let g:mapleader = ' '

" Recommended to set a color scheme after plugin-manager setup
colorscheme onedark

"=============================================================================
" Plugin-Specific Settings
"=============================================================================
" NERDTree
nnoremap <leader>tn :NERDTreeToggle<CR>
nnoremap <leader>tf :NERDTreeFind<CR>

" FZF
nnoremap <C-p> :Files<CR>
nnoremap <C-g> :Rg<CR>

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'

" GitGutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'
