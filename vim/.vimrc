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
Plug 'joshdick/onedark.vim'
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
Plug 'mhinz/vim-startify'           " start screen (neovim: snacks dashboard)
Plug 'wellle/context.vim'           " sticky function header (neovim: treesitter-context)

" Fuzzy finding (requires fzf on PATH)
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Git
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'

" LSP + Completion + Snippets (requires Node.js >= 16)
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" AI suggestions (neovim: copilot.lua) — shares the login in ~/.config/github-copilot
Plug 'github/copilot.vim'

" Editing
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'easymotion/vim-easymotion'
Plug 'wellle/targets.vim'
Plug 'AndrewRadev/splitjoin.vim'    " split/join code blocks (neovim: treesj)
Plug 'christoomey/vim-tmux-navigator' " Ctrl-h/j/k/l across Vim splits and tmux panes

" Syntax / Language
Plug 'sheerun/vim-polyglot'
Plug 'lervag/vimtex'                " LaTeX (same plugin as neovim)
Plug 'mechatroner/rainbow_csv'      " CSV column colours (neovim: rainbow_csv.nvim)

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
" smartindent off like neovim; filetype indent files handle indentation
set tabstop=4 shiftwidth=4 expandtab autoindent shiftround

" Search
set ignorecase smartcase
set hlsearch incsearch showmatch

" UI behaviour
set splitbelow splitright
set nowrap
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
set updatetime=250
set timeoutlen=300
set ttimeoutlen=10
set complete-=i

" Files
set noswapfile nobackup nowritebackup
set hidden
set autoread
set undofile undodir=~/.vim/undodir
set history=10000
" Off like neovim: stray "ex:" / "vim:" text in comments can run as settings
set nomodeline
set spelllang=en_us

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
" Change active_theme to switch (same idea as neovim's colorscheme.lua).
" Installed: onedark (matches neovim), gruvbox
let s:active_theme = 'onedark'

set background=dark
let g:onedark_terminal_italics = 1
let g:gruvbox_contrast_dark = 'medium'
let g:gruvbox_italic = 1
execute 'silent! colorscheme ' . s:active_theme

" ============================================================================
" AIRLINE
" ============================================================================
let g:airline_powerline_fonts = 1
let g:airline_theme = s:active_theme
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

" :grep uses ripgrep (for <leader>f*, which sends matches to the quickfix list)
if executable('rg')
    set grepprg=rg\ --vimgrep\ --smart-case
    set grepformat=%f:%l:%c:%m
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
" indentLine turns on conceal, which hides quotes in JSON and markup in Markdown
" (and would draw its | guides into the start screen's padding)
let g:indentLine_fileTypeExclude = ['json', 'jsonc', 'markdown', 'startify']

" ============================================================================
" ALE
" ============================================================================
" Tools neovim installs with mason live here; Vim reuses them. Mason's copy
" wins over PATH, as in neovim (mason puts its bin folder first on PATH).
let s:mason_bin = expand('~/.local/share/nvim/mason/bin/')
function! s:Tool(name) abort
    return executable(s:mason_bin . a:name) ? s:mason_bin . a:name : a:name
endfunction

let g:ale_disable_lsp = 1
let g:ale_linters_explicit = 1
" Linters as in neovim's lint.lua. Python and C/C++ checks come from the
" language servers (ruff, clangd) set up under COC below.
let g:ale_linters = {'sh': ['shellcheck'], 'lua': ['luacheck']}

" Format on save with the same tools as neovim's conform.nvim (format.lua).
" TOML is formatted by the taplo language server instead (ALE has no taplo).
let g:ale_fixers = {
    \ 'lua':    ['stylua'],
    \ 'python': ['ruff', 'ruff_format'],
    \ 'sh':     ['shfmt'],
    \ 'json':   ['jq'],
    \ 'rust':   ['rustfmt'],
    \ 'c':      ['clang-format'],
    \ 'cpp':    ['clang-format'],
    \ }
let g:ale_fix_on_save = 1
let g:ale_python_ruff_executable = s:Tool('ruff')
let g:ale_python_ruff_format_executable = s:Tool('ruff')
" ruff fixer = organize imports only (neovim: ruff_organize_imports)
let g:ale_python_ruff_options = '--select I'
let g:ale_sign_error   = 'E'
let g:ale_sign_warning = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'

" ============================================================================
" COC.NVIM — LSP, completion, snippets
" ============================================================================
" Extensions only where they add something (clangd source/header switch,
" rust-analyzer commands, JSON schemas, snippets). Every other server is the
" one neovim uses, run straight from mason (languageserver entries below).
let g:coc_global_extensions = ['coc-json', 'coc-clangd', 'coc-rust-analyzer', 'coc-snippets']

