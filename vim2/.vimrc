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
" 2. DANH SÁCH PLUGIN
" ============================================================================
call plug#begin('~/.vim/plugged')
Plug 'morhetz/gruvbox'          " Màu sắc chuyên nghiệp
Plug 'preservim/nerdtree'       " Cây thư mục
Plug 'vim-airline/vim-airline'  " Thanh trạng thái & Tabline
Plug 'ctrlpvim/ctrlp.vim'       " Tìm file nhanh (Ctrl + p)
Plug 'tpope/vim-commentary'     " Comment nhanh (gcc)
Plug 'sheerun/vim-polyglot'     " Syntax highlight đa ngôn ngữ
call plug#end()

" ============================================================================
" 3. CẤU HÌNH CƠ BẢN & SEARCH & CLIPBOARD
" ============================================================================
syntax on
filetype plugin indent on
set number relativenumber
set mouse=a
set cursorline
set tabstop=4
set shiftwidth=4
set expandtab
set smartindent
set ignorecase smartcase
set noswapfile
set encoding=utf-8
set hidden
set hlsearch incsearch showmatch

" Đồng bộ Clipboard hệ thống
if has('unnamedplus') | set clipboard=unnamedplus | endif

" Nhảy code bằng Ctags
set tags=./tags;,tags;

" ============================================================================
" 4. GIAO DIỆN & THANH BAR (TABLINE) & CON TRỎ
" ============================================================================
set background=dark
silent! colorscheme gruvbox

" Cấu hình Airline
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'

" Đổi hình dạng con trỏ (Normal: Block, Insert: Vertical Bar)
if &term =~ '256color' || &term =~ 'xterm' || &term =~ 'screen' || &term =~ 'tmux'
    let &t_SI = "\e[5 q"
    let &t_EI = "\e[1 q"
    if exists('$TMUX')
        let &t_SI = "\ePtmux;\e\e[5 q\e\\"
        let &t_EI = "\ePtmux;\e\e[1 q\e\\"
    endif
endif
autocmd VimLeave * silent !echo -ne "\e[1 q"

" ============================================================================
" 5. TỐI ƯU HÓA TERMINAL (FIX LỖI E216 CHO VIM CLASSIC)
" ============================================================================
if has('nvim')
    autocmd TermOpen * setlocal nonumber norelativenumber
    autocmd TermOpen * startinsert
else
    " Dành cho Vim Classic
    if exists('##TerminalOpen')
        autocmd TerminalOpen * setlocal nonumber norelativenumber
        autocmd TerminalOpen * startinsert
    endif
endif

" Tự động lưu file khi rời cửa sổ code sang Terminal
autocmd BufLeave,FocusLost * silent! wa

" ============================================================================
" 6. PHÍM TẮT THÔNG MINH (UNIFIED KEYMAPS)
" ============================================================================
let mapleader = " "

" --- Thoát nhanh (Normal & Terminal) ---
inoremap jk <Esc>
inoremap kj <Esc>

if has('nvim')
    tnoremap jk <C-\><C-n>
else
    " Thoát chế độ gõ trong Terminal của Vim Classic
    tnoremap jk <C-w>N
endif

" --- Highlight & Search ---
nnoremap <silent> <leader><leader> :noh<CR>

" --- Quản lý Terminal ---
nnoremap <leader>t :botright terminal ++rows=10<CR>
nnoremap <leader>vt :vertical terminal<CR>

" --- Di chuyển cửa sổ Split (Đồng bộ Code và Terminal) ---
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

if has('nvim')
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
else
    tnoremap <C-h> <C-w>h
    tnoremap <C-j> <C-w>j
    tnoremap <C-k> <C-w>k
    tnoremap <C-l> <C-w>l
endif

" --- Duyệt File & Buffer ---
function! ToggleExplorer()
    if exists(':NERDTreeToggle') | exec 'NERDTreeToggle' | else | exec 'Lexplore' | endif
endfunction
nnoremap <leader>e :call ToggleExplorer()<CR>

nnoremap [b :bprevious<CR>
nnoremap ]b :bnext<CR>
nnoremap <leader>bd :bdelete<CR>

" --- Nhảy Code ---
nnoremap gd <C-]>
nnoremap gr :grep! -r <C-R><C-W> .<CR>:cw<CR>
nnoremap K  :Man <C-R><C-W><CR>

" --- Tiện ích ---
nnoremap <leader>i gg=G''
nnoremap <leader>f :grep! -r  .<Left><Left>
vnoremap <Tab> >gv
vnoremap <S-Tab> <gv
