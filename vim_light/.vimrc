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
let &showbreak = '↪ '

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
" sorbet ships with Vim 9.0+; older Vim falls back to desert.
" Other built-ins: habamax, retrobox, wildcharm, slate, desert
" ============================================================================
set background=dark
try
    colorscheme sorbet
catch /E185/
    silent! colorscheme desert
endtry

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

" The branch is looked up once per buffer (on open, focus and write) and kept
" in b:git_branch, so the statusline never runs git on each redraw.
function! UpdateGitBranch() abort
    if &buftype !=# '' | let b:git_branch = '' | return | endif
    let l:branch = system('git -C ' . shellescape(expand('%:p:h')) .
        \ ' rev-parse --abbrev-ref HEAD 2>/dev/null')
    let b:git_branch = v:shell_error ? '' : '  ' . trim(l:branch)
endfunction

function! GitHead() abort
    return get(b:, 'git_branch', '')
endfunction

set statusline=\ %{StatusMode()}
set statusline+=\ \|\ %f
set statusline+=%{GitHead()}
set statusline+=\ %m%r%h
set statusline+=%=
set statusline+=%y\ \|
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\ \|\ %l:%c\ %p%%
let &statusline .= ' '

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

" Move the cursor to the netrw sidebar, opening it if needed
function! FocusExplorer() abort
    for l:window in range(1, winnr('$'))
        if getwinvar(l:window, '&filetype') ==# 'netrw'
            execute l:window . 'wincmd w'
            return
        endif
    endfor
    call ToggleExplorer()
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
function! ToggleQuickfix() abort
    if getqflist({'winid': 0}).winid != 0
        cclose
    else
        copen
    endif
endfunction

function! ToggleLocList() abort
    if getloclist(0, {'winid': 0}).winid != 0
        lclose
    elseif empty(getloclist(0))
        echo 'No location list'
    else
        lopen
    endif
endfunction

" Step through the quickfix list, wrapping at the ends
function! QuickfixStep(forward) abort
    try
        execute a:forward ? 'cnext' : 'cprevious'
    catch /E553/
        execute a:forward ? 'cfirst' : 'clast'
    catch /E42\|E776/
        echo 'Quickfix list is empty'
    endtry
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
" FLOATING TERMINAL — popup window in Vim, floating window in Neovim.
" Runs a:1 or the shell; the window closes when the program exits.
" ============================================================================
function! OpenFloatTerm(...) abort
    let l:command = a:0 ? a:1 : &shell
    let l:width  = float2nr(&columns * 0.8)
    let l:height = float2nr(&lines * 0.8)
    if has('nvim')
        let l:buf = nvim_create_buf(v:false, v:true)
        call nvim_open_win(l:buf, v:true, {
            \ 'relative': 'editor',
            \ 'width': l:width,
            \ 'height': l:height,
            \ 'col': (&columns - l:width) / 2,
            \ 'row': (&lines - l:height) / 2,
            \ 'style': 'minimal',
            \ 'border': 'rounded',
            \ })
        call termopen(l:command, {'on_exit': {-> execute('bwipeout! ' . l:buf)}})
        tnoremap <buffer> <Esc><Esc> <Esc><Esc>
        startinsert
    elseif has('popupwin') && has('terminal')
        let l:buf = term_start(l:command, {'hidden': 1, 'term_finish': 'close'})
        let l:popup = popup_create(l:buf, {
            \ 'minwidth': l:width, 'maxwidth': l:width,
            \ 'minheight': l:height, 'maxheight': l:height,
            \ 'border': [],
            \ 'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
            \ })
        call win_execute(l:popup, 'tnoremap <buffer> <Esc><Esc> <Esc><Esc>')
    else
        echo 'Floating terminal needs Neovim or Vim with +popupwin and +terminal'
    endif
endfunction

function! OpenLazygit() abort
    if executable('lazygit')
        call OpenFloatTerm('lazygit')
    else
        echo 'lazygit is not installed'
    endif
