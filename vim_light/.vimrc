" ============================================================================
" VIM SIMPLE — zero-dependency, works on any Vim 8+ install
" Copy to ~/.vimrc and open Vim. Nothing to install.
" ============================================================================

" ============================================================================
" BUILT-IN BUNDLES (shipped with Vim, just not loaded by default)
" ============================================================================
runtime macros/matchit.vim      " extend % to match if/else, HTML tags, etc.
runtime ftplugin/man.vim        " K opens man page for the word under cursor

" ============================================================================
" CORE SETTINGS
" ============================================================================
syntax on
filetype plugin indent on

set encoding=utf-8
set fileencoding=utf-8

if has('termguicolors')
    set termguicolors
endif

" Line numbers & cursor
set number relativenumber
set cursorline
set signcolumn=yes
set colorcolumn=100

" Mouse & clipboard
set mouse=a
if has('clipboard')
    set clipboard=unnamedplus
endif

" Indentation
set tabstop=4 shiftwidth=4 expandtab smartindent autoindent shiftround

" Search
set ignorecase smartcase
set hlsearch incsearch showmatch

" Whitespace visibility (toggle with <leader>sw)
set listchars=tab:→\ ,trail:·,extends:›,precedes:‹,nbsp:·

" UI behaviour
set splitbelow splitright
set scrolloff=8 sidescrolloff=8
set laststatus=2
set cmdheight=2
set noshowmode
set wildmenu wildmode=longest:full,full
set wildignore+=*.o,*.pyc,*.class,**/node_modules/**,**/.git/**,*.swp
set shortmess+=c
set showcmd
set title
set belloff=all
set confirm
set pumheight=10
set completeopt=menuone,noinsert,noselect

" Performance
set updatetime=300
set timeoutlen=500
set ttimeoutlen=10
set complete-=i

" Files & history
set noswapfile nobackup nowritebackup
set hidden
set autoread
set history=10000

" Persistent undo (survives across sessions)
set undofile
set undodir=~/.vim/undodir
if !isdirectory(expand('~/.vim/undodir'))
    call mkdir(expand('~/.vim/undodir'), 'p')
endif

" Folding
set foldmethod=indent foldnestmax=5 nofoldenable

" Misc
set backspace=indent,eol,start
set formatoptions+=j
set showbreak=↪\

" ============================================================================
" FILE FINDING — :find <name><Tab> searches the whole project tree
" No fzf needed: type :find foo<Tab> or <C-p> foo<Tab>
" ============================================================================
set path+=**
set suffixesadd+=.py,.js,.ts,.lua,.c,.h,.cpp,.rs,.go,.sh

" ============================================================================
" GREP — uses rg/ag/grep; results go to quickfix automatically
" Usage: <leader>fg <pattern> or :grep pattern
" ============================================================================
if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case
    set grepformat=%f:%l:%c:%m
elseif executable('ag')
    set grepprg=ag\ --vimgrep
    set grepformat=%f:%l:%c:%m
else
    set grepprg=grep\ -rn
    set grepformat=%f:%l:%m
endif

" ============================================================================
" COLORSCHEME (built-in)
" Other safe built-ins: elflord, slate, torte, koehler, industry
" ============================================================================
set background=dark
silent! colorscheme desert

" ============================================================================
" STATUSLINE — replaces airline with pure vimscript
" Shows: mode | path | git-branch | flags ═ type | enc | line:col | %
" ============================================================================
function! StatusMode() abort
    let l:m = mode()
    if     l:m ==# 'n'       | return 'NORMAL'
    elseif l:m ==# 'i'       | return 'INSERT'
    elseif l:m ==# 'v'       | return 'VISUAL'
    elseif l:m ==# 'V'       | return 'V-LINE'
    elseif l:m ==# "\<C-v>"  | return 'V-BLCK'
    elseif l:m ==# 'R'       | return 'REPLCE'
    elseif l:m ==# 't'       | return 'TERM'
    elseif l:m ==# 'c'       | return 'CMD'
    else                     | return l:m
    endif
endfunction

function! GitHead() abort
    let l:b = system("git -C " . shellescape(expand('%:p:h')) .
        \ " rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
    return len(l:b) > 0 ? '  ' . l:b : ''
endfunction

set statusline=\ %{StatusMode()}
set statusline+=\ \|\ %f
set statusline+=%{GitHead()}
set statusline+=\ %m%r%h
set statusline+=%=
set statusline+=%y\ \|
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ \|\ %l:%c\ %p%%\

" ============================================================================
" NETRW — built-in file explorer (replaces NERDTree)
" Press <leader>e to toggle sidebar. Inside netrw:
"   -  go up a dir  |  d  make dir  |  D  delete  |  R  rename  |  %  new file
" ============================================================================
let g:netrw_banner      = 0
let g:netrw_liststyle   = 3
let g:netrw_browse_split = 4
let g:netrw_altv        = 1
let g:netrw_winsize     = 25

function! ToggleExplorer() abort
    if exists('g:netrw_open')
        let i = bufnr('$')
        while i >= 1
            if getbufvar(i, '&filetype') ==# 'netrw'
                silent execute 'bwipeout ' . i
            endif
            let i -= 1
        endwhile
        unlet g:netrw_open
    else
        let g:netrw_open = 1
        silent Lexplore
    endif
endfunction

" ============================================================================
" COMPLETION — smart Tab uses built-in <C-n> keyword completion
" Other built-in modes (use these directly in insert mode):
"   <C-x><C-f>   filename    <C-x><C-l>  whole line
"   <C-x><C-]>   ctags       <C-x><C-o>  omni (filetype)
"   <C-x><C-s>   spelling    <C-x><C-i>  included files
" ============================================================================
function! SmartTab() abort
    let l:col = col('.') - 1
    return (!l:col || getline('.')[l:col - 1] =~# '\s') ? "\<Tab>" : "\<C-n>"
endfunction

inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : SmartTab()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-d>"
inoremap <expr> <CR>    pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" ============================================================================
" QUICKFIX helpers
" ============================================================================
function! ToggleQF() abort
    let l:nr = winnr('$')
    copen
    if l:nr == winnr('$') | cclose | endif
endfunction

" ============================================================================
" BUFFER deletion without closing the window
" ============================================================================
function! BufDel() abort
    let l:buf = bufnr('%')
    let l:alt = bufnr('#')
    if l:alt != -1 && buflisted(l:alt) && l:alt != l:buf
        execute 'buffer ' . l:alt
    else
        let l:listed = filter(range(1, bufnr('$')), 'buflisted(v:val) && v:val != l:buf')
        if !empty(l:listed)
            execute 'buffer ' . l:listed[0]
        else
            enew
        endif
    endif
    execute 'bdelete ' . l:buf
endfunction

function! ToggleLineNumbers() abort
    set relativenumber! number
endfunction

" ============================================================================
" KEYMAPS
" ============================================================================
let mapleader = " "

" --- Escape ---
inoremap jk <Esc>
inoremap kj <Esc>
nnoremap <silent> <leader><leader> :nohlsearch<CR>

" --- Terminal escape ---
if has('nvim')
    tnoremap <Esc><Esc> <C-\><C-n>
else
    tnoremap <Esc><Esc> <C-w>N
endif

" --- Window navigation ---
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" --- Window resize ---
nnoremap <C-Up>    :resize +2<CR>
nnoremap <C-Down>  :resize -2<CR>
nnoremap <C-Left>  :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>

" --- Buffers ---
nnoremap [b         :bprevious<CR>
nnoremap ]b         :bnext<CR>
nnoremap <leader>bd :call BufDel()<CR>
nnoremap <leader>bb :ls<CR>:buffer<Space>

" --- File explorer ---
nnoremap <silent> <leader>e  :call ToggleExplorer()<CR>
nnoremap <silent> <leader>E  :Explore<CR>

" --- File finding (built-in :find + ** path) ---
nnoremap <leader>ff :find<Space>
nnoremap <C-p>      :find<Space>

" --- Grep → quickfix ---
nnoremap <leader>fg  :grep!<Space>
nnoremap <leader>fw  :grep! "\b<C-r><C-w>\b"<CR>:copen<CR>

" --- Quickfix ---
nnoremap <silent> <leader>q :call ToggleQF()<CR>
nnoremap [q  :cprevious<CR>
nnoremap ]q  :cnext<CR>
nnoremap [Q  :cfirst<CR>
nnoremap ]Q  :clast<CR>

" --- Location list ---
nnoremap [l  :lprevious<CR>
nnoremap ]l  :lnext<CR>

" --- Built-in LSP-like navigation (no plugin needed) ---
" gd       → jump to local definition
" gD       → jump to global declaration
" K        → man page (via man.vim loaded above)
" *  / #   → search word under cursor forward / backward
" [I       → list all lines containing word under cursor
" <C-]>    → jump into ctags definition
" <C-t>    → jump back from ctags

" --- Terminal ---
if has('nvim')
    nnoremap <leader>t  :botright split +terminal<CR>:resize 12<CR>
    nnoremap <leader>tv :botright vsplit +terminal<CR>
else
    nnoremap <leader>t  :botright terminal ++rows=12<CR>
    nnoremap <leader>tv :vertical terminal<CR>
endif

" --- Editing ---
nnoremap <leader>i   gg=G''
nnoremap <leader>w   :w<CR>
nnoremap <leader>sv  :source $MYVIMRC<CR>
nnoremap <leader>ev  :edit $MYVIMRC<CR>
nnoremap <leader>ln  :call ToggleLineNumbers()<CR>
nnoremap <leader>sw  :set list!<CR>
nnoremap <leader>sf  :set spell!<CR>

" Indent blocks in visual mode
vnoremap <Tab>   >gv
vnoremap <S-Tab> <gv

" Move lines up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" Yank to end of line (consistent with D and C)
nnoremap Y y$

" Centre screen on search results and jumps
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Insert mode navigation
inoremap <C-l> <Right>
inoremap <C-e> <Esc>A

" ============================================================================
" AUTOCOMMANDS
" ============================================================================
augroup vimrc
    autocmd!

    " Auto-save on focus lost / buffer leave
    autocmd BufLeave,FocusLost * silent! wa

    " Terminal: no line numbers, start in insert mode
    if has('nvim')
        autocmd TermOpen     * setlocal nonumber norelativenumber | startinsert
    else
        autocmd TerminalOpen * setlocal nonumber norelativenumber | startinsert
    endif

    " Restore cursor position when reopening a file
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") |
        \     exe "normal! g'\"" |
        \ endif

    " Re-balance splits on resize
    autocmd VimResized * tabdo wincmd =

    " Auto-open quickfix after any grep
    autocmd QuickFixCmdPost [^l]* cwindow
    autocmd QuickFixCmdPost l*    lwindow

    " Strip trailing whitespace on save
    autocmd BufWritePre * :%s/\s\+$//e

augroup END