let g:coc_user_config = {
    \ 'suggest.noselect': v:true,
    \ 'clangd.path': s:Tool('clangd'),
    \ 'clangd.arguments': [
    \     '--background-index', '-j=1', '--limit-results=20', '--malloc-trim',
    \     '--clang-tidy', '--header-insertion=never', '--completion-style=bundled',
    \     '--query-driver=/usr/bin/arm-none-eabi*',
    \ ],
    \ 'rust-analyzer.server.path': 'rust-analyzer',
    \ 'languageserver': {
    \     'pyright': {
    \         'command': s:Tool('pyright-langserver'), 'args': ['--stdio'],
    \         'filetypes': ['python'],
    \         'rootPatterns': ['pyproject.toml', 'setup.py', 'requirements.txt', '.git'],
    \         'settings': {'python': {'analysis': {
    \             'autoSearchPaths': v:true, 'useLibraryCodeForTypes': v:true,
    \             'diagnosticMode': 'workspace', 'typeCheckingMode': 'basic'}}},
    \     },
    \     'ruff': {
    \         'command': s:Tool('ruff'), 'args': ['server'],
    \         'filetypes': ['python'],
    \         'rootPatterns': ['pyproject.toml', 'ruff.toml', '.ruff.toml', '.git'],
    \     },
    \     'lua_ls': {
    \         'command': s:Tool('lua-language-server'),
    \         'filetypes': ['lua'],
    \         'rootPatterns': ['.luarc.json', '.luarc.jsonc', '.git'],
    \         'settings': {'Lua': {'workspace': {'checkThirdParty': v:false},
    \                              'telemetry': {'enable': v:false}}},
    \     },
    \     'bashls': {
    \         'command': s:Tool('bash-language-server'), 'args': ['start'],
    \         'filetypes': ['sh', 'bash'],
    \     },
    \     'taplo': {
    \         'command': s:Tool('taplo'), 'args': ['lsp', 'stdio'],
    \         'filetypes': ['toml'],
    \         'rootPatterns': ['.taplo.toml', 'taplo.toml', '.git'],
    \     },
    \     'texlab': {
    \         'command': s:Tool('texlab'),
    \         'filetypes': ['tex', 'bib', 'plaintex'],
    \         'rootPatterns': ['.latexmkrc', '.texlabroot', '.git'],
    \     },
    \     'typos': {
    \         'command': s:Tool('typos-lsp'),
    \         'filetypes': ['*'],
    \         'initializationOptions': {'diagnosticSeverity': 'Hint'},
    \     },
    \ },
    \ }

" Completion keys as in neovim's blink.cmp:
"   Tab     Copilot suggestion first, then accept the menu item, else Tab
"   C-j/C-k next / previous menu item
"   Enter   always a new line (never accepts)
"   Tab / S-Tab also jump through snippet fields while a snippet is active
let g:copilot_no_tab_map = v:true
let g:coc_snippet_next = '<Tab>'
let g:coc_snippet_prev = '<S-Tab>'

