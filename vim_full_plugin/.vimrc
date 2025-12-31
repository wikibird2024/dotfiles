"=============================================================================
" VIM PROFESSIONAL SETUP — GINKO PRO EDITION
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

" ─── Themes (Thêm Everforest vào để đổi gió) ──────────────────────────────────
Plug 'joshdick/onedark.vim'
Plug 'sainnhe/everforest'

" ─── Syntax and Linting ──────────────────────────────────────────────────────
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'

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
set termguicolors

" Leader Key (Space)
let mapleader = " "

" Colorscheme mặc định
colorscheme onedark

"=============================================================================
" PRO KEYBINDINGS (THỰC DỤNG & TỐC ĐỘ)
"=============================================================================

" --- 1. File & Explorer (Dùng Space + phím chữ cho nhanh) ---
" Mở cây thư mục (E = Explorer)
nnoremap <leader>e :NERDTreeToggle<CR>
" Tìm file hiện tại trong cây thư mục
nnoremap <leader>n :NERDTreeFind<CR>

" --- 2. Tìm kiếm (FZF) ---
" Tìm file nhanh (F = Find)
nnoremap <leader>f :Files<CR>
" Tìm chữ trong toàn bộ project (G = Grep)
nnoremap <leader>g :Rg<CR>
" Danh sách các file đang mở (B = Buffers)
nnoremap <leader>b :Buffers<CR>

" --- 3. Lưu & Thoát (W = Write, Q = Quit) ---
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
" Thoát nhanh không lưu
nnoremap <leader>Q :q!<CR>

" --- 4. Chỉnh sửa cực nhanh ---
" Tắt Highlight sau khi search xong (NH = No Highlight)
nnoremap <leader>nh :nohlsearch<CR>
" Reload lại file config sau khi sửa
nnoremap <leader>v :source $MYVIMRC<CR>

" --- 5. Đổi Theme nhanh (T = Theme) ---
nnoremap <leader>t :colorscheme everforest<CR>:let g:airline_theme='everforest'<CR>:AirlineTheme everforest<CR>
nnoremap <leader>T :colorscheme onedark<CR>:let g:airline_theme='onedark'<CR>:AirlineTheme onedark<CR>

"=============================================================================
" PLUGIN-SPECIFIC SETTINGS
"=============================================================================
" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'

" GitGutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'

" ALE
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_fix_on_save = 1
