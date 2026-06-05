
#!/usr/bin/env bash
# ===============================================================
# Professional Vim setup script (Arch, Ubuntu, Fedora, macOS)
# Author: Ginko
# Purpose: Build a clean, professional Vim environment safely
# ===============================================================

set -e

echo ">>> Starting Vim setup..."

# ────────────────────────────────────────────────────────────────
# 1. Detect and install Vim + dependencies
# ────────────────────────────────────────────────────────────────
echo ">>> Installing Vim and essential tools..."
if command -v apt-get &>/dev/null; then
    sudo apt-get update -y
    sudo apt-get install -y vim curl git build-essential ripgrep
elif command -v pacman &>/dev/null; then
    sudo pacman -Sy --needed --noconfirm vim curl git base-devel ripgrep
elif command -v dnf &>/dev/null; then
    sudo dnf install -y vim curl git make gcc ripgrep
elif command -v brew &>/dev/null; then
    brew install vim curl git ripgrep
else
    echo "⚠️  Warning: Unsupported system. Please install vim, curl, git manually."
fi

# ────────────────────────────────────────────────────────────────
# 2. Create Vim directory structure
# ────────────────────────────────────────────────────────────────
VIM_DIR="$HOME/.vim"
mkdir -p "$VIM_DIR/autoload" "$VIM_DIR/plugged"

# ────────────────────────────────────────────────────────────────
# 3. Install vim-plug
# ────────────────────────────────────────────────────────────────
PLUG_FILE="$VIM_DIR/autoload/plug.vim"
if [ ! -f "$PLUG_FILE" ]; then
    echo ">>> Installing vim-plug..."
    curl -fLo "$PLUG_FILE" --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
else
    echo ">>> vim-plug already exists."
fi

# ────────────────────────────────────────────────────────────────
# 4. Write ~/.vimrc configuration
# ────────────────────────────────────────────────────────────────
echo ">>> Writing ~/.vimrc configuration..."
cat <<'EOF' > ~/.vimrc
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
Plug 'dense-analysis/ale'

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
nnoremap <C-n> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

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

# ────────────────────────────────────────────────────────────────
# 5. Install Vim plugins safely (headless)
# ────────────────────────────────────────────────────────────────
echo ">>> Installing Vim plugins via vim-plug..."
if command -v vim &>/dev/null; then
    vim -E -s -u "$HOME/.vimrc" +PlugInstall +qall || true
else
    echo "⚠️ Vim not found — skipping plugin installation."
fi

# ────────────────────────────────────────────────────────────────
# 6. Final message
# ────────────────────────────────────────────────────────────────
echo "✅ Vim setup complete!"
echo "Open Vim and enjoy your clean environment."
echo "Tip: use ':PlugUpdate' anytime to refresh plugins."