function! s:CopilotVisible() abort
    return exists('*copilot#GetDisplayedSuggestion')
        \ && !empty(copilot#GetDisplayedSuggestion().text)
endfunction

inoremap <silent><expr> <Tab>
    \ <SID>CopilotVisible() ? copilot#Accept("") :
    \ coc#pum#visible() ? coc#pum#confirm() : "\<Tab>"
inoremap <silent><expr> <C-j> coc#pum#visible() ? coc#pum#next(1) : "\<C-j>"
inoremap <silent><expr> <C-k> coc#pum#visible() ? coc#pum#prev(1) : "\<C-k>"
inoremap <silent><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : "\<C-e>"
inoremap <silent><expr> <CR>  "\<C-g>u\<CR>\<C-r>=coc#on_enter()\<CR>"

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
" <M-e> is end-of-line in insert mode (neovim), not auto-pairs' fast wrap
let g:AutoPairsShortcutFastWrap = ''

" ============================================================================
" COPILOT — Alt-] / Alt-[ cycle suggestions, Ctrl-] dismisses (same as neovim)
" ============================================================================
" Use the newest Node from nvm, like neovim's copilot.lua
let s:nvm_nodes = sort(glob('~/.nvm/versions/node/*/bin/node', 0, 1))
if !empty(s:nvm_nodes)
    let g:copilot_node_command = s:nvm_nodes[-1]
endif

" ============================================================================
" VIM-TMUX-NAVIGATOR — Ctrl-h/j/k/l (mapped by the plugin)
" ============================================================================
let g:tmux_navigator_no_wrap = 1

" ============================================================================
" CONTEXT.VIM — function header stays on top while scrolling (<leader>uc)
" ============================================================================
let g:context_max_height = 3

" ============================================================================
" VIMTEX — same settings as neovim's latex.lua
" ============================================================================
let g:vimtex_compiler_method = 'latexmk'
let g:vimtex_view_method = 'zathura'

" ============================================================================
" SPLITJOIN — keys set in KEYMAPS (<leader>cs / <leader>cj / <leader>m)
" ============================================================================
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''

" ============================================================================
" STARTIFY — start screen like neovim's dashboard
" ============================================================================
let g:startify_change_to_dir = 0

" "GINKO'S VIM" logo in the "ANSI Shadow" style (same font as Neovim's
" dashboard; the font has no apostrophe, so that one is drawn to match).
" One row when the window is wide enough, else two rows.
let s:logo_wide = [
    \ ' ██████╗ ██╗███╗   ██╗██╗  ██╗ ██████╗ ██╗███████╗    ██╗   ██╗██╗███╗   ███╗',
    \ '██╔════╝ ██║████╗  ██║██║ ██╔╝██╔═══██╗╚═╝██╔════╝    ██║   ██║██║████╗ ████║',
    \ '██║  ███╗██║██╔██╗ ██║█████╔╝ ██║   ██║   ███████╗    ██║   ██║██║██╔████╔██║',
    \ '██║   ██║██║██║╚██╗██║██╔═██╗ ██║   ██║   ╚════██║    ╚██╗ ██╔╝██║██║╚██╔╝██║',
    \ '╚██████╔╝██║██║ ╚████║██║  ██╗╚██████╔╝   ███████║     ╚████╔╝ ██║██║ ╚═╝ ██║',
    \ ' ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝    ╚══════╝      ╚═══╝  ╚═╝╚═╝     ╚═╝',
    \ ]
let s:logo_stacked = [
    \ ' ██████╗ ██╗███╗   ██╗██╗  ██╗ ██████╗ ██╗███████╗',
    \ '██╔════╝ ██║████╗  ██║██║ ██╔╝██╔═══██╗╚═╝██╔════╝',
    \ '██║  ███╗██║██╔██╗ ██║█████╔╝ ██║   ██║   ███████╗',
    \ '██║   ██║██║██║╚██╗██║██╔═██╗ ██║   ██║   ╚════██║',
    \ '╚██████╔╝██║██║ ╚████║██║  ██╗╚██████╔╝   ███████║',
    \ ' ╚═════╝ ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝ ╚═════╝    ╚══════╝',
    \ '',
    \ '             ██╗   ██╗██╗███╗   ███╗',
    \ '             ██║   ██║██║████╗ ████║',
    \ '             ██║   ██║██║██╔████╔██║',
    \ '             ╚██╗ ██╔╝██║██║╚██╔╝██║',
    \ '              ╚████╔╝ ██║██║ ╚═╝ ██║',
    \ '               ╚═══╝  ╚═╝╚═╝     ╚═╝',
    \ ]

function! GinkoLogo() abort
    let l:logo = &columns >= max(map(copy(s:logo_wide), 'strdisplaywidth(v:val)')) + 4
        \ ? s:logo_wide : s:logo_stacked
    return startify#center(l:logo)
endfunction
" A string is evaluated each time the start screen is drawn, so the logo
" follows the current window width
let g:startify_custom_header = 'GinkoLogo()'

let g:startify_files_number = 8
let g:startify_skiplist = ['^/tmp', '\.git/', 'COMMIT_EDITMSG']

" Recent files outside the current folder. Startify's own 'files' list would
" repeat the ones already shown under 'Recent in <folder>'.
function! s:RecentOutsideFolder() abort
    let l:folder = getcwd() . '/'
    let l:entries = []
    for l:file in v:oldfiles
        let l:path = fnamemodify(l:file, ':p')
        if stridx(l:path, l:folder) == 0 || !filereadable(l:path)
            \ || !empty(filter(copy(g:startify_skiplist), 'l:path =~# v:val'))
            continue
        endif
        call add(l:entries, {'line': fnamemodify(l:path, ':~'), 'path': l:path})
        if len(l:entries) >= g:startify_files_number
            break
        endif
    endfor
    return l:entries
endfunction

let g:startify_lists = [
    \ {'type': 'commands', 'header': ['   Actions']},
    \ {'type': 'dir',      'header': ['   Recent in ' . fnamemodify(getcwd(), ':~')]},
    \ {'type': function('s:RecentOutsideFolder'), 'header': ['   Recent elsewhere']},
    \ ]
" Hide startify's own [e] empty buffer and [q] quit (the menu has n and q)
let g:startify_enable_special = 0

" Logo colours: one shade per line, leaf green at the top to autumn gold at
" the bottom, like a ginkgo leaf. [gui colour, 256-colour terminal number]
let s:logo_colours = [
    \ ['#6a994e', 107], ['#86a64d', 107], ['#a3b34c', 143],
    \ ['#bfbf4d', 143], ['#d9c14e', 185], ['#f2c14e', 221],
    \ ]

function! s:DefineLogoColours() abort
    for l:index in range(len(s:logo_colours))
        let [l:gui, l:cterm] = s:logo_colours[l:index]
        execute printf('highlight GinkoLogo%d guifg=%s ctermfg=%d gui=bold cterm=bold',
            \ l:index + 1, l:gui, l:cterm)
    endfor
    highlight link StartifyHeader GinkoLogo1
endfunction

" Colour each logo line on the start screen with its own shade. Each 6-line
" block of letters runs green to gold. (startify#center only adds spaces on
" the left, so each screen line ends with its logo line.)
function! s:ColourLogo() abort
    let l:shade_by_line = {}
    for l:logo in [s:logo_wide, s:logo_stacked]
        let l:row = 0
        for l:logo_line in l:logo
            if empty(l:logo_line)
                let l:row = 0
                continue
            endif
            let l:shade_by_line[l:logo_line] = l:row % len(s:logo_colours) + 1
            let l:row += 1
        endfor
    endfor
    for l:line_number in range(1, min([line('$'), 25]))
        let l:text = substitute(getline(l:line_number), '^ *', '', '')
        for [l:logo_line, l:shade] in items(l:shade_by_line)
            if l:text ==# substitute(l:logo_line, '^ *', '', '')
                call matchadd('GinkoLogo' . l:shade, '\%' . l:line_number . 'l\S.*')
                break
            endif
        endfor
    endfor
endfunction

augroup startify_colours
    autocmd!
    " :colorscheme clears custom highlights, so define them again after it
    autocmd ColorScheme * call s:DefineLogoColours()
    autocmd User Startified call s:ColourLogo()
augroup END
call s:DefineLogoColours()

let g:startify_commands = [
    \ {'f': ['Find File',       'Files']},
    \ {'g': ['Find Text',       'Rg']},
    \ {'r': ['Recent Files',    'History']},
    \ {'n': ['New File',        'enew']},
    \ {'s': ['Restore Session', 'call SessionRestore(0)']},
    \ {'c': ['Edit Config',     'edit $MYVIMRC']},
    \ {'q': ['Quit',            'qa']},
    \ ]

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
" KEYMAPS — same keys as neovim (neovim/.config/nvim/lua/system/kernel/keymap.lua
" and the plugin specs). Where Vim has no matching plugin, the key is left out.
" ============================================================================
let mapleader = " "

" Terminal Vim sees Alt+key as Esc+key; teach it the Alt keys used below
if !has('nvim') && !has('gui_running')
    for s:key in ['e', 'j', 'k']
        execute "set <M-" . s:key . ">=\e" . s:key
    endfor
endif

" ============================================================================
" VIM-WHICH-KEY
" ============================================================================
nnoremap <silent> <leader> :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :<c-u>WhichKeyVisual '<Space>'<CR>
call which_key#register('<Space>', 'g:which_key_map')

let g:which_key_map = {}

let g:which_key_map[' '] = 'clear highlight'
let g:which_key_map['i'] = 'indent all'
let g:which_key_map['e'] = 'explorer toggle'
let g:which_key_map['o'] = 'explorer focus'
let g:which_key_map['r'] = 'explorer reveal file'
let g:which_key_map['p'] = 'command palette'
let g:which_key_map['|'] = 'vertical split'
let g:which_key_map['-'] = 'horizontal split'
let g:which_key_map['y'] = 'yank to clipboard'

let g:which_key_map.b = { 'name': '+buffer', 'd': 'delete' }

let g:which_key_map['m'] = 'split/join toggle'

let g:which_key_map.c = {
    \ 'name': '+code',
    \ 'h': 'switch source/header',
    \ 's': 'split lines',
    \ 'j': 'join lines',
    \ }

let g:which_key_map.d = {
    \ 'name': '+debug (gdb)',
    \ 'c': 'start / continue',
    \ 'b': 'toggle breakpoint',
    \ 's': 'step over',
    \ 'i': 'step into',
    \ 'o': 'step out',
    \ 'e': 'evaluate',
    \ 't': 'stop program',
    \ }

let g:which_key_map.L = { 'name': '+latex', 'c': 'compile', 'v': 'view' }

let g:which_key_map.q = {
    \ 'name': '+session',
    \ 's': 'restore this folder',
    \ 'l': 'restore last',
    \ 'd': "don't save on exit",
    \ }

let g:which_key_map.f = {
    \ 'name': '+find',
    \ 'f': 'files',
    \ 'g': 'live grep',
    \ 'b': 'buffers',
    \ 'h': 'file history',
    \ '*': 'grep word → quickfix',
    \ 'l': 'buffer lines',
    \ 'L': 'all lines',
    \ 'm': 'mappings',
    \ }

let g:which_key_map.l = {
    \ 'name': '+lsp',
    \ 'a': 'code action',
    \ 'd': 'definition',
    \ 'f': 'format (ALE fixers)',
    \ 'h': 'toggle inlay hints',
    \ 'i': 'lsp info',
    \ 'o': 'outline',
    \ 'r': 'rename',
    \ 's': 'symbols',
    \ }

let g:which_key_map.g = {
    \ 'name': '+git',
    \ 'g': 'lazygit',
    \ 's': 'stage hunk',
    \ 'r': 'reset hunk',
    \ 'S': 'stage buffer',
    \ 'R': 'reset buffer',
    \ 'p': 'preview hunk',
    \ 'b': 'blame',
    \ 'd': 'diff this',
    \ 'H': 'file history',
    \ 'l': 'log',
    \ }

let g:which_key_map.s = {
    \ 'name': '+search/settings',
    \ 'r': 'replace word in project',
    \ 'R': 'search & replace in project',
    \ 'e': 'edit vimrc',
    \ 'v': 'reload vimrc',
    \ }

let g:which_key_map.u = {
    \ 'name': '+toggle',
    \ 'd': 'diagnostics',
    \ 'c': 'context header',
    \ 'l': 'relative numbers',
    \ 's': 'spell check',
    \ 'u': 'undotree',
    \ 'w': 'show whitespace',
    \ }

let g:which_key_map.w = {
    \ 'name': '+window',
    \ 'v': 'vsplit',
    \ 'h': 'split',
    \ 'q': 'close',
    \ 'o': 'only',
    \ '=': 'equalize',
    \ }

let g:which_key_map.x = {
    \ 'name': '+diagnostics/quickfix',
    \ 'd': 'line diagnostics',
    \ 'x': 'all diagnostics',
    \ 't': 'todos → quickfix',
    \ 'T': 'todos → fzf',
    \ 'q': 'toggle quickfix',
    \ 'l': 'toggle loclist',
    \ }

let g:which_key_map.t = {
    \ 'name': '+terminal',
    \ 'f': 'float terminal',
    \ 'h': 'horizontal terminal',
    \ 'v': 'vertical terminal',
    \ }

" --- Escape ---
inoremap jk <Esc>
inoremap kj <Esc>
nnoremap <silent> <leader><leader> :nohlsearch<CR>
" neovim clears the search highlight on <Esc>. Neovim only: in terminal Vim,
" mapping <Esc> breaks arrow keys and terminal replies (which start with Esc).
if has('nvim')
    nnoremap <silent> <Esc> :nohlsearch<CR><Esc>
endif

" --- Terminal mode (like neovim: Ctrl-h/j/k/l leave the terminal, into other
" splits or tmux panes) ---
" A double Esc drops to Normal mode; a single Esc still reaches the program
" (lazygit, fzf, ...).
if has('nvim')
    tnoremap <Esc><Esc> <C-\><C-n>
    tnoremap <silent> <C-h> <C-\><C-n>:TmuxNavigateLeft<CR>
    tnoremap <silent> <C-j> <C-\><C-n>:TmuxNavigateDown<CR>
    tnoremap <silent> <C-k> <C-\><C-n>:TmuxNavigateUp<CR>
    tnoremap <silent> <C-l> <C-\><C-n>:TmuxNavigateRight<CR>
else
    tnoremap <Esc><Esc> <C-w>N
    tnoremap <silent> <C-h> <C-w>:TmuxNavigateLeft<CR>
    tnoremap <silent> <C-j> <C-w>:TmuxNavigateDown<CR>
    tnoremap <silent> <C-k> <C-w>:TmuxNavigateUp<CR>
    tnoremap <silent> <C-l> <C-w>:TmuxNavigateRight<CR>
endif

" --- Buffers ---
" neovim also puts next/previous buffer on <Tab>/<S-Tab>. Left out here: in a
" terminal <Tab> is the same key as <C-i> (jump forward).
nnoremap [b         :bprevious<CR>
nnoremap ]b         :bnext<CR>
nnoremap <leader>bd :call BufDel()<CR>

" --- Windows ---
" Ctrl-h/j/k/l come from vim-tmux-navigator (also moves into tmux panes)
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

" --- File explorer (neovim: neo-tree) ---
nnoremap <leader>e  :call ToggleExplorer()<CR>
nnoremap <leader>o  :NERDTreeFocus<CR>
nnoremap <leader>r  :NERDTreeFind<CR>

" --- Find (neovim: fzf-lua) ---
nnoremap <C-p>      :Files<CR>
nnoremap <leader>ff :Files<CR>
nnoremap <leader>fg :Rg<CR>
nnoremap <leader>fb :Buffers<CR>
nnoremap <leader>fh :History<CR>
nnoremap <leader>f* :grep! "\b<C-r><C-w>\b"<CR>
nnoremap <leader>fl :BLines<CR>
nnoremap <leader>fL :Lines<CR>
nnoremap <leader>fm :Maps<CR>
nnoremap <leader>p  :Commands<CR>

" --- LSP (coc.nvim) ---
nmap <silent> gd         <Plug>(coc-definition)
nmap <silent> gD         <Plug>(coc-declaration)
nmap <silent> gy         <Plug>(coc-type-definition)
nmap <silent> gi         <Plug>(coc-implementation)
nmap <silent> gr         <Plug>(coc-references)
nmap <silent> [d         <Plug>(coc-diagnostic-prev)
nmap <silent> ]d         <Plug>(coc-diagnostic-next)
nnoremap <silent> K      :call ShowDocumentation()<CR>
inoremap <silent> <C-s>  <C-r>=CocActionAsync('showSignatureHelp')<CR>
nmap <leader>la          <Plug>(coc-codeaction-cursor)
nmap <leader>ld          <Plug>(coc-definition)
" Format with the same tools as format-on-save (neovim: conform)
nnoremap <leader>lf      :ALEFix<CR>
nnoremap <leader>lh      :CocCommand document.toggleInlayHint<CR>
nnoremap <leader>li      :CocInfo<CR>
nnoremap <leader>lo      :TagbarToggle<CR>
nmap <leader>lr          <Plug>(coc-rename)
nnoremap <leader>ls      :CocList -I symbols<CR>
nnoremap <leader>ch      :CocCommand clangd.switchSourceHeader<CR>

" --- Code: split / join (neovim: treesj) ---
nnoremap <silent> <leader>m  :call SplitJoinToggle()<CR>
nnoremap <silent> <leader>cs :SplitjoinSplit<CR>
nnoremap <silent> <leader>cj :SplitjoinJoin<CR>

" --- LaTeX (vimtex) ---
nnoremap <leader>Lc :VimtexCompile<CR>
nnoremap <leader>Lv :VimtexView<CR>

" COC text objects: function and class
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" --- Diagnostics / quickfix ---
nmap <silent> <leader>xd     <Plug>(coc-diagnostic-info)
nnoremap <leader>xx          :CocList diagnostics<CR>
nnoremap <silent> <leader>xq :call ToggleQuickfix()<CR>
nnoremap <silent> <leader>xl :call ToggleLocList()<CR>
nnoremap <silent> ]q         :call QuickfixStep(1)<CR>
nnoremap <silent> [q         :call QuickfixStep(0)<CR>

" --- TODO comments (neovim: todo-comments) ---
nnoremap <silent> ]t         :call search(g:todo_pattern, 'W')<CR>
nnoremap <silent> [t         :call search(g:todo_pattern, 'bW')<CR>
nnoremap <silent> <leader>xt :call TodoQuickfix()<CR>
nnoremap <silent> <leader>xT :call TodoFzf()<CR>

" --- Sessions (neovim: persistence) — saved per folder when Vim quits ---
nnoremap <silent> <leader>qs :call SessionRestore(0)<CR>
nnoremap <silent> <leader>ql :call SessionRestore(1)<CR>
nnoremap <silent> <leader>qd :let g:session_save_on_exit = 0 <Bar> echo 'Session will not be saved on exit'<CR>

" --- Debug (neovim: nvim-dap; here Vim's built-in termdebug for gdb) ---
nnoremap <silent> <leader>dc :call DebugContinue()<CR>
nnoremap <silent> <leader>db :call DebugToggleBreakpoint()<CR>
nnoremap <silent> <leader>ds :call DebugCommand('Over')<CR>
nnoremap <silent> <leader>di :call DebugCommand('Step')<CR>
nnoremap <silent> <leader>do :call DebugCommand('Finish')<CR>
nnoremap <silent> <leader>dt :call DebugStop()<CR>
nnoremap <silent> <leader>de :call DebugCommand('Evaluate')<CR>

" --- Git (neovim: gitsigns + lazygit) ---
" Staging, commits, diffs and history are done in lazygit; these keys only
" cover what lazygit can't do from inside the file
nnoremap <silent> <leader>gg :call OpenLazygit()<CR>
nmap [h <Plug>(GitGutterPrevHunk)
nmap ]h <Plug>(GitGutterNextHunk)
nmap <leader>gr <Plug>(GitGutterUndoHunk)
nmap <leader>gp <Plug>(GitGutterPreviewHunk)
nnoremap <leader>gb :Git blame<CR>
" Hunk text object (neovim: ih)
omap ih <Plug>(GitGutterTextObjectInnerPending)
xmap ih <Plug>(GitGutterTextObjectInnerVisual)

" --- Search & replace across the project (neovim: grug-far) ---
" Asks for the new text, finds matches with rg, then asks at each match.
nnoremap <silent> <leader>sr :call ReplaceInProject(expand('<cword>'), 1)<CR>
vnoremap <silent> <leader>sr y:call ReplaceInProject(@", 0)<CR>
nnoremap <silent> <leader>sR :call ReplaceInProject(input('Search: '), 0)<CR>

" --- Toggles ---
nnoremap <silent> <leader>us :setlocal spell! spelllang=en_us<CR>
nnoremap <silent> <leader>ud :call ToggleCocDiagnostics()<CR>
nnoremap <silent> <leader>uu :UndotreeToggle<CR>
nnoremap <silent> <leader>ul :call ToggleLineNumbers()<CR>
nnoremap <silent> <leader>uw :set list!<CR>
nnoremap <silent> <leader>uc :ContextToggle<CR>

" --- Terminal (neovim: toggleterm) ---
if has('nvim')
    nnoremap <leader>th :botright split +terminal <Bar> resize 12<CR>
    nnoremap <leader>tv :botright vsplit +terminal<CR>
else
    nnoremap <leader>th :botright terminal ++rows=12<CR>
    nnoremap <leader>tv :vertical terminal<CR>
endif
nnoremap <silent> <leader>tf :call OpenFloatTerm()<CR>

" --- Editing ---
nnoremap <leader>i  gg=G''
nnoremap <leader>se :edit $MYVIMRC<CR>
nnoremap <leader>sv :source $MYVIMRC<CR>

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

" Centre screen on search results
nnoremap n nzzzv
nnoremap N Nzzzv

" Insert mode: <M-e> jumps to end of line (neovim), <C-l> moves right
inoremap <M-e> <Esc>A
inoremap <C-l> <Right>

" --- Jump (neovim: flash s/S; here: easymotion) ---
nmap s <Plug>(easymotion-s2)
nmap S <Plug>(easymotion-overwin-f2)

" ============================================================================
" AUTOCOMMANDS
" ============================================================================
augroup vimrc
    autocmd!

    " Auto-save on leaving insert mode or losing focus (like neovim)
    autocmd InsertLeave,FocusLost * if &modified && expand('%') !=# '' && &buftype ==# '' | silent! update | endif

    " Flash the yanked text briefly (neovim: vim.hl.on_yank)
    autocmd TextYankPost * call FlashYank()

    " Strip trailing whitespace on save, keeping the cursor (like neovim).
    " Markdown is skipped: two trailing spaces there mean a line break.
    autocmd BufWritePre * if &buftype ==# '' && &filetype !=# 'markdown' |
        \     let s:view = winsaveview() |
        \     keepjumps keeppatterns %s/\s\+$//e |
        \     call winrestview(s:view) |
        \ endif

    " Highlight TODO / FIXME / NOTE ... keywords in every buffer
    autocmd BufWinEnter,WinNew * call HighlightTodos()

    " Save a session for this folder when quitting (like persistence.nvim)
    autocmd VimLeavePre * call SessionSave()


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

    " Open the quickfix list after :grep (used by <leader>f*)
    autocmd QuickFixCmdPost [^l]* cwindow

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

" Toggle the quickfix list (mirrors neovim's <leader>xq)
function! ToggleQuickfix()
    if getqflist({'winid': 0}).winid != 0
        cclose
    else
        copen
    endif
endfunction

" Toggle the location list (mirrors neovim's <leader>xl)
function! ToggleLocList()
    if getloclist(0, {'winid': 0}).winid != 0
        lclose
    elseif empty(getloclist(0))
        echo 'No location list'
    else
        lopen
    endif
endfunction

" Toggle coc.nvim diagnostics for the current buffer (mirrors neovim's <leader>ud)
function! ToggleCocDiagnostics()
    if get(b:, 'coc_diagnostic_disable', 0)
        let b:coc_diagnostic_disable = 0
        echo 'Diagnostics: ON'
    else
        let b:coc_diagnostic_disable = 1
        echo 'Diagnostics: OFF'
    endif
    silent! call CocActionAsync('diagnosticRefresh')
endfunction

" --- Split / join (neovim: treesj toggle) ---
function! SplitJoinToggle() abort
    let l:tick = b:changedtick
    silent! SplitjoinJoin
    if b:changedtick == l:tick
        silent! SplitjoinSplit
    endif
endfunction

" --- TODO comments (neovim: todo-comments) ---
let s:todo_words = 'TODO|FIX|FIXME|BUG|ISSUE|HACK|PERF|OPTIM|NOTE|INFO|TEST'
let g:todo_pattern = '\v<(' . s:todo_words . ')>\s*:'
let s:todo_rg = '\b(' . s:todo_words . ')\b\s*:'

function! HighlightTodos() abort
    if exists('w:todo_matches')
        return
    endif
    let w:todo_matches = [
        \ matchadd('ErrorMsg',   '\v<(FIX|FIXME|BUG|ISSUE)>\ze\s*:'),
        \ matchadd('WarningMsg', '\v<(HACK|PERF|OPTIM)>\ze\s*:'),
        \ matchadd('Todo',       '\v<(TODO|NOTE|INFO|TEST)>\ze\s*:'),
        \ ]
endfunction

function! TodoQuickfix() abort
    " | must be escaped too, or :grep ends the command there
    silent execute 'grep! -e ' . escape(shellescape(s:todo_rg, 1), '|')
    redraw!
endfunction

function! TodoFzf() abort
    call fzf#vim#grep('rg --column --line-number --no-heading --color=always --smart-case -e '
        \ . shellescape(s:todo_rg), 1)
endfunction

" --- Sessions (neovim: persistence.nvim) ---
" One session per folder in ~/.vim/sessions, saved when Vim quits.
set sessionoptions=buffers,curdir,tabpages,winsize
let s:session_dir = expand('~/.vim/sessions/')
let g:session_save_on_exit = 1

function! s:SessionFile() abort
    return s:session_dir . substitute(getcwd(), '/', '%', 'g') . '.vim'
endfunction

function! SessionSave() abort
    let l:has_files = !empty(filter(getbufinfo({'buflisted': 1}), 'v:val.name !=# ""'))
    if !g:session_save_on_exit || !l:has_files
        return
    endif
    call mkdir(s:session_dir, 'p')
    " Side panels don't restore cleanly; close them first
    silent! NERDTreeClose
    silent! TagbarClose
    silent! UndotreeHide
    execute 'mksession! ' . fnameescape(s:SessionFile())
    call writefile([s:SessionFile()], s:session_dir . 'last')
endfunction

function! SessionRestore(last) abort
    let l:file = s:SessionFile()
    if a:last
        let l:last_file = s:session_dir . 'last'
        let l:file = filereadable(l:last_file) ? get(readfile(l:last_file), 0, '') : ''
    endif
    if !filereadable(l:file)
        echo a:last ? 'No last session' : 'No session for this directory'
        return
    endif
    execute 'source ' . fnameescape(l:file)
endfunction

" --- Debug with gdb (neovim: nvim-dap). Uses Vim's built-in termdebug. ---
function! DebugContinue() abort
    if exists(':Continue')
        Continue
        return
    endif
    let l:program = input('Program to debug: ', '', 'file')
    if empty(l:program)
        return
    endif
    packadd termdebug
    execute 'Termdebug ' . fnameescape(l:program)
    if exists(':Run')
        Run
    endif
endfunction

function! DebugCommand(command) abort
    if exists(':' . a:command)
        execute a:command
    else
        echo 'No debug session. Start one with <leader>dc'
    endif
endfunction

function! DebugToggleBreakpoint() abort
    if !exists(':Break')
        echo 'No debug session. Start one with <leader>dc'
        return
    endif
    let l:signs = sign_getplaced(bufnr('%'), {'group': 'TermDebug', 'lnum': line('.')})
    if !empty(l:signs[0].signs)
        Clear
    else
        Break
    endif
endfunction

function! DebugStop() abort
    if exists('*TermDebugSendCommand')
        call TermDebugSendCommand('kill')
    else
        echo 'No debug session'
    endif
endfunction

" --- Project-wide search & replace (neovim: grug-far) ---
" Finds a:text with rg, then asks at each match. a:whole_word matches whole
" words only (used for the word under the cursor).
function! ReplaceInProject(text, whole_word) abort
    let l:text = split(a:text, "\n", 1)[0]
    if empty(l:text)
        return
    endif
    let l:new_text = input('Replace "' . l:text . '" with: ')
    if empty(l:new_text) && confirm('Replace with nothing?', "&Yes\n&No", 2) != 1
        return
    endif
    let l:flags = '--fixed-strings --case-sensitive' . (a:whole_word ? ' --word-regexp' : '')
    silent execute 'grep! ' . l:flags . ' -- ' . escape(shellescape(l:text, 1), '|')
    redraw!
    if empty(getqflist())
        echo 'No matches for "' . l:text . '"'
        return
    endif
    let l:pattern = '\V\C' . (a:whole_word ? '\<' : '') . escape(l:text, '/\')
        \ . (a:whole_word ? '\>' : '')
    execute 'cfdo %s/' . l:pattern . '/' . escape(l:new_text, '/\&~') . '/gce | update'
endfunction

" --- Flash yanked text for 200 ms (neovim: vim.hl.on_yank) ---
function! FlashYank() abort
    let [l:start_line, l:start_col] = [line("'["), col("'[")]
    let [l:end_line, l:end_col] = [line("']"), col("']")]
    if v:event.regtype ==# 'V'
        let l:pattern = '\%>' . (l:start_line - 1) . 'l\%<' . (l:end_line + 1) . 'l.*'
    else
        let l:pattern = '\%' . l:start_line . 'l\%' . l:start_col . 'c\_.*\%'
            \ . l:end_line . 'l\%' . l:end_col . 'c.'
    endif
    let l:window = win_getid()
    let l:match = matchadd('IncSearch', l:pattern)
    " silent!: the window may be gone by the time the timer runs
    call timer_start(200, {-> execute('silent! call matchdelete(' . l:match . ', ' . l:window . ')')})
endfunction

" Toggle NERDTree, or netrw before the plugins are installed
function! ToggleExplorer()
    if exists(':NERDTreeToggle') | exec 'NERDTreeToggle' | else | exec 'Lexplore' | endif
endfunction

" Step through the quickfix list, wrapping at the ends (mirrors neovim's ]q / [q)
function! QuickfixStep(forward) abort
    try
        execute a:forward ? 'cnext' : 'cprevious'
    catch /E553/
        execute a:forward ? 'cfirst' : 'clast'
    catch /E42\|E776/
        echo 'Quickfix list is empty'
    endtry
endfunction

" Floating terminal running a:1 or the shell (mirrors neovim's <leader>tf).
" Vim uses a popup window, Neovim a floating window. The window closes when
" the program exits.
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
        " Let a single Esc reach the program (lazygit uses it)
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

" lazygit in a floating terminal (mirrors neovim's <leader>gg); falls back to
" fugitive's status window when lazygit isn't installed
function! OpenLazygit() abort
    if executable('lazygit')
        call OpenFloatTerm('lazygit')
    else
        Git
    endif
endfunction
