"=============================================================================
" VIM-PLUG: Plugin Manager
"=============================================================================
" Begin the plugin list, using the standard Vim directory.
call plug#begin('~/.vim/plugged')

" Core Plugins
" FZF: A command-line fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
" NERDTree: A tree explorer plugin
Plug 'preservim/nerdtree'
" vim-commentary: Easy commenting for many languages
Plug 'tpope/vim-commentary'
" vim-fugitive: A Git wrapper for Vim
Plug 'tpope/vim-fugitive'
" vim-surround: Quoting/parenthesizing made easy
Plug 'tpope/vim-surround'
" vim-gitgutter: Shows Git changes in the sign column
Plug 'airblade/vim-gitgutter'

" User Interface and Status Line
" vim-airline: A lean & mean status/tabline for Vim
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" onedark.vim: A dark color scheme
Plug 'joshdick/onedark.vim'

" Syntax and Formatting
" vim-polyglot: A collection of language packs for syntax highlighting
Plug 'sheerun/vim-polyglot'
" Coc.nvim: An intelligent completion and linting engine
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" ALE: Asynchronous Lint Engine
" Note: If you use Coc.nvim for linting, ALE may be redundant.
" Plug 'dense-analysis/ale'

" End of plugin list
call plug#end()

"=============================================================================
" General Settings
"=============================================================================
" This is not needed in modern Vim, but is included for clarity.
set nocompatible

" Essential settings for development
set number            " Show absolute line numbers
set relativenumber    " Show relative line numbers
set autoindent        " Auto-indent new lines
set shiftwidth=4      " Number of spaces for one indent
set tabstop=4         " Width of a tab character
set expandtab         " Use spaces instead of tabs
set mouse=a           " Enable mouse support in all modes

" Search and UI settings
set incsearch         " Incremental search
set ignorecase        " Ignore case in search
set smartcase         " Smart case search (case-sensitive if uppercase is used)
set hlsearch          " Highlight all search results
set fileencoding=utf-8  " Use UTF-8 file encoding
set wildmenu            " Enhanced command-line completion

" Set the leader key to space
let mapleader = ' '
let g:mapleader = ' '

" Set the color scheme after all plugins are loaded.
colorscheme onedark

"=============================================================================
" Plugin-Specific Settings
"=============================================================================
" NERDTree
" Use leader keys for easier access. Press <space> then n or f.
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>

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

" Coc.nvim
" Add your desired Coc extensions here.
let g:coc_global_extensions = ['coc-json', 'coc-pyright', 'coc-css', 'coc-tsserver']
