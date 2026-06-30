" ============================================================================
" AUTO-INSTALL VIM-PLUG
" ============================================================================
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
    if executable('curl')
        silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
        autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
    endif
endif

" ============================================================================
" PLUGINS
" ============================================================================
call plug#begin('~/.vim/plugged')

" Colorscheme
Plug 'morhetz/gruvbox'

" UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'Yggdroot/indentLine'
Plug 'mbbill/undotree'
Plug 'preservim/tagbar'

" Fuzzy finding (requires fzf on PATH)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" LSP + Completion + Snippets (requires Node.js >= 16)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'easymotion/vim-easymotion'
Plug 'wellle/targets.vim'

" Syntax / Language
Plug 'sheerun/vim-polyglot'

" Linting / Fixing
Plug 'dense-analysis/ale'

" Keybinding hints
Plug 'liuchengxu/vim-which-key'

call plug#end()

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

" UI behaviour
set splitbelow splitright
set scrolloff=8 sidescrolloff=8
set laststatus=2
set cmdheight=2
set noshowmode
set wildmenu wildmode=longest:full,full
set wildignore+=*.o,*.pyc,*.class,.git
set shortmess+=c
set showcmd
set title
set belloff=all
set confirm

" Performance
set updatetime=300
set timeoutlen=500
set ttimeoutlen=10
set complete-=i

" Files
set noswapfile nobackup nowritebackup
set hidden
set autoread
set undofile undodir=~/.vim/undodir
set history=10000

" Folding
set foldmethod=indent foldnestmax=5 nofoldenable

" Misc
set backspace=indent,eol,start
set formatoptions+=j

if !isdirectory(expand('~/.vim/undodir'))
    call mkdir(expand('~/.vim/undodir'), 'p')
endif

" ============================================================================
" COLORSCHEME
" ============================================================================
set background=dark
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_italic = 1
silent! colorscheme gruvbox

" ============================================================================
" AIRLINE
" ============================================================================
let g:airline_powerline_fonts = 1
let g:airline_theme = 'gruvbox'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#coc#enabled = 1

" ============================================================================
" NERDTREE
" ============================================================================
let g:NERDTreeShowHidden = 1
let g:NERDTreeMinimalUI = 1
let g:NERDTreeIgnore = ['\.git$', '\.pyc$', '__pycache__', 'node_modules', '\.o$']
" ============================================================================
" FZF
" ============================================================================
let g:fzf_layout = {'down': '40%'}

if executable('rg')
    let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git"'
elseif executable('fd')
    let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
endif

" ============================================================================
" GITGUTTER
" ============================================================================
let g:gitgutter_sign_added    = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed  = '-'

" ============================================================================
" INDENTLINE
" ============================================================================
let g:indentLine_char = '|'

" ============================================================================
" ALE
" ============================================================================
let g:ale_disable_lsp = 1
let g:ale_linters_explicit = 1
let g:ale_linters = {'python': ['flake8'], 'javascript': ['eslint'], 'cpp': ['gcc'], 'c': ['gcc'], 'sh': ['shellcheck']}
let g:ale_sign_error   = 'E'
let g:ale_sign_warning = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" ============================================================================
" COC.NVIM — LSP, completion, snippets
" ============================================================================
let g:coc_global_extensions = ['coc-json', 'coc-html', 'coc-css', 'coc-tsserver', 'coc-pyright', 'coc-clangd', 'coc-lua', 'coc-snippets']

" Tab for completion navigation
inoremap <silent><expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : CheckBackspace() ? "\<Tab>" : coc#refresh()
inoremap <expr><S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

function! CheckBackspace() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1] =~# '\s'
endfunction

" Enter confirms selected completion
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Ctrl-Space triggers completion manually
inoremap <silent><expr> <C-Space> coc#refresh()

" Highlight symbol references on cursor hold
function! ShowDocumentation()
    if exists('*CocAction') && CocAction('hasProvider', 'hover')
        call CocActionAsync('doHover')
    else
        call feedkeys('K', 'in')
    endif
endfunction

" ============================================================================
" EASYMOTION
" ============================================================================
let g:EasyMotion_do_mapping = 0
let g:EasyMotion_smartcase = 1

" ============================================================================
" AUTO-PAIRS
" ============================================================================
let g:AutoPairsMapCR = 0
let g:AutoPairsShortcutToggle = ''

" ============================================================================
" TAGBAR
" ============================================================================
let g:tagbar_autofocus = 1
let g:tagbar_width = 30
let g:tagbar_sort = 0

" ============================================================================
" CURSOR SHAPE
" ============================================================================
if &term =~ '256color\|xterm'
    let &t_SI = "\e[5 q"
    let &t_SR = "\e[3 q"
    let &t_EI = "\e[1 q"
endif

" ============================================================================
" KEYMAPS
" ============================================================================
let mapleader = " "

" ============================================================================
" VIM-WHICH-KEY
" ============================================================================
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
call which_key#register('<Space>', 'g:which_key_map')

let g:which_key_map = {}

let g:which_key_map[' '] = 'clear highlight'
let g:which_key_map['E'] = 'explorer find'
let g:which_key_map['u'] = 'undotree'
let g:which_key_map['w'] = 'save'
let g:which_key_map['i'] = 'indent all'

let g:which_key_map.b = { 'name': '+buffer', 'd': 'delete' }

let g:which_key_map.e = { 'name': '+explorer', 'v': 'edit vimrc' }

let g:which_key_map.f = {
    \ 'name': '+find',
    \ 'f': 'files',
    \ 'g': 'grep',
    \ 'b': 'buffers',
    \ 'h': 'history',
    \ 'l': 'buffer lines',
    \ 'L': 'all lines',
    \ 'c': 'commands',
    \ 'm': 'mappings',
    \ }

