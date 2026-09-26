" ============================================================================
" VIM SIMPLE — zero-dependency, works on any Vim 8+ install
" Copy to ~/.vimrc and open Vim. Nothing to install, no internet needed.
" Features the local Vim lacks are skipped, never errors: the fuzzy popup
" finder needs Vim 8.2+, older Vim and Neovim fall back to :find / :ls.
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

" True colour only when the terminal says it supports it; on an old terminal
" or a serial console it would give wrong colours
if has('termguicolors') && ($COLORTERM =~# 'truecolor\|24bit' || has('nvim'))
    set termguicolors
endif

" Line numbers & cursor
set number relativenumber
set cursorline
silent! set signcolumn=yes
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
" Command-line completion in a popup list, fuzzy where Vim supports it
silent! set wildoptions+=pum
silent! set wildoptions+=fuzzy
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
if has('persistent_undo')
    set undofile
    set undodir=~/.vim/undodir
    if !isdirectory(expand('~/.vim/undodir'))
        silent! call mkdir(expand('~/.vim/undodir'), 'p')
    endif
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
elseif system('grep --version') =~# 'GNU'
    " skip binary files and .git / node_modules
    set grepprg=grep\ -rnI\ --exclude-dir=.git\ --exclude-dir=node_modules
    set grepformat=%f:%l:%m
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
    let b:git_branch = v:shell_error ? '' : '  ' . substitute(l:branch, '\_s\+$', '', '')
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

" :Lexplore checks for its own sidebar window, so this stays right even
" after the sidebar is closed with :q or <C-w>c
function! ToggleExplorer() abort
    silent Lexplore
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

" ============================================================================
" FINDER — fuzzy popup for files, buffers and recent files (like fzf-lua),
" built only from Vim 8.2+ popup windows and matchfuzzy(). Older Vim and
" Neovim fall back to :find, :buffer and :browse oldfiles.
" In the popup: type to filter | <C-j>/<C-k> or arrows move | <CR> open
"   <C-s> split | <C-v> vsplit | <C-u> clear | <Esc> close
" File list: git ls-files in a git repo, else rg --files, else find, else
" Vim's own globpath() — whichever the machine has.
" ============================================================================
let s:has_finder = exists('*popup_create') && exists('*matchfuzzy')
let s:finder_file_limit = 50000   " stop listing after this many files
let s:finder_shown_limit = 300    " lines put in the popup after filtering
let s:file_commands   = {'edit': 'edit', 'split': 'split', 'vsplit': 'vsplit'}
let s:buffer_commands = {'edit': 'buffer', 'split': 'sbuffer', 'vsplit': 'vertical sbuffer'}

function! s:ProjectFiles() abort
    if executable('git')
        let l:files = systemlist('git -c core.quotepath=off ls-files'
            \ . ' --cached --others --exclude-standard 2>/dev/null')
        if !v:shell_error
            return l:files[: s:finder_file_limit - 1]
        endif
    endif
    if executable('rg')
        return systemlist('rg --files --hidden --glob "!.git" 2>/dev/null | head -n '
            \ . s:finder_file_limit)
    endif
    if executable('find')
        let l:files = systemlist('find . \( -name .git -o -name node_modules \) -prune'
            \ . ' -o -type f -print 2>/dev/null | head -n ' . s:finder_file_limit)
        return map(l:files, 'v:val[2:]')
    endif
    let l:files = filter(globpath('.', '**', 0, 1), '!isdirectory(v:val)')
    return map(l:files[: s:finder_file_limit - 1], 'v:val[2:]')
endfunction

" items: list of {'text': shown in the popup, 'target': argument for the command}
" commands: which Ex command opens an item for <CR> / <C-s> / <C-v>
function! s:FinderOpen(title, items, commands) abort
    let l:width  = min([100, &columns - 6])
    let l:height = min([20, &lines - 8])
    let s:finder = {'title': a:title, 'items': a:items, 'commands': a:commands,
        \ 'query': '', 'shown': [], 'open_with': 'edit'}
    let s:finder.popup = popup_create([], {
        \ 'minwidth': l:width, 'maxwidth': l:width,
        \ 'minheight': l:height, 'maxheight': l:height,
        \ 'border': [], 'padding': [0, 1, 0, 1],
        \ 'borderchars': ['─', '│', '─', '│', '╭', '╮', '╯', '╰'],
        \ 'cursorline': 1, 'wrap': 0, 'mapping': 0,
        \ 'filter': function('s:FinderKey'),
        \ 'callback': function('s:FinderDone'),
        \ })
    call s:FinderUpdate()
endfunction

function! s:FinderUpdate() abort
    let l:matches = empty(s:finder.query) ? s:finder.items
        \ : matchfuzzy(s:finder.items, s:finder.query, {'key': 'text'})
    let s:finder.shown = l:matches[: s:finder_shown_limit - 1]
    let l:lines = empty(s:finder.shown) ? ['  no match'] : map(copy(s:finder.shown), 'v:val.text')
    call popup_settext(s:finder.popup, l:lines)
    call popup_setoptions(s:finder.popup, {'title': printf(' %s %d/%d  > %s▏',
        \ s:finder.title, len(l:matches), len(s:finder.items), s:finder.query)})
    call win_execute(s:finder.popup, 'normal! gg')
endfunction

function! s:FinderKey(popup, key) abort
    if a:key ==# "\<Esc>" || a:key ==# "\<C-c>"
        call popup_close(a:popup, -1)
    elseif index(["\<CR>", "\<C-s>", "\<C-v>"], a:key) >= 0
        let s:finder.open_with = a:key ==# "\<C-s>" ? 'split'
            \ : a:key ==# "\<C-v>" ? 'vsplit' : 'edit'
        call popup_close(a:popup, line('.', a:popup))
    elseif index(["\<C-j>", "\<C-n>", "\<Down>", "\<Tab>"], a:key) >= 0
        call win_execute(a:popup, 'normal! j')
    elseif index(["\<C-k>", "\<C-p>", "\<Up>", "\<S-Tab>"], a:key) >= 0
        call win_execute(a:popup, 'normal! k')
    elseif a:key ==# "\<BS>" || a:key ==# "\<C-h>"
        let s:finder.query = strcharpart(s:finder.query, 0, strchars(s:finder.query) - 1)
        call s:FinderUpdate()
    elseif a:key ==# "\<C-u>"
        let s:finder.query = ''
        call s:FinderUpdate()
    elseif strchars(a:key) == 1 && char2nr(a:key) >= 32
        let s:finder.query .= a:key
        call s:FinderUpdate()
    endif
    return 1
endfunction

function! s:FinderDone(popup, line) abort
    if a:line < 1 || a:line > len(s:finder.shown)
        return
    endif
    execute s:finder.commands[s:finder.open_with] . ' ' . s:finder.shown[a:line - 1].target
endfunction

function! FindFiles() abort
    if !s:has_finder
        call feedkeys(':find ', 'n')
        return
    endif
    let l:items = map(s:ProjectFiles(), '{"text": v:val, "target": fnameescape(v:val)}')
    call s:FinderOpen('Files', l:items, s:file_commands)
endfunction

function! FindBuffers() abort
    if !s:has_finder
        call feedkeys(":ls\<CR>:buffer ", 'n')
        return
    endif
    let l:items = []
    for l:buffer in filter(range(1, bufnr('$')), 'buflisted(v:val)')
        let l:name = bufname(l:buffer) ==# '' ? '[No Name]' : fnamemodify(bufname(l:buffer), ':~:.')
        call add(l:items, {'text': printf('%3d  %s', l:buffer, l:name), 'target': l:buffer})
    endfor
    call s:FinderOpen('Buffers', l:items, s:buffer_commands)
endfunction

function! FindRecent() abort
    if !s:has_finder
        browse oldfiles
        return
    endif
    let l:items = map(s:RecentFiles(200),
        \ '{"text": fnamemodify(v:val, ":~"), "target": fnameescape(v:val)}')
    call s:FinderOpen('Recent', l:items, s:file_commands)
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
" (Vim built without +terminal has no terminal mode: nothing to map)
if has('nvim')
    tnoremap <Esc><Esc> <C-\><C-n>
    tnoremap <C-h> <C-\><C-n><C-w>h
    tnoremap <C-j> <C-\><C-n><C-w>j
    tnoremap <C-k> <C-\><C-n><C-w>k
    tnoremap <C-l> <C-\><C-n><C-w>l
elseif has('terminal')
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

" --- Find (popup FINDER, or :find / :ls / oldfiles on old Vim; :grep → quickfix) ---
nnoremap <silent> <C-p>      :call FindFiles()<CR>
nnoremap <silent> <leader>ff :call FindFiles()<CR>
nnoremap <leader>fg :grep!<Space>
nnoremap <silent> <leader>fb :call FindBuffers()<CR>
nnoremap <silent> <leader>fh :call FindRecent()<CR>
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
" START SCREEN — shown when Vim opens with no file. No plugin needed.
"   f find   g grep   r recent   n new   e explorer   c config   q quit
"   0-7 or Enter on a line opens that recent file
" ============================================================================
" "GINKO'S VIM LIGHT" in the "Future" style
let s:start_logo = [
    \ '┏━╸╻┏┓╻╻┏ ┏━┓╻┏━┓   ╻ ╻╻┏┳┓   ╻  ╻┏━╸╻ ╻╺┳╸',
    \ '┃╺┓┃┃┗┫┣┻┓┃ ┃ ┗━┓   ┃┏┛┃┃┃┃   ┃  ┃┃╺┓┣━┫ ┃',
    \ '┗━┛╹╹ ╹╹ ╹┗━┛ ┗━┛   ┗┛ ╹╹ ╹   ┗━╸╹┗━┛╹ ╹ ╹',
    \ ]
" [key, label, command run by that key]
let s:start_actions = [
    \ ['f', 'Find File',    ":call FindFiles()\<CR>"],
    \ ['g', 'Find Text',    ':grep! '],
    \ ['r', 'Recent Files', ":call FindRecent()\<CR>"],
    \ ['n', 'New File',     ":enew\<CR>"],
    \ ['e', 'Explorer',     ":call ToggleExplorer()\<CR>"],
    \ ['c', 'Edit Config',  ":edit $MYVIMRC\<CR>"],
    \ ['q', 'Quit',         ":qa\<CR>"],
    \ ]
let s:start_recent_count = 8

" Same green → gold as the full config's logo, one shade per logo line
function! s:DefineStartColours() abort
    highlight StartLogo1 guifg=#6a994e ctermfg=107 gui=bold cterm=bold
    highlight StartLogo2 guifg=#a3b34c ctermfg=143 gui=bold cterm=bold
    highlight StartLogo3 guifg=#f2c14e ctermfg=221 gui=bold cterm=bold
endfunction
call s:DefineStartColours()

function! s:RecentFiles(limit) abort
    let l:files = []
    for l:file in v:oldfiles
        let l:path = fnamemodify(l:file, ':p')
        if filereadable(l:path) && l:path !~# '^/tmp/\|/\.git/\|COMMIT_EDITMSG'
            call add(l:files, l:path)
        endif
        if len(l:files) >= a:limit
            break
        endif
    endfor
    return l:files
endfunction

function! s:ShowStartScreen() abort
    " Only for a bare `vim`: no file, no piped input, nothing typed yet
    if argc() || line2byte('$') != -1 || get(s:, 'reading_stdin', 0)
        return
    endif

    let l:left = repeat(' ', max([2, (&columns - strdisplaywidth(s:start_logo[0])) / 2]))
    let l:lines = ['', '']
    for l:logo_line in s:start_logo
        call add(l:lines, l:left . l:logo_line)
    endfor
    call extend(l:lines, ['', '', l:left . 'Actions', ''])
    for [l:key, l:label, l:command] in s:start_actions
        call add(l:lines, l:left . '[' . l:key . ']  ' . l:label)
    endfor

    let b:start_recent = {}
    let l:recent = s:RecentFiles(s:start_recent_count)
    if !empty(l:recent)
        call extend(l:lines, ['', l:left . 'Recent files', ''])
        for l:index in range(len(l:recent))
            call add(l:lines, l:left . '[' . l:index . ']  ' . fnamemodify(l:recent[l:index], ':~'))
            let b:start_recent[len(l:lines)] = l:recent[l:index]
        endfor
    endif

    call setline(1, l:lines)
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile nomodifiable
    setlocal nonumber norelativenumber nocursorline nolist nowrap signcolumn=no colorcolumn=
    setlocal filetype=startscreen

    for l:index in range(len(s:start_logo))
        call matchadd('StartLogo' . (l:index + 1), '\%' . (l:index + 3) . 'l\S.*')
    endfor
    call matchadd('Title', '^\s*\(Actions\|Recent files\)$')
    call matchadd('Identifier', '\[\w\]')

    for [l:key, l:label, l:command] in s:start_actions
        execute 'nnoremap <buffer> <nowait> ' . l:key . ' ' . l:command
    endfor
    for l:index in range(len(l:recent))
        execute 'nnoremap <buffer> <nowait> <silent> ' . l:index
            \ . ' :edit ' . fnameescape(l:recent[l:index]) . '<CR>'
    endfor
    nnoremap <buffer> <silent> <CR> :call <SID>OpenStartLine()<CR>
endfunction

function! s:OpenStartLine() abort
    let l:path = get(b:start_recent, line('.'), '')
    if !empty(l:path)
        execute 'edit ' . fnameescape(l:path)
    endif
endfunction

" ============================================================================
" AUTOCOMMANDS
" ============================================================================
augroup vimrc
    autocmd!

    " Start screen for a bare `vim` (see START SCREEN)
    autocmd StdinReadPre * let s:reading_stdin = 1
    autocmd VimEnter * nested call s:ShowStartScreen()
    autocmd ColorScheme * call s:DefineStartColours()

    " Auto-save on focus lost / buffer leave
    autocmd BufLeave,FocusLost * silent! wa

    " Terminal: no line numbers, start in insert mode
    if has('nvim')
        autocmd TermOpen     * setlocal nonumber norelativenumber | startinsert
    elseif exists('##TerminalOpen')
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