endfunction

" ============================================================================
" C/C++: switch between source and header (nvim2's <leader>ch uses clangd;
" this looks next to the file first, then anywhere on 'path')
" ============================================================================
function! SwitchSourceHeader() abort
    let l:partners = {
        \ 'c': ['h'], 'cc': ['h', 'hpp'], 'cpp': ['h', 'hpp'],
        \ 'h': ['c', 'cpp', 'cc'], 'hpp': ['cpp', 'cc'],
        \ }
    for l:extension in get(l:partners, expand('%:e'), [])
        let l:beside = expand('%:p:r') . '.' . l:extension
        if filereadable(l:beside)
            execute 'edit ' . fnameescape(l:beside)
            return
        endif
        let l:found = findfile(expand('%:t:r') . '.' . l:extension)
        if !empty(l:found)
            execute 'edit ' . fnameescape(l:found)
            return
        endif
    endfor
    echo 'No matching source/header file found'
endfunction

" ============================================================================
" KEYMAPS — same keys as nvim2 (nvim2/.config/nvim/lua/system/kernel/keymap.lua
" and the plugin specs), using only what Vim ships with. Keys for nvim2
" plugins that have no built-in stand-in (LSP, debugger, harpoon...) are left out.
" ============================================================================
let mapleader = " "

" Terminal Vim sees Alt+key as Esc+key; teach it the Alt keys used below
if !has('nvim') && !has('gui_running')
    for s:key in ['e', 'j', 'k']
        execute "set <M-" . s:key . ">=\e" . s:key
    endfor
endif

" --- Escape ---
inoremap jk <Esc>
inoremap kj <Esc>
nnoremap <silent> <leader><leader> :nohlsearch<CR>
" nvim2 clears the search highlight on <Esc>. Neovim only: in terminal Vim,
" mapping <Esc> breaks arrow keys and terminal replies (which start with Esc).
if has('nvim')
    nnoremap <silent> <Esc> :nohlsearch<CR><Esc>
endif

" --- Terminal mode (Ctrl-h/j/k/l leave the terminal window, like nvim2) ---
if has('nvim')
    tnoremap <Esc><Esc> <C-\><C-n>
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
else
    tnoremap <Esc><Esc> <C-w>N
    tnoremap <C-h> <C-w>h
    tnoremap <C-j> <C-w>j
    tnoremap <C-k> <C-w>k
    tnoremap <C-l> <C-w>l
endif

" --- Buffers ---
" nvim2 also puts next/previous buffer on <Tab>/<S-Tab>. Left out here: in a
" terminal <Tab> is the same key as <C-i> (jump forward).
nnoremap [b         :bprevious<CR>
nnoremap ]b         :bnext<CR>
nnoremap <leader>bd :call BufDel()<CR>

" --- Windows ---
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <C-Up>    :resize +2<CR>
nnoremap <C-Down>  :resize -2<CR>
nnoremap <C-Left>  :vertical resize -2<CR>
nnoremap <C-Right> :vertical resize +2<CR>
nnoremap <leader><Bar> :vsplit<CR>
nnoremap <leader>-  :split<CR>
nnoremap <leader>wv :vsplit<CR>
nnoremap <leader>wh :split<CR>
nnoremap <leader>wq :close<CR>
nnoremap <leader>wo :only<CR>
nnoremap <leader>w= <C-w>=

" --- File explorer (netrw) ---
nnoremap <silent> <leader>e  :call ToggleExplorer()<CR>
nnoremap <silent> <leader>o  :call FocusExplorer()<CR>
nnoremap <silent> <leader>E  :Explore<CR>

" --- Find (built-in :find + ** path, :grep → quickfix) ---
nnoremap <C-p>      :find<Space>
nnoremap <leader>ff :find<Space>
nnoremap <leader>fg :grep!<Space>
nnoremap <leader>fb :ls<CR>:buffer<Space>
nnoremap <leader>fh :browse oldfiles<CR>
nnoremap <leader>f* :grep! "\b<C-r><C-w>\b"<CR>
nnoremap <leader>p  :<C-f>

