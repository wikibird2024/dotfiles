
#!/usr/bin/env bash
# ===============================================================
# Comprehensive Vim setup script (No Python interference)
# Author: Ginko
# Purpose: Set up a professional Vim environment safely
# ===============================================================

set -e

echo ">>> Starting Vim setup..."

# ─── 1. Install Vim and dependencies (No Python) ──────────────────────────────
echo ">>> Installing Vim and essential build tools..."
if command -v apt-get &>/dev/null; then
    sudo apt-get update
    sudo apt-get install -y vim curl build-essential git
elif command -v dnf &>/dev/null; then
    sudo dnf install -y vim curl make gcc git
elif command -v brew &>/dev/null; then
    brew install vim curl git make gcc
else
    echo "Warning: Package manager not found. Please install vim, curl, and build-essential manually."
fi

# ─── 2. Create Vim directory structure ───────────────────────────────────────
echo ">>> Creating Vim configuration directories..."
VIM_DIR="$HOME/.vim"
mkdir -p "$VIM_DIR/autoload"

# ─── 3. Install vim-plug ─────────────────────────────────────────────────────
echo ">>> Installing vim-plug..."
PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
if [ ! -f "$VIM_DIR/autoload/plug.vim" ]; then
    curl -fLo "$VIM_DIR/autoload/plug.vim" --create-dirs "$PLUG_URL"
    echo "vim-plug installed successfully."
else
    echo "vim-plug is already installed."
fi

# ─── 4. Create or overwrite ~/.vimrc ─────────────────────────────────────────
echo ">>> Writing professional ~/.vimrc configuration..."
cat << 'EOF' > ~/.vimrc
"=============================================================================
" VIM PROFESSIONAL SETUP — GINKO EDITION
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

" ─── Syntax and Linting ──────────────────────────────────────────────────────
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale' " Async linting

" ─── Aesthetics ───────────────────────────────────────────────────────────────
Plug 'joshdick/onedark.vim'

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

" Leader Key
let mapleader = ' '
let g:mapleader = ' '

" Colorscheme
colorscheme onedark

"=============================================================================
" PLUGIN-SPECIFIC SETTINGS
"=============================================================================
" NERDTree
map <C-n> :NERDTreeToggle<CR>
map <C-f> :NERDTreeFind<CR>

" FZF
nnoremap <C-p> :Files<CR>
nnoremap <C-g> :Rg<CR>

" Airline
let g:airline_powerline_fonts = 1
let g:airline_theme='onedark'

" GitGutter
let g:gitgutter_sign_added = '+'
let g:gitgutter_sign_modified = '~'
let g:gitgutter_sign_removed = '-'

" ALE linting indicators
let g:ale_sign_error = '✗'
let g:ale_sign_warning = '⚠'
let g:ale_fix_on_save = 1
EOF

echo ">>> ~/.vimrc created successfully."

# ─── 5. Install plugins ──────────────────────────────────────────────────────
echo ">>> Installing Vim plugins..."
vim -E -s -u "$HOME/.vimrc" +PlugInstall +qall || true

echo ">>> Setup complete!"
echo "Open Vim and enjoy your clean environment. Use :PlugUpdate to refresh plugins."
