" ============================================================================
" TỰ ĐỘNG CÀI ĐẶT VIM-PLUG (AUTO-INSTALL)
" ============================================================================
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" ============================================================================
" DANH SÁCH PLUGIN
" ============================================================================
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'          " Màu sắc chuyên nghiệp
Plug 'preservim/nerdtree'       " Cây thư mục (Space + n)
Plug 'vim-airline/vim-airline'  " Thanh trạng thái
Plug 'ctrlpvim/ctrlp.vim'       " Tìm file nhanh (Ctrl + p)
Plug 'tpope/vim-commentary'     " Comment nhanh (gcc)
Plug 'sheerun/vim-polyglot'     " Hỗ trợ mọi ngôn ngữ (Syntax highlight)
call plug#end()

" Tự động cài đặt plugin còn thiếu khi khởi động
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)')) | PlugInstall --sync | q | endif

" ============================================================================
" CẤU HÌNH CƠ BẢN (DÀNH CHO LẬP TRÌNH VIÊN C)
" ============================================================================
syntax on
filetype plugin indent on
set number              " Hiện số dòng
set relativenumber      " Số dòng tương đối để nhảy dòng cực nhanh
set mouse=a             " Dùng được chuột
set clipboard=unnamedplus " Copy ra ngoài Windows/Linux thoải mái
set cursorline          " Highlight dòng hiện tại
set tabstop=4           " Tiêu chuẩn C: 4 khoảng trắng
set shiftwidth=4
set expandtab
set smartindent
set ignorecase
set smartcase
set noswapfile          " Không tạo file tạm rác máy
set encoding=utf-8

" ============================================================================
" MÀU SẮC & GIAO DIỆN
" ============================================================================
set background=dark
autocmd vimenter * colorscheme gruvbox
let g:airline_powerline_fonts = 1

" ============================================================================
" PHÍM TẮT THÔNG MINH (KEYMAPS)
" ============================================================================
let mapleader = " "

" Mở/Đóng cây thư mục bằng phím Space + n
nnoremap <leader>n :NERDTreeToggle<CR>

" Di chuyển nhanh giữa các cửa sổ (Split screen)
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Nhấn Esc để tắt highlight khi tìm kiếm xong
nnoremap <silent> <Esc> :noh<CR>

" Tự động định dạng lại code C (Indent lại toàn bộ file)
nnoremap <leader>i gg=G''
