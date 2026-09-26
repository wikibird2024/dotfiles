# Vim Config Manual

**Leader key:** `Space`

---

## Setup

```bash
# First launch — install all plugins
vim
:PlugInstall

# coc extensions (clangd, rust-analyzer, json, snippets) auto-install on next startup
# For tagbar symbol support
sudo apt install universal-ctags
```

This config mirrors the live Neovim config (`neovim/`). Language servers and
formatters come from Neovim's mason folder (`~/.local/share/nvim/mason/bin`), so
open Neovim once first to install them. Copilot shares Neovim's GitHub login.

---

## Plugins

| Plugin | Role |
|---|---|
| onedark.vim | Colorscheme (default, matches Neovim) |
| gruvbox | Colorscheme (alternative) — switch with `s:active_theme` in `.vimrc` |
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
| ale | Linters + format on save (neovim: nvim-lint + conform) |
| copilot.vim | AI suggestions (neovim: copilot.lua) |
| vim-tmux-navigator | `Ctrl-h/j/k/l` across Vim splits and tmux panes (same plugin as Neovim) |
| vim-startify | Start screen (neovim: snacks dashboard) |
| context.vim | Keeps the current function header on top (neovim: treesitter-context) |
| splitjoin.vim | Split / join code blocks (neovim: treesj) |
| vimtex | LaTeX (same plugin as Neovim) |
| rainbow_csv | CSV column colours (same idea as Neovim's rainbow_csv) |

---

## Keybindings

Keys match the live Neovim config (`neovim/.config/nvim/lua/system/kernel/keymap.lua` and the plugin specs). Where Vim has no matching plugin (harpoon, neotest, cmake, refactoring…), the Neovim key is simply not mapped. `vim_light/.vimrc` uses the same core keys, backed by Vim's own features.

### General

| Key | Action |
|---|---|
| `jk` / `kj` | Exit insert mode |
| `<Space><Space>` | Clear search highlight |
| `<Esc>` | Clear search highlight (Neovim only — in terminal Vim an `<Esc>` mapping breaks arrow keys) |
| `<leader>p` | Command palette (`:Commands`) |
| `<leader>se` | Edit vimrc |
| `<leader>sv` | Reload vimrc |

> Files auto-save when you leave insert mode or Vim loses focus, so there's no dedicated save key — same as Neovim. Use `:w` for an explicit save.

### Windows & Splits

| Key | Action |
|---|---|
| `Ctrl-h/j/k/l` | Move between splits (also from inside a terminal) |
| `Ctrl-Up/Down` | Resize split height |
| `Ctrl-Left/Right` | Resize split width |
| `<leader>\|` / `<leader>wv` | Vertical split |
| `<leader>-` / `<leader>wh` | Horizontal split |
| `<leader>wq` | Close window |
| `<leader>wo` | Close all other windows |
| `<leader>w=` | Equalize window sizes |

### Buffers

| Key | Action |
|---|---|
| `[b` / `]b` | Previous / next buffer |
| `<leader>bd` | Delete buffer (keeps window open) |

> Neovim also has `<Tab>` / `<S-Tab>` for next / previous buffer. Not mapped here: in a terminal `<Tab>` is the same key as `<C-i>` (jump forward).

### File Explorer (NERDTree)

| Key | Action |
|---|---|
| `<leader>e` | Toggle NERDTree |
| `<leader>o` | Focus NERDTree |
| `<leader>r` | Reveal current file in NERDTree |

Inside NERDTree: `o` open, `s` vertical split, `i` horizontal split, `ma` new file, `md` delete, `R` refresh, `I` toggle hidden files, `?` help.

### Find (fzf)

| Key | Action |
|---|---|
| `Ctrl-p` / `<leader>ff` | Find files |
| `<leader>fg` | Live grep across project (ripgrep) |
| `<leader>fb` | Open buffers |
| `<leader>fh` | File history (recently opened) |
| `<leader>f*` | Grep word under cursor → quickfix list |
| `<leader>fl` | Lines in current buffer |
| `<leader>fL` | Lines across all open buffers |
| `<leader>fm` | Key mappings |

Inside fzf popup: `Ctrl-j/k` navigate, `Enter` open, `Ctrl-v` vertical split, `Ctrl-x` horizontal split, `Ctrl-t` new tab.

### LSP — coc.nvim

| Key | Action |
|---|---|
| `Tab` | Accept Copilot suggestion, else accept the menu item, else Tab |
| `Ctrl-j` / `Ctrl-k` | Next / previous completion item |
| `Enter` | New line (never accepts, like Neovim) |
| `Ctrl-e` | Close the completion menu |
| `Tab` / `Shift-Tab` | Next / previous snippet field (while a snippet is active) |
| `Alt-]` / `Alt-[` | Next / previous Copilot suggestion |
| `Ctrl-]` | Dismiss Copilot suggestion |
| `Ctrl-Space` | Trigger completion manually |
| `Ctrl-s` (insert) | Signature help |
| `K` | Hover documentation |
| `gd` / `<leader>ld` | Go to definition |
| `gD` | Go to declaration |
| `gy` | Go to type definition |
| `gi` | Go to implementation |
| `gr` | Show all references |
| `[d` / `]d` | Previous / next diagnostic |
| `<leader>la` | Code action at cursor |
| `<leader>lf` | Format file (same tools as format on save) |
| `<leader>lh` | Toggle inlay hints |
| `<leader>li` | coc info (`:CocInfo`) |
| `<leader>lo` | Outline panel (tagbar; Neovim uses aerial) |
| `<leader>lr` | Rename symbol |
| `<leader>ls` | Search workspace symbols |
| `<leader>ch` | Switch C/C++ source ↔ header (coc-clangd) |
| `<leader>m` | Split / join code block (toggle) |
| `<leader>cs` / `<leader>cj` | Split / join code block |
| `<leader>Lc` / `<leader>Lv` | LaTeX compile / view (vimtex, zathura) |

**Text objects (works with `d`, `c`, `v`, `y`):**

| Object | Selects |
|---|---|
| `if` / `af` | Inside / around function |
| `ic` / `ac` | Inside / around class |
| `ih` | Git hunk (gitgutter) |

**Language servers** (same as Neovim; run from Neovim's mason folder unless noted):

| Server | Language |
|---|---|
| clangd (coc-clangd, same flags as Neovim) | C / C++ |
| pyright + ruff | Python |
| rust-analyzer (coc-rust-analyzer, from rustup) | Rust |
| lua-language-server | Lua |
| bash-language-server | Shell |
| taplo | TOML |
| texlab | LaTeX |
| typos-lsp | Spelling in code, all files |
| coc-json | JSON |

coc-snippets provides snippets.

### Git

| Key | Action |
|---|---|
| `<leader>gg` | lazygit in a floating window (falls back to `:Git` if lazygit isn't installed) |
| `[h` / `]h` | Previous / next hunk |
| `<leader>gs` | Stage hunk |
| `<leader>gr` | Reset hunk |
| `<leader>gS` | Stage buffer (`:Gwrite`) |
| `<leader>gR` | Reset buffer (`:Gread`) |
| `<leader>gp` | Preview hunk |
| `<leader>gb` | Blame (current file) |
| `<leader>gd` | Diff current file against the index |
| `<leader>gH` | File history (`:0Gclog`) |
| `<leader>gl` | Git log (last 20 commits, oneline) |

Inside `:Git` status panel: `s` stage, `u` unstage, `=` toggle inline diff, `cc` commit, `dd` diff, `cP`/`P` push/pull, `q` quit.

### Search & Replace

| Key | Action |
|---|---|
| `<leader>sr` | Replace word under cursor (or selection) across the project, asking at each match |
| `<leader>sR` | Same, but asks for the text to search |

### Editing

| Key | Action |
|---|---|
| `Alt-j` / `Alt-k` | Move line/selection down/up |
| `J` / `K` (visual) | Move selection down/up |
| `Tab` / `Shift-Tab` (visual) | Indent / unindent selection |
| `<` / `>` (visual) | Indent left/right, keeps selection |
| `Alt-e` (insert) | Jump to end of line |
| `Ctrl-l` (insert) | Move right one character |
| `<leader>i` | Auto-indent entire file |
| `<leader>y` | Yank to system clipboard |
| `<leader>yp` | Paste from system clipboard |
| `Y` | Yank to end of line |
| `n` / `N` | Next/prev match (centred) |

### Diagnostics / Quickfix

| Key | Action |
|---|---|
| `<leader>xd` | Diagnostics for the current line |
| `<leader>xx` | List all diagnostics |
| `<leader>xq` | Toggle quickfix list |
| `<leader>xl` | Toggle location list |
| `[q` / `]q` | Previous / next quickfix item (wraps at the ends) |
| `[t` / `]t` | Previous / next TODO / FIXME / NOTE … comment |
| `<leader>xt` / `<leader>xT` | All TODO comments → quickfix list / fzf |

### Sessions

A session is saved per folder when Vim quits (like Neovim's persistence).

| Key | Action |
|---|---|
| `<leader>qs` | Restore the session for this folder |
| `<leader>ql` | Restore the last session |
| `<leader>qd` | Don't save a session when quitting |

### Debug (gdb)

Vim's built-in termdebug stands in for Neovim's nvim-dap (gdb only, no codelldb).

| Key | Action |
|---|---|
| `<leader>dc` | Start (asks for the program) / continue |
| `<leader>db` | Toggle breakpoint |
| `<leader>ds` / `<leader>di` / `<leader>do` | Step over / into / out |
| `<leader>de` | Evaluate expression under cursor |
| `<leader>dt` | Stop the program |

### Toggles

| Key | Action |
|---|---|
| `<leader>ud` | coc diagnostics for current buffer |
| `<leader>uc` | Function header on top (context.vim) |
| `<leader>ul` | Relative / absolute line numbers |
| `<leader>us` | Spell check |
| `<leader>uu` | Undotree panel |
| `<leader>uw` | Show whitespace characters |

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

Opened with `<leader>lo` (see LSP). Inside tagbar: `Enter` jump to tag, `p` preview, `space` show prototype, `q` close. Requires `universal-ctags`.

### Terminal

| Key | Action |
|---|---|
| `<leader>th` | Horizontal terminal (12 rows, bottom) |
| `<leader>tv` | Vertical terminal |
| `<leader>tf` | Floating terminal (Vim popup / Neovim float) |
| `Esc Esc` | Leave terminal insert mode (a single `Esc` still reaches the program) |
| `Ctrl-h/j/k/l` | Move from the terminal to other splits |

---

## Linters & Formatters (ALE)

Same tools as Neovim's nvim-lint and conform. Files are formatted on save.

| Language | Linter | Formatter (on save) |
|---|---|---|
| C / C++ | clangd (clang-tidy) | clang-format |
| Python | ruff (language server) | ruff: sort imports + format |
| Rust | rust-analyzer | rustfmt |
| Lua | luacheck | stylua |
| Shell | shellcheck | shfmt |
| JSON | — | jq |
| TOML | taplo | taplo (language server) |

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

- **Start screen** — "GINKO'S VIM" logo (green → gold; on two rows in narrow windows), actions (`f` find, `g` grep, `r` recent, `n` new, `s` session, `c` config, `q` quit), recent files in this folder, then recent files elsewhere. Settings are in the STARTIFY section of `.vimrc`; see `:help startify`
- **Auto-save** — files save when you leave insert mode or Vim loses focus
- **Format on save** — see Linters & Formatters
- **Trailing whitespace** — removed on save (not in Markdown)
- **Yank flash** — yanked text is highlighted briefly
- **TODO highlight** — `TODO`, `FIXME`, `HACK`, `NOTE`… followed by `:` are coloured
- **Session save** — see Sessions
- **Auto-pairs** — brackets, quotes, and parens close automatically
- **Persistent undo** — undo history survives closing vim (`~/.vim/undodir/`)
- **Cursor restore** — reopening a file jumps to your last position
- **Split rebalance** — splits auto-resize when the terminal window changes size
- **Cursor shape** — blinking bar in insert, underline in replace, block in normal
