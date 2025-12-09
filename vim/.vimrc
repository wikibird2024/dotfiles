"=============================================================================
" VIM PROFESSIONAL SETUP — GINKO EDITION
"=============================================================================
call plug#begin('~/.vim/plugged')

" ─── Essentials ───────────────────────────────────────────────────────────────
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" ─── Syntax and Linting ──────────────────────────────────────────────────────
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'

" ─── Aesthetics ───────────────────────────────────────────────────────────────
Plug 'joshdick/onedark.vim'

call plug#end()

"=============================================================================
" GENERAL SETTINGS
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
set ttyfast
set ruler
set cursorline

" Leader Key
let mapleader = ' '
let g:mapleader = ' '

" Colorscheme
colorscheme onedark

"=============================================================================
" PLUGIN-SPECIFIC SETTINGS
"=============================================================================
" NERDTree
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

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

" ALE linting indicators
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_fix_on_save = 1
