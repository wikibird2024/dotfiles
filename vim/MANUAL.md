# Vim Config Manual

**Leader key:** `Space`

---

## Setup

```bash
# First launch — install all plugins
vim
:PlugInstall

# coc extensions (pyright, clangd, etc.) auto-install on next startup
# For tagbar symbol support
sudo apt install universal-ctags
```

---

## Plugins

| Plugin | Role |
|---|---|
| gruvbox | Colorscheme |
| vim-airline | Statusline + tabline |
| NERDTree | File explorer |
| nerdtree-git-plugin | Git status icons in NERDTree |
| vim-devicons | File type icons |
| indentLine | Indent guides (`\|` characters) |
| undotree | Visual undo history tree |
| tagbar | Symbol/tag overview panel |
| fzf + fzf.vim | Fuzzy file/grep/buffer finder |
| vim-fugitive | Full git client inside vim |
| vim-gitgutter | Hunk signs in gutter (`+` `~` `-`) |
| coc.nvim | LSP: completion, diagnostics, rename, hover |
| vim-surround | Add/change/delete surrounding characters |
| vim-repeat | Repeat plugin actions with `.` |
| vim-commentary | Toggle comments with `gcc` / `gc` |
| auto-pairs | Auto-close brackets and quotes |
| vim-visual-multi | Multi-cursor editing |
| vim-easymotion | Jump to any position with 2 keystrokes |
| targets.vim | Extended text objects (args, separators) |
| vim-polyglot | Syntax highlight for 100+ languages |
| ale | Linter + fixer (runs on save) |

---

## Keybindings

### General

| Key | Action |
|---|---|
| `jk` / `kj` | Exit insert mode |
| `<Space><Space>` | Clear search highlight |
| `<Esc>` | Clear search highlight (matches nvim2) |
| `<leader>ev` | Edit vimrc |
| `<leader>sv` | Reload vimrc |
| `<leader>ln` | Toggle relative/absolute line numbers |

> Files auto-save on `BufLeave`/`FocusLost`, so there's no dedicated save key — same as nvim2 (which relies on its own auto-save autocommand). Use `:w` for an explicit save.

### Navigation — Windows & Splits

| Key | Action |
|---|---|
| `Ctrl-h/j/k/l` | Move between splits |
| `Ctrl-Up/Down` | Resize split height |
| `Ctrl-Left/Right` | Resize split width |
| `<leader>wv` | Vertical split |
| `<leader>wh` | Horizontal split |
| `<leader>wq` | Close window |
| `<leader>wo` | Close all other windows |
| `<leader>w=` | Equalize window sizes |

### Navigation — Buffers

| Key | Action |
|---|---|
| `[b` / `]b` | Previous / next buffer |
| `<Tab>` / `<S-Tab>` | Next / previous buffer |
| `<leader>bd` | Delete buffer (keeps window open) |

### File Explorer (NERDTree)

| Key | Action |
|---|---|
| `<leader>e` | Toggle NERDTree |
| `<leader>r` | Reveal current file in NERDTree |

Inside NERDTree: `o` open, `s` vertical split, `i` horizontal split, `ma` new file, `md` delete, `R` refresh, `I` toggle hidden files, `?` help.

### Fuzzy Finding (fzf)

| Key | Action |
|---|---|
| `Ctrl-p` / `<leader>ff` | Find files |
| `<leader>fg` | Grep across project (ripgrep) |
| `<leader>fb` | Open buffers |
| `<leader>fh` | File history (recently opened) |
| `<leader>fl` | Lines in current buffer |
| `<leader>fL` | Lines across all open buffers |
| `<leader>fc` | Available commands |
| `<leader>fm` | Key mappings |

Inside fzf popup: `Ctrl-j/k` navigate, `Enter` open, `Ctrl-v` vertical split, `Ctrl-x` horizontal split, `Ctrl-t` new tab.

### LSP — coc.nvim

