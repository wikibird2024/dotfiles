#!/bin/bash

# Exit immediately if a command exits with a non-zero status.
set -e

echo "--- Starting comprehensive Vim setup script ---"

# --- 1. Install Vim and build tools ---
echo "Installing Vim and essential build tools..."
if [ -x "$(command -v apt-get)" ]; then
    sudo apt-get update
    sudo apt-get install -y vim curl build-essential
elif [ -x "$(command -v dnf)" ]; then
    sudo dnf install -y vim curl make gcc
elif [ -x "$(command -v brew)" ]; then
    brew install vim curl
    brew install make gcc
else
    echo "Warning: Package manager not found. Please install vim, curl, and build-essential manually."
fi

# --- 2. Create Vim directory structure ---
echo "Creating Vim configuration directories..."
VIM_DIR="$HOME/.vim"
if [ ! -d "$VIM_DIR" ]; then
    mkdir -p "$VIM_DIR/autoload"
fi

# --- 3. Install vim-plug plugin manager ---
echo "Installing vim-plug..."
PLUG_URL="https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"
if [ ! -f "$VIM_DIR/autoload/plug.vim" ]; then
    curl -fLo "$VIM_DIR/autoload/plug.vim" --create-dirs "$PLUG_URL"
    echo "vim-plug installed successfully."
else
    echo "vim-plug is already installed."
fi

# --- 4. Create a comprehensive .vimrc file ---
echo "Creating/updating ~/.vimrc with a comprehensive configuration..."
cat << EOF > ~/.vimrc
"=============================================================================
" VIM-PLUG: Plugin Manager
"=============================================================================
call plug#begin('~/.vim/plugged')

" The Essentials
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'airblade/vim-gitgutter'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Syntax and Formatting
Plug 'sheerun/vim-polyglot'
"Plug 'ycm-core/YouCompleteMe' " Uncomment this and others if you need a specific completion engine
Plug 'dense-analysis/ale'

" Aesthetics
Plug 'joshdick/onedark.vim'

call plug#end()

"=============================================================================
" General Settings
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

" Set leader key to space
let mapleader = ' '
let g:mapleader = ' '

" Recommended to set a color scheme after plugin-manager setup
colorscheme onedark

"=============================================================================
" Plugin-Specific Settings
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
EOF

echo "--- Vim configuration file (~/.vimrc) created ---"

# --- 5. Install the plugins inside Vim ---
echo "Launching Vim to install plugins. Please wait for the process to finish."
vim -c 'PlugInstall' -c 'qa!'

echo "--- Vim plugins installed successfully ---"

echo "--- Setup complete! ---"
echo "You can now open vim and start coding. Use :PlugUpdate to update plugins."