let g:which_key_map.c = {
    \ 'name': '+lsp',
    \ 'a': 'code action',
    \ 'f': 'format',
    \ 'd': 'diagnostics',
    \ 's': 'symbols',
    \ 'o': 'outline',
    \ }

let g:which_key_map.r = { 'name': '+refactor', 'n': 'rename' }

let g:which_key_map.g = {
    \ 'name': '+git',
    \ 'g': 'status',
    \ 'b': 'blame',
    \ 'd': 'diff',
    \ 'l': 'log',
    \ 'p': 'push',
    \ 'P': 'pull',
    \ }

let g:which_key_map.h = {
    \ 'name': '+hunk',
    \ 's': 'stage',
    \ 'u': 'undo',
    \ 'p': 'preview',
    \ }

let g:which_key_map.l = { 'name': '+line', 'n': 'toggle numbers' }

let g:which_key_map.s = { 'name': '+settings', 'v': 'reload vimrc' }

let g:which_key_map.t = {
    \ 'name': '+terminal',
    \ 'b': 'tagbar',
    \ 'v': 'vertical terminal',
    \ }

" --- Escape ---
inoremap jk <Esc>
inoremap kj <Esc>
nnoremap <silent> <leader><leader> :noh<CR>

" --- Terminal escape ---
if has('nvim')
    tnoremap jk <C-\><C-n>
    tnoremap <Esc> <C-\><C-n>
else
    tnoremap jk <C-w>N
    tnoremap <Esc> <C-w>N
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

" --- File explorer ---
function! ToggleExplorer()
    if exists(':NERDTreeToggle') | exec 'NERDTreeToggle' | else | exec 'Lexplore' | endif
endfunction
nnoremap <leader>e  :call ToggleExplorer()<CR>
nnoremap <leader>E  :NERDTreeFind<CR>

" --- FZF ---
nnoremap <C-p>      :Files<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fh :History<CR>
nnoremap <leader>fl :BLines<CR>
nnoremap <leader>fL :Lines<CR>
nnoremap <leader>fc :Commands<CR>
nnoremap <leader>fm :Maps<CR>

" --- COC LSP ---
nmap <silent> gd         <Plug>(coc-definition)
nmap <silent> gD         <Plug>(coc-declaration)
nmap <silent> gy         <Plug>(coc-type-definition)
nmap <silent> gi         <Plug>(coc-implementation)
nmap <silent> gr         <Plug>(coc-references)
nmap <silent> [g         <Plug>(coc-diagnostic-prev)
nmap <silent> ]g         <Plug>(coc-diagnostic-next)
nmap <leader>rn          <Plug>(coc-rename)
nmap <leader>ca          <Plug>(coc-codeaction-cursor)
nmap <leader>cf          <Plug>(coc-format)
vmap <leader>cf          <Plug>(coc-format-selected)
nnoremap <silent> K      :call ShowDocumentation()<CR>
nnoremap <leader>cd      :CocList diagnostics<CR>
nnoremap <leader>cs      :CocList -I symbols<CR>
nnoremap <leader>co      :CocList outline<CR>

" COC text objects: function and class
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" --- Git (fugitive) ---
nnoremap <leader>gg :Git<CR>
nnoremap <leader>gb :Git blame<CR>
nnoremap <leader>gd :Gdiffsplit<CR>
nnoremap <leader>gl :Git log --oneline -20<CR>
nnoremap <leader>gp :Git push<CR>
nnoremap <leader>gP :Git pull<CR>

" Git hunk navigation (gitgutter)
nmap [h <Plug>(GitGutterPrevHunk)
nmap ]h <Plug>(GitGutterNextHunk)
nmap <leader>hs <Plug>(GitGutterStageHunk)
nmap <leader>hu <Plug>(GitGutterUndoHunk)
nmap <leader>hp <Plug>(GitGutterPreviewHunk)

" --- Undotree ---
nnoremap <leader>u :UndotreeToggle<CR>

" --- Tagbar ---
nnoremap <leader>tb :TagbarToggle<CR>

" --- Terminal ---
if has('nvim')
    nnoremap <leader>t  :botright split +terminal | resize 12<CR>
    nnoremap <leader>tv :botright vsplit +terminal<CR>
else
    nnoremap <leader>t  :botright terminal ++rows=12<CR>
    nnoremap <leader>tv :vertical terminal<CR>
endif

" --- Editing ---
nnoremap <leader>i  gg=G''
nnoremap <leader>w  :w<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>
nnoremap <leader>ev :edit $MYVIMRC<CR>
nnoremap <leader>ln :call ToggleLineNumbers()<CR>

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

" Centre screen on search results
nnoremap n nzzzv
nnoremap N Nzzzv

" Insert mode navigation
inoremap <C-l> <Right>
inoremap <C-e> <Esc>A

" --- EasyMotion ---
nmap s <Plug>(easymotion-s2)
nmap S <Plug>(easymotion-overwin-f2)

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
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " Re-balance splits on resize
    autocmd VimResized * tabdo wincmd =

    " Close NERDTree if it's the last window
    autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

    " Highlight symbol under cursor (coc.nvim)
    autocmd CursorHold * if exists('*CocActionAsync') | silent call CocActionAsync('highlight') | endif

augroup END

" ============================================================================
" FUNCTIONS
" ============================================================================

" Close buffer without closing the window
function! BufDel()
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

" Toggle relative / absolute line numbers
function! ToggleLineNumbers()
    if &relativenumber
        set norelativenumber number
    else
        set relativenumber number
    endif
endfunction