Keys mirror nvim2's native-LSP layout: `gd`/`gr`/`gi`/`K` are identical in both configs; everything else is grouped under `<leader>l*`, diagnostic nav under `[d`/`]d`, and the full diagnostics list under `<leader>x*`.

| Key | Action |
|---|---|
| `Tab` | Next completion item |
| `Shift-Tab` | Previous completion item |
| `Enter` | Confirm selected completion |
| `Ctrl-Space` | Trigger completion manually |
| `K` | Show hover documentation |
| `gd` | Go to definition |
| `gD` | Go to declaration |
| `gy` | Go to type definition |
| `gi` | Go to implementation |
| `gr` | Show all references |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>lr` | Rename symbol |
| `<leader>ld` | Go to definition (alias of `gd`) |
| `<leader>la` | Code action at cursor |
| `<leader>lf` | Format file / selection |
| `<leader>li` | Show coc info (`:CocInfo`) |
| `<leader>lo` | Show file outline |
| `<leader>ls` | Search workspace symbols |
| `<leader>xd` | List all diagnostics |

**Text objects (works with `d`, `c`, `v`, `y`):**

| Object | Selects |
|---|---|
| `if` / `af` | Inside / around function |
| `ic` / `ac` | Inside / around class |

**LSP extensions installed:**

| Extension | Language |
|---|---|
| coc-pyright | Python |
| coc-clangd | C / C++ |
| coc-tsserver | JavaScript / TypeScript |
| coc-lua | Lua |
| coc-json | JSON |
| coc-html | HTML |
| coc-css | CSS |
| coc-snippets | Snippets |

### Git — vim-fugitive

Hunk actions now live under the same `<leader>g*` group as the repo commands (matches nvim2's `<leader>g*` layout, where `gs`/`gu`/`gp` are stage/undo/preview hunk).

| Key | Action |
|---|---|
| `<leader>gg` | Open git status panel |
| `<leader>gb` | Git blame (current file) |
| `<leader>gd` | Diff current file against HEAD |
| `<leader>gl` | Git log (last 20 commits, oneline) |

> No dedicated push/pull keys (nvim2 doesn't bind them either). Push/pull from inside the `:Git` status panel (`cP`/`P`), or run `:Git push` / `:Git pull` directly.

Inside `:Git` status panel: `s` stage, `u` unstage, `=` toggle inline diff, `cc` commit, `dd` diff, `q` quit.

### Git — Hunks (gitgutter)

| Key | Action |
|---|---|
| `[h` | Previous hunk |
| `]h` | Next hunk |
| `<leader>gs` | Stage hunk |
| `<leader>gu` | Undo hunk |
| `<leader>gp` | Preview hunk diff |

### Editing

| Key | Action |
|---|---|
| `<A-j>` / `<A-k>` | Move line/selection down/up |
| `J` / `K` (visual) | Move selection down/up (matches nvim2) |
| `Tab` (visual) | Indent selection |
| `Shift-Tab` (visual) | Unindent selection |
| `<` / `>` (visual) | Indent left/right, keeps selection (matches nvim2) |
| `<leader>i` | Auto-indent entire file |
| `<leader>y` | Yank to system clipboard |
| `<leader>yp` | Paste from system clipboard |
| `Y` | Yank to end of line |
| `n` / `N` | Next/prev match (centred) |

### Diagnostics / Quickfix

| Key | Action |
|---|---|
| `<leader>xq` | Toggle quickfix list |
| `<leader>xl` | Toggle location list |
| `<leader>xd` | List all coc diagnostics |

### Toggles

| Key | Action |
|---|---|
| `<leader>uu` | Toggle undotree panel |
| `<leader>us` | Toggle spell check |
| `<leader>ud` | Toggle coc diagnostics for current buffer |

### Surround (vim-surround)

| Key | Action | Example |
|---|---|---|
| `cs"'` | Change surrounding `"` to `'` | `"hi"` → `'hi'` |
| `cs({` | Change `(` to `{` | `(hi)` → `{ hi }` |
| `ds"` | Delete surrounding `"` | `"hi"` → `hi` |
| `ysiw"` | Surround word with `"` | `hi` → `"hi"` |
| `yss)` | Surround line with `()` | whole line gets wrapped |
| `S"` (visual) | Surround selection with `"` | |