" --- Code ---
nnoremap <leader>lf gg=G''
nnoremap <leader>ch :call SwitchSourceHeader()<CR>

" --- Diagnostics / quickfix ---
nnoremap <silent> <leader>xq :call ToggleQuickfix()<CR>
nnoremap <silent> <leader>xl :call ToggleLocList()<CR>
nnoremap <silent> ]q :call QuickfixStep(1)<CR>
nnoremap <silent> [q :call QuickfixStep(0)<CR>
nnoremap [Q  :cfirst<CR>
nnoremap ]Q  :clast<CR>
nnoremap [l  :lprevious<CR>
nnoremap ]l  :lnext<CR>

" --- Git ---
nnoremap <silent> <leader>gg :call OpenLazygit()<CR>

" --- Built-in LSP-like navigation (no plugin needed) ---
" gd       → jump to local definition
" gD       → jump to global declaration
" K        → man page (via man.vim loaded above)
" *  / #   → search word under cursor forward / backward
" [I       → list all lines containing word under cursor
" <C-]>    → jump into ctags definition
" <C-t>    → jump back from ctags

" --- Search & replace (nvim2: grug-far, project wide; here: this file) ---
nnoremap <leader>sr :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>
vnoremap <leader>sr y:%s/\V<C-r>=escape(@", '/\')<CR>//gc<Left><Left><Left>

" --- Toggles ---
nnoremap <silent> <leader>us :setlocal spell! spelllang=en_us<CR>
nnoremap <silent> <leader>un :call ToggleLineNumbers()<CR>
nnoremap <silent> <leader>uw :set list!<CR>

" --- Terminal ---
if has('nvim')
    nnoremap <leader>th :botright split +terminal<CR>:resize 12<CR>
    nnoremap <leader>tv :botright vsplit +terminal<CR>
else
    nnoremap <leader>th :botright terminal ++rows=12<CR>
    nnoremap <leader>tv :vertical terminal<CR>
endif
nnoremap <silent> <leader>tf :call OpenFloatTerm()<CR>

" --- Editing ---
nnoremap <leader>i   gg=G''
nnoremap <leader>se  :edit $MYVIMRC<CR>
nnoremap <leader>sv  :source $MYVIMRC<CR>

" Indent in visual mode and keep the selection
vnoremap <Tab>   >gv
vnoremap <S-Tab> <gv
vnoremap < <gv
vnoremap > >gv

" Move lines up/down
nnoremap <M-j> :m .+1<CR>==
nnoremap <M-k> :m .-2<CR>==
vnoremap <M-j> :m '>+1<CR>gv=gv
vnoremap <M-k> :m '<-2<CR>gv=gv
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" Yank to end of line (consistent with D and C)
nnoremap Y y$

" Clipboard
nnoremap <leader>y  "+y
vnoremap <leader>y  "+y
nnoremap <leader>yp "+p

" Centre screen on search results and jumps
nnoremap n nzzzv
nnoremap N Nzzzv
nnoremap <C-d> <C-d>zz
nnoremap <C-u> <C-u>zz

" Insert mode: <M-e> jumps to end of line (nvim2), <C-l> moves right
inoremap <M-e> <Esc>A
inoremap <C-l> <Right>

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

    " Keep the statusline git branch up to date
    autocmd BufEnter,FocusGained,BufWritePost * call UpdateGitBranch()

    " Strip trailing whitespace on save (not Markdown, where two trailing
    " spaces mean a line break); keeps cursor position and search history
    autocmd BufWritePre * if &filetype !=# 'markdown' |
        \     let s:view = winsaveview() |
        \     keeppatterns %s/\s\+$//e |
        \     call winrestview(s:view) |
        \ endif

augroup END
