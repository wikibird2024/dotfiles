" ============================================================================
" 1. TỰ ĐỘNG CÀI ĐẶT VIM-PLUG
" ============================================================================
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    if executable('curl')
        silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

" ============================================================================
" 2. DANH SÁCH PLUGIN (Tổng hợp: Ổn định & Thông minh)
" ============================================================================
call plug#begin('~/.vim/plugged')

" Giao diện & Tiện ích hệ thống
Plug 'morhetz/gruvbox'          " Màu sắc chuyên nghiệp
Plug 'preservim/nerdtree'        " Cây thư mục
Plug 'vim-airline/vim-airline'  " Thanh trạng thái
Plug 'ctrlpvim/ctrlp.vim'        " Tìm file nhanh (Ctrl + p)
Plug 'tpope/vim-commentary'      " Comment nhanh (gcc)
Plug 'sheerun/vim-polyglot'      " Syntax highlight đa ngôn ngữ

" Tính năng thông minh từ Neovim (Nhưng nhẹ & ổn định cho Vim)
Plug 'jiangmiao/auto-pairs'       " Tự đóng ngoặc, nhảy qua dấu đóng, Smart Enter
Plug 'dense-analysis/ale'         " Báo lỗi cú pháp (Linter) ngay khi đang gõ
Plug 'easymotion/vim-easymotion' " Nhảy cực nhanh đến mọi vị trí trên màn hình

call plug#end()

" ============================================================================
" 3. CẤU HÌNH CƠ BẢN (Tối ưu Code)
" ============================================================================
syntax on
filetype plugin indent on
set number relativenumber
set mouse=a
set cursorline
set tabstop=4 shiftwidth=4 expandtab smartindent
set ignorecase smartcase
set noswapfile undofile         " Lưu lịch sử undo ngay cả khi đóng file
set encoding=utf-8
set hidden
set hlsearch incsearch showmatch
set clipboard=unnamedplus       " Đồng bộ clipboard hệ thống

" ============================================================================
" 4. CẤU HÌNH TÍNH NĂNG THÔNG MINH
" ============================================================================

" --- Auto-pairs (Tự động đóng ngoặc & Xuống dòng thông minh) ---
let g:AutoPairsMapCR = 1        " Nhấn Enter giữa {} sẽ tự xuống dòng thụt lề
let g:AutoPairsShortcutToggle = '' " Tắt phím tắt không cần thiết

" --- ALE (Báo lỗi ngay khi gõ - Thay thế LSP nặng nề) ---
let g:ale_linters = {'javascript': ['eslint'], 'python': ['flake8'], 'cpp': ['gcc']}
let g:ale_sign_error = '●'
let g:ale_sign_warning = '○'
let g:ale_fix_on_save = 1

" --- Giao diện ---
set background=dark
silent! colorscheme gruvbox
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Đổi hình dạng con trỏ
if &term =~ '256color' || &term =~ 'xterm'
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[1 q"
endif

" ============================================================================
" 5. PHÍM TẮT THÔNG MINH (UNIFIED KEYMAPS)
" ============================================================================
let mapleader = " "

" --- Thoát nhanh (Normal, Insert & Terminal) ---
inoremap jk <Esc>
inoremap kj <Esc>
nnoremap <silent> <leader><leader> :noh<CR>

if has('nvim')
    tnoremap jk <C-\><C-n>
else
    tnoremap jk <C-w>N
endif

" --- Điều hướng Insert Mode (Tính năng bạn muốn) ---
inoremap <C-l> <Right>
inoremap <C-e> <Esc>A

" --- Di chuyển cửa sổ Split (Đồng bộ Code và Terminal) ---
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" --- Duyệt File & Buffer ---
function! ToggleExplorer()
    if exists(':NERDTreeToggle') | exec 'NERDTreeToggle' | else | exec 'Lexplore' | endif
endfunction
nnoremap <leader>e :call ToggleExplorer()<CR>
nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap <leader>bd :bdelete<CR>

" --- Quản lý Terminal ---
if has('nvim')
    nnoremap <leader>t :botright split +terminal | resize 10<CR>
else
    nnoremap <leader>t :botright terminal ++rows=10<CR>
endif

" --- Tiện ích hỗ trợ Code ---
nnoremap <leader>i gg=G''
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv

" Nhảy nhanh đến từ bất kỳ đâu (EasyMotion)
nmap s <Plug>(easymotion-s2)

" ============================================================================
" 6. TỰ ĐỘNG HÓA
" ============================================================================
if has('nvim')
    autocmd TermOpen * setlocal nonumber norelativenumber | startinsert
else
    autocmd TerminalOpen * setlocal nonumber norelativenumber | startinsert
endif

" Tự động lưu file khi rời cửa sổ
autocmd BufLeave,FocusLost * silent! wa
