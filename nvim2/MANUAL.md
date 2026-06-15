# Neovim User Manual

> **Leader key:** `Space`

---

## Table of Contents

1. [Navigation](#1-navigation)
2. [File Explorer](#2-file-explorer)
3. [Fuzzy Finder](#3-fuzzy-finder)
4. [Buffers & Windows](#4-buffers--windows)
5. [LSP — Code Intelligence](#5-lsp--code-intelligence)
6. [Completion & Snippets](#6-completion--snippets)
7. [Formatting & Linting](#7-formatting--linting)
8. [Git](#8-git)
9. [Debugging (DAP)](#9-debugging-dap)
10. [Terminal](#10-terminal)
11. [Search & Replace](#11-search--replace)
12. [Code Folding](#12-code-folding)
13. [Editing Utilities](#13-editing-utilities)
14. [Diagnostics & Quickfix](#14-diagnostics--quickfix)
15. [TODO Comments](#15-todo-comments)
16. [LaTeX](#16-latex)
17. [Rust / Cargo](#17-rust--cargo)
18. [Sessions](#18-sessions)
19. [Treesitter Text Objects](#19-treesitter-text-objects)
20. [Toggles & Misc](#20-toggles--misc)
21. [Changing the Colorscheme](#21-changing-the-colorscheme)

---

## 1. Navigation

### Flash — label-based jump

Press a key, see labels appear on every visible match, type a label to jump there instantly.

| Key | Mode | Action |
|-----|------|--------|
| `s` | Normal / Visual / Operator | Jump to any visible location |
| `S` | Normal / Visual / Operator | Jump by Treesitter node |
| `r` | Operator | Remote flash — jump and operate without moving cursor |
| `R` | Operator / Visual | Treesitter search across file |
| `<C-s>` | Command | Toggle flash inside `/` search |

**Example — delete to a word across the screen:**
```
d  s  <label>
```

### Tmux / Window navigation

| Key | Action |
|-----|--------|
| `<C-h>` | Move to left window / tmux pane |
| `<C-j>` | Move to window below |
| `<C-k>` | Move to window above |
| `<C-l>` | Move to right window |

---

## 2. File Explorer

**Plugin:** neo-tree

| Key | Action |
|-----|--------|
| `<leader>e` | Toggle explorer sidebar |
| `<leader>o` | Focus explorer (cursor jumps to it) |
| `<leader>r` | Reveal current file in explorer |

**Keys inside the explorer:**

| Key | Action |
|-----|--------|
| `l` | Open file / expand directory |
| `h` | Close / collapse node |
| `v` | Open in vertical split |
| `s` | Open in horizontal split |
| `P` | Toggle floating preview |

---

## 3. Fuzzy Finder

**Plugin:** fzf-lua

| Key | Action |
|-----|--------|
| `<leader>ff` | Find files in project |
| `<leader>fh` | Recently opened files |
| `<leader>fb` | Open buffers |
| `<leader>fg` | Live grep (search text in project) |
| `<leader>p` | Command palette |
| `<leader>f*` | Grep word under cursor → send all results to quickfix |

**Inside the fzf window:**

| Key | Action |
|-----|--------|
| `Enter` | Open selected file |
| `<C-j>` / `<C-k>` | Move selection down / up |
| `<C-d>` | Preview page down |
| `<C-u>` | Preview page up |
| `<C-q>` | Send selected to quickfix list |
| `<Alt-q>` | Send selected to quickfix list |
| `<Esc>` | Close |

---

## 4. Buffers & Windows

### Buffer navigation

| Key | Action |
|-----|--------|
| `<Tab>` | Next buffer |
| `<S-Tab>` | Previous buffer |
| `]b` | Next buffer |
| `[b` | Previous buffer |
| `<leader>bd` | Delete buffer (window stays open) |

### Window management

| Key | Action |
|-----|--------|
| `<leader>wv` or `<leader>\|` | Vertical split |
| `<leader>wh` or `<leader>-` | Horizontal split |
| `<leader>wq` | Close window |
| `<leader>wo` | Close all other windows |
| `<leader>w=` | Equalize window sizes |
| `<C-Up/Down/Left/Right>` | Resize window by 2 lines/columns |

---

## 5. LSP — Code Intelligence

LSP is active automatically for: **C, C++, Rust, Python, LaTeX**.

### Core keymaps

| Key | Action |
|-----|--------|
| `gd` | Go to definition |
| `gr` | Find all references |
| `gi` | Go to implementation |
| `K` | Hover documentation |
| `<leader>lr` | Rename symbol |
| `<leader>la` | Code actions |
| `<leader>lf` | Format current file |
| `<leader>ld` | Go to definition (same as `gd`) |
| `<leader>li` | Show LSP info |
| `<leader>lh` | Toggle inlay hints on/off |
| `<leader>lo` | Toggle code outline (aerial) |
| `<leader>d` | Show diagnostics float for current line |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<C-k>` *(insert)* | Signature help |

### C / C++ only

| Key | Action |
|-----|--------|
| `<leader>a` | Switch between source (`.c`/`.cpp`) and header (`.h`) |

### Diagnostics display

Errors, warnings, hints and info are shown inline as virtual text with `●` prefix. The sign column shows icons:

| Icon | Severity |
|------|----------|
| `󰅚` | Error |
| `󰀪` | Warning |
| `󰌶` | Hint |
| `󰋽` | Info |

---

## 6. Completion & Snippets

### Completion menu

| Key | Action |
|-----|--------|
| `<C-j>` | Select next item |
| `<C-k>` | Select previous item |
| `<Tab>` | Confirm selection |
| `<C-Space>` | Manually trigger completion |

**Sources** (in priority order): LSP → Crates → Snippets → Buffer words → File paths

### Snippets (LuaSnip)

| Key | Action |
|-----|--------|
| `<Tab>` | Expand snippet or jump to next field |
| `<S-Tab>` | Jump to previous field |

Snippets come from the community collection (`friendly-snippets`) plus LaTeX-specific snippets. Add custom snippets to `~/.config/nvim/snippets/` in VSCode JSON format.

---

## 7. Formatting & Linting

### Auto-format on save

Formatting runs automatically when you save. Formatters by language:

| Language | Formatter |
|----------|-----------|
| Lua | `stylua` |
| Python | `black` |
| Shell | `shfmt` |
| JSON | `jq` |
| Rust | `rustfmt` |
| C / C++ | `clang-format` |

Manual format: `<leader>lf`

### Linters (run on save / insert leave)

| Language | Linter |
|----------|--------|
| Python | `flake8` |
| Shell | `shellcheck` |
| Lua | `luacheck` |
| C / C++ | `cpplint` |

> **Install linters:** `pip install flake8 cpplint`, `luarocks install luacheck`, `apt install shellcheck`

---

## 8. Git

**Plugin:** gitsigns (hunk operations) + lazygit (full UI) + diffview (file diffs)

### Lazygit

| Key | Action |
|-----|--------|
| `<leader>gg` | Open lazygit in a full-screen float |

Inside lazygit: use its own keybindings (`?` for help). Press `q` to quit.

### Hunk navigation

| Key | Action |
|-----|--------|
| `]h` | Next hunk |
| `[h` | Previous hunk |

### Hunk actions

| Key | Mode | Action |
|-----|------|--------|
| `<leader>gs` | Normal | Stage hunk |
| `<leader>gs` | Visual | Stage selected lines |
| `<leader>gr` | Normal | Reset hunk |
| `<leader>gr` | Visual | Reset selected lines |
| `<leader>gS` | Normal | Stage entire buffer |
| `<leader>gR` | Normal | Reset entire buffer |
| `<leader>gu` | Normal | Undo last stage |
| `<leader>gp` | Normal | Preview hunk inline |
| `<leader>gb` | Normal | Full blame for current line |
| `<leader>gd` | Normal | Diff current file |

**Hunk text object:** use `ih` in operator-pending / visual mode to select a hunk.
```
vih   — visually select current hunk
dih   — delete current hunk
```

### Diffview

| Key | Action |
|-----|--------|
| `<leader>gD` | Open diff view for all changed files |
| `<leader>gH` | File history for current file |
| `<leader>gX` | Close diff view |

---

## 9. Debugging (DAP)

**Supported:** C/C++ (via ARM OpenOCD), Rust (via codelldb), Python (via debugpy).

> **Requirement:** Install `debugpy` with `pip install debugpy` for Python debugging.

### Start / control

| Key | Action |
|-----|--------|
| `<leader>dc` or `<F5>` | Start / continue |
| `<leader>dt` | Terminate session |
| `<leader>dr` | Restart session |
| `<leader>ds` or `<F10>` | Step over |
| `<leader>di` or `<F11>` | Step into |
| `<leader>do` or `<F12>` | Step out |
| `<leader>drt` | Run to cursor |

### Breakpoints

| Key | Action |
|-----|--------|
| `<leader>db` | Toggle breakpoint |
| `<leader>dB` | Conditional breakpoint (enter expression) |
| `<leader>dl` | Log point (print value without stopping) |

### Inspect

| Key | Action |
|-----|--------|
| `<leader>dh` | Hover — show value of symbol under cursor |
| `<leader>de` | Evaluate expression (normal: prompt, visual: selection) |
| `<leader>du` | Toggle debug UI panel |

### Debug UI layout

The UI opens automatically when a session starts:
- **Left panel:** Scopes (35%), Breakpoints (15%), Call Stack (25%), Watches (25%)
- **Bottom panel:** REPL (50%), Console (50%)

### C/C++ embedded setup

The adapter connects to OpenOCD on `localhost:3333`. When you start debugging it will auto-discover `.axf` / `.elf` files in the project. If multiple are found, a picker appears.

### Rust setup

Automatically finds the binary in `target/debug/`. Falls back to a prompt if not found.

---

## 10. Terminal

**Plugin:** toggleterm

| Key | Action |
|-----|--------|
| `<leader>t` | Toggle default terminal (horizontal) |
| `<leader>tf` | Floating terminal |
| `<leader>th` | Horizontal split terminal |
| `<leader>tv` | Vertical split terminal |

**Inside the terminal:**

| Key | Action |
|-----|--------|
| `<C-h/j/k/l>` | Navigate to adjacent window |
| `<leader>t` | Toggle terminal closed |

Terminals persist across toggles. Multiple terminals are tracked by ID (shown in the winbar).

---

## 11. Search & Replace

### Project-wide find & replace

**Plugin:** grug-far

| Key | Mode | Action |
|-----|------|--------|
| `<leader>sr` | Normal | Search & replace — prefills with word under cursor |
| `<leader>sr` | Visual | Search & replace — prefills with selection |
| `<leader>sR` | Normal | Search & replace — blank slate |

Inside grug-far, fill the Search and Replace fields then use its own keybindings to apply across files.

### Live grep

`<leader>fg` opens fzf live grep. Results update as you type. Press `<C-q>` to send all matches to the quickfix list for further navigation.

---

## 12. Code Folding

**Plugin:** nvim-ufo (LSP + Treesitter powered)

| Key | Action |
|-----|--------|
| `zR` | Open all folds |
| `zM` | Close all folds |
| `zp` | Peek inside a fold without opening it |
| `zo` | Open fold under cursor |
| `zc` | Close fold under cursor |
| `za` | Toggle fold under cursor |

Folds are created automatically by the LSP or Treesitter. A count of hidden lines is shown inline: `  12 lines`.

---

## 13. Editing Utilities

### Surround (nvim-surround)

Operate on surrounding characters (brackets, quotes, tags).

| Command | Action |
|---------|--------|
| `ys<motion><char>` | Add surrounding |
| `ds<char>` | Delete surrounding |
| `cs<old><new>` | Change surrounding |

**Custom surrounds:**

| Char | Adds |
|------|------|
| `(` | `( ` … ` )` with spaces |
| `{` | `{ ` … ` }` with spaces |
| `<` | `<` … `>` |
| `l` | `ESP_LOGI(TAG, "` … `");` (ESP32 logging) |

**Examples:**
```
ysiw(    — wrap word with ( word )
ds"      — delete surrounding quotes
cs'"     — change ' to "
yssl     — wrap line with ESP_LOGI macro
```

### Split / Join lines (treesj)

| Key | Action |
|-----|--------|
| `<leader>m` | Toggle between single-line and multi-line |
| `<leader>j` | Join lines into one |
| `<leader>s` | Split into multiple lines |

**Example:**
```lua
-- Before (single):
if x then return y end

-- After <leader>s (split):
if x then
    return y
end
```

### Auto-pairs

Brackets and quotes close automatically. Treesitter-aware — won't auto-close inside strings or comments.

| Key | Action |
|-----|--------|
| `<M-e>` | Fast-wrap: wrap the current word in a bracket |
| `Backspace` | Smart delete — removes pair if both chars are adjacent |
| `Enter` | Auto-indent between `{` and `}` |

### Line number preview (numb)

Type `:123` in command mode — the editor previews line 123 before you press Enter.

---

## 14. Diagnostics & Quickfix

### Quickfix / Location list (quicker)

| Key | Action |
|-----|--------|
| `<leader>q` | Toggle quickfix list |
| `<leader>l` | Toggle location list |
| `]q` | Next item (wraps around) |
| `[q` | Previous item (wraps around) |

**Inside the quickfix window:**

| Key | Action |
|-----|--------|
| `>` | Expand context (2 lines above/below each entry) |
| `<` | Collapse context |

### Trouble (diagnostic panel)

Open with `:Trouble`. Used by TODO comments and LSP diagnostics.

---

## 15. TODO Comments

Special comment keywords are highlighted throughout the codebase.

| Keyword | Aliases | Color |
|---------|---------|-------|
| `TODO` | — | Info (blue) |
| `FIX` | `FIXME`, `BUG`, `ISSUE` | Error (red) |
| `HACK` | — | Warning (yellow) |
| `NOTE` | `INFO` | Hint (green) |
| `PERF` | `OPTIM`, `OPT` | Default |
| `TEST` | — | Test |

**Format:** `-- TODO: description` (keyword + colon)

### Navigation

| Key | Action |
|-----|--------|
| `]t` | Next TODO comment |
| `[t` | Previous TODO comment |
| `<leader>xt` | Show all TODOs in Trouble panel |
| `<leader>xT` | Show all TODOs in fzf |

---

## 16. LaTeX

**Plugins:** vimtex + texlab LSP + luasnip-latex-snippets

| Key | Action |
|-----|--------|
| `<leader>Lc` | Compile with latexmk |
| `<leader>Lv` | Open PDF in zathura |

Compilation uses `xelatex` with synctex enabled. Forward search (source → PDF position) is wired via zathura synctex.

LSP (texlab) provides completion, diagnostics, and hover documentation for commands and environments.

LaTeX-specific snippets load automatically when editing `.tex` files.

---

## 17. Rust / Cargo

**Plugin:** rustaceanvim + crates.nvim

Rust uses a dedicated LSP handler (rustaceanvim) instead of plain lspconfig.

- **Checker:** clippy (runs on save)
- **Inlay hints:** enabled by default — shows parameter names and types inline. Toggle with `<leader>lh`.

### Cargo.toml helpers (crates.nvim)

When editing `Cargo.toml`, crate version completion appears in the completion menu automatically. Hover over a crate name for version info.

---

## 18. Sessions

**Plugin:** persistence.nvim

Sessions save buffers, working directory, tab pages, and window sizes.

| Key | Action |
|-----|--------|
| `<leader>qs` | Restore session for the current directory |
| `<leader>ql` | Restore the last session (regardless of directory) |

Sessions are saved automatically when you quit Neovim.

---

## 19. Treesitter Text Objects

Use these in operator-pending or visual mode after an operator (`d`, `y`, `c`, `v`, etc.).

| Text Object | Selects |
|-------------|---------|
| `af` | Outer function |
| `if` | Inner function body |
| `ac` | Outer class |
| `ic` | Inner class body |
| `ai` | Outer conditional (`if`/`else`) |
| `ii` | Inner conditional body |
| `al` | Outer loop |
| `il` | Inner loop body |
| `ih` | Git hunk (from gitsigns) |

**Examples:**
```
daf   — delete entire function including signature
yif   — yank function body only
vac   — visually select entire class
cii   — change inside if-block
```

### Navigation

| Key | Action |
|-----|--------|
| `]f` | Next function start |
| `[f` | Previous function start |
| `]c` | Next class start |
| `[c` | Previous class start |

### Selection expansion

| Key | Action |
|-----|--------|
| `<C-Space>` | Expand selection to next Treesitter node |
| `<BS>` | Shrink selection |

### Parameter swap

| Key | Action |
|-----|--------|
| `<leader>na` | Swap parameter with next |
| `<leader>pa` | Swap parameter with previous |

---

## 20. Toggles & Misc

| Key | Action |
|-----|--------|
| `<leader>us` | Toggle spell check (English) |
| `<leader>lh` | Toggle LSP inlay hints |
| `<Esc>` | Clear search highlights |
| `<leader>y` | Yank to system clipboard |
| `<leader>yp` | Paste from system clipboard |
| `<A-e>` *(insert)* | Jump to end of line |

### Visual mode

| Key | Action |
|-----|--------|
| `J` | Move selected lines down |
| `K` | Move selected lines up |
| `<` | Indent left (keeps selection) |
| `>` | Indent right (keeps selection) |

### Code outline (aerial)

| Key | Action |
|-----|--------|
| `<leader>lo` | Toggle symbol outline on the right |

Navigate the outline with `j`/`k`, press `Enter` to jump to that symbol.

### Which-key

Press `<Space>` and wait 300ms — a popup shows all available keymaps grouped by prefix.

---

## 21. Changing the Colorscheme

Edit [colorscheme.lua](lua/system/plugins/colorscheme.lua) and change the `active_theme` variable:

```lua
local active_theme = "gruvbox8"   -- change this
```

**Available themes:**

| Name | Style |
|------|-------|
| `gruvbox8` | Warm retro (active default) |
| `gruvbox` | Alternative gruvbox |
| `nord` | Arctic blue |
| `catppuccin` | Soft pastel (macchiato) |
| `everforest` | Green forest |
| `tokyonight` | Dark purple (storm) |
| `kanagawa` | Japanese ink (wave) |
| `nightfox` | Dark carbon |
| `onedark` | Classic dark |
| `solarized` | Solarized dark |

Save the file, then run `:Lazy sync` to install the theme if it's new, then restart Neovim.

---

## External Tool Requirements

Some features require tools installed on the system:

| Tool | Purpose | Install |
|------|---------|---------|
| `lazygit` | Git TUI | `apt install lazygit` or `brew install lazygit` |
| `fzf` | Fuzzy finder backend | `apt install fzf` |
| `ripgrep` (`rg`) | Live grep | `apt install ripgrep` |
| `stylua` | Lua formatter | `cargo install stylua` |
| `black` | Python formatter | `pip install black` |
| `shfmt` | Shell formatter | `go install mvdan.cc/sh/v3/cmd/shfmt@latest` |
| `clang-format` | C/C++ formatter | `apt install clang-format` |
| `flake8` | Python linter | `pip install flake8` |
| `cpplint` | C/C++ linter | `pip install cpplint` |
| `luacheck` | Lua linter | `luarocks install luacheck` |
| `shellcheck` | Shell linter | `apt install shellcheck` |
| `debugpy` | Python DAP adapter | `pip install debugpy` |
| `codelldb` | Rust DAP adapter | install via Mason: `:MasonInstall codelldb` |
| `arm-none-eabi-gdb` | Embedded C DAP | `apt install gcc-arm-none-eabi` |
| `zathura` | PDF viewer (LaTeX) | `apt install zathura` |
| `latexmk` | LaTeX compiler | `apt install latexmk` |
