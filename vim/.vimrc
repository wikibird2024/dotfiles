" ============================================================================
" Plugin Manager - vim-plug
" ============================================================================
call plug#begin('~/.vim/plugged')

" FZF and a modern file explorer
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'

" Code completion and Language Server Protocol
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'dense-analysis/ale'

" Git integration
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-rhubarb'

" Syntax and Indentation
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-sleuth' " Smart indentation

" Text editing helpers
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-abolish' " Search, substitute, and abbreviations for vim.

" User interface
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'joshdick/onedark.vim'

" Telescope is a great alternative to fzf for Neovim users
" Plug 'nvim-telescope/telescope.nvim'
" Plug 'nvim-lua/plenary.nvim'

call plug#end()

" ============================================================================
" General Settings
" ============================================================================
set nocompatible
set encoding=utf-8
set mouse=a
set number relativenumber
set clipboard=unnamedplus " Use system clipboard as default
set autoindent
set shiftwidth=4
set tabstop=4
set expandtab
set fileencoding=utf-8
set wildmenu

" Searching
set incsearch
set ignorecase
set smartcase
set hlsearch
nnoremap <leader>c :nohlsearch<CR>

" Leader key
let mapleader = ' '

" Recommended to set a color scheme after plugin-manager setup
colorscheme onedark

" ============================================================================
" Plugin-Specific Configurations
" ============================================================================
" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'
let g:airline#extensions#tabline#enabled = 1

" BẮT ĐẦU: Các cấu hình Tùy chỉnh Nâng cao (THÊM VÀO ĐÂY)
" -----------------------------------------------------

" Hiển thị thông tin Git và Linter/ALE
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#fugitiveline#enabled = 1
let g:airline#extensions#ale#enabled = 1

" Hiển thị các Buffer đang mở trên Tabline
let g:airline#extensions#tabline#buffer_idx_mode = 1

" Tùy chỉnh Các Section (Phần)
let g:airline_section_y = '%3l:%c'
let g:airline_section_z = '%P'

" Tùy chỉnh Giao diện: Mức độ tương phản
let g:airline_inactive_mode_disable_mode = 1

" KẾT THÚC: Các cấu hình Tùy chỉnh Nâng cao
" FZF mappings
nnoremap <leader>f :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>s :Tags<CR>
nnoremap <leader>g :Rg<CR>

" NERDTree mappings
nnoremap <leader>n :NERDTreeToggle<CR>
nnoremap <leader>e :NERDTreeFind<CR>

" coc.nvim
" In this advanced setup, we will configure Coc extensions separately.
" The user must run `:CocInstall` manually for each language they need.
" Example: :CocInstall coc-pyright coc-tsserver

" ============================================================================
" Autocommands
" ============================================================================
" Automatically remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

" ============================================================================
" Custom Functions
" ============================================================================
" Define a custom function to toggle paste mode easily
function! PasteToggle()
  if &paste
    set nopaste
    echo "Paste mode disabled"
  else
    set paste
    echo "Paste mode enabled"
  endif
endfunction
map <leader>p :call PasteToggle()<CR>