### Commentary (vim-commentary)

| Key | Action |
|---|---|
| `gcc` | Toggle comment on current line |
| `gc` + motion | Toggle comment over motion (e.g. `gcap` = paragraph) |
| `gc` (visual) | Toggle comment on selection |

### EasyMotion

| Key | Action |
|---|---|
| `s` + 2 chars | Jump to any 2-char match in current window |
| `S` + 2 chars | Jump to any 2-char match across all visible windows |

### Multi-Cursor (vim-visual-multi)

| Key | Action |
|---|---|
| `Ctrl-N` | Select word under cursor / add next occurrence |
| `Ctrl-Up/Down` | Add cursor above/below |
| `q` | Skip current and go to next |
| `Q` | Remove current cursor |
| `Tab` | Switch between cursor and extend mode |

### Text Objects — targets.vim

Extends standard text objects. Works with `d`, `c`, `v`, `y`.

| Object | Selects |
|---|---|
| `ci,` / `ca,` | Inside / around argument (comma-separated) |
| `cin,` | Inside next argument |
| `cil,` | Inside last argument |
| `ci(` / `ca(` | Inside / around parentheses (any nesting) |
| `ci[` / `ci{` / `ci<` | Inside brackets/braces/angles |
| `ci"` / `ci'` | Inside quotes |

### Undotree

| Key | Action |
|---|---|
| `<leader>uu` | Toggle undotree panel |

Inside undotree: `j/k` navigate history, `Enter` jump to state, `d` show diff, `q` close.

### Tagbar

| Key | Action |
|---|---|
| `<leader>tb` | Toggle tagbar panel |

Inside tagbar: `Enter` jump to tag, `p` preview, `space` show prototype, `q` close. Requires `universal-ctags`. (No nvim2 equivalent — nvim2 uses aerial for outline instead, see `<leader>lo`.)

### Terminal

| Key | Action |
|---|---|
| `<leader>t` / `<leader>th` | Open horizontal terminal (12 rows, bottom) |
| `<leader>tv` | Open vertical terminal |
| `<leader>tf` | Open floating terminal (Neovim only) |
| `jk` or `Esc` | Exit terminal insert mode |
| `Ctrl-h/j/k/l` | Move between terminal and other splits |

---

## Linters & Fixers (ALE)

Runs automatically on save.

| Language | Linter | Fixer |
|---|---|---|
| Python | flake8 | black |
| JavaScript | eslint | prettier |
| C / C++ | gcc | clang-format |
| Shell | shellcheck | — |
| All | — | remove trailing whitespace |

---

## Plugin Management

| Command | Action |
|---|---|
| `:PlugInstall` | Install new plugins |
| `:PlugUpdate` | Update all plugins |
| `:PlugClean` | Remove unused plugins |
| `:PlugStatus` | Show plugin status |

---

## coc.nvim Management

| Command | Action |
|---|---|
| `:CocInstall <ext>` | Install a coc extension |
| `:CocUninstall <ext>` | Remove a coc extension |
| `:CocUpdate` | Update all coc extensions |
| `:CocInfo` | Show coc status and log path |
| `:CocConfig` | Edit coc settings (JSON) |
| `:CocRestart` | Restart coc language server |

---

## Automatic Behaviours

- **Auto-save** — files save when focus leaves the window
- **Auto-pairs** — brackets, quotes, and parens close automatically
- **Persistent undo** — undo history survives closing vim (`~/.vim/undodir/`)
- **Cursor restore** — reopening a file jumps to your last position
- **Split rebalance** — splits auto-resize when the terminal window changes size
- **Cursor shape** — blinking bar in insert, underline in replace, block in normal
