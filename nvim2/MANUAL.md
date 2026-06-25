# Neovim User Manual

> **Leader key:** `Space`

---

## Table of Contents

1. [Navigation](#1-navigation)
2. [File Explorer](#2-file-explorer)
3. [Fuzzy Finder](#3-fuzzy-finder)
4. [File Bookmarks — Harpoon](#4-file-bookmarks--harpoon)
5. [Buffers & Windows](#5-buffers--windows)
6. [LSP — Code Intelligence](#6-lsp--code-intelligence)
7. [Completion & Snippets](#7-completion--snippets)
8. [Formatting & Linting](#8-formatting--linting)
9. [Git](#9-git)
10. [Debugging (DAP)](#10-debugging-dap)
11. [CMake](#11-cmake)
12. [Terminal](#12-terminal)
13. [Search & Replace](#13-search--replace)
14. [Code Folding](#14-code-folding)
15. [Editing Utilities](#15-editing-utilities)
16. [Diagnostics & Quickfix](#16-diagnostics--quickfix)
17. [TODO Comments](#17-todo-comments)
18. [LaTeX](#18-latex)
19. [HTTP Client — Kulala](#19-http-client--kulala)
20. [Rust / Cargo](#20-rust--cargo)
21. [Sessions](#21-sessions)
22. [Undo History — Undotree](#22-undo-history--undotree)
23. [Treesitter Text Objects](#23-treesitter-text-objects)
24. [Toggles & Misc](#24-toggles--misc)
25. [Changing the Colorscheme](#25-changing-the-colorscheme)
26. [Tips & Power Moves](#26-tips--power-moves)

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

### mini.bracketed — extended `[` / `]` jumps

Extends the `[x` / `]x` jump family with more targets:

| Key | Jumps between |
|-----|--------------|
| `[b` / `]b` | Buffers |
| `[c` / `]c` | Comments |
| `[d` / `]d` | Diagnostics |
| `[f` / `]f` | Files in directory |
| `[i` / `]i` | Indentation levels |
| `[j` / `]j` | Jumplist entries |
| `[l` / `]l` | Location list entries |
| `[q` / `]q` | Quickfix entries |
| `[u` / `]u` | Undo history states |
| `[w` / `]w` | Windows |
| `[y` / `]y` | Yank history |

> Note: `[C` / `]C` are used for comments (upper-case) to avoid clash with class text objects.

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

## 4. File Bookmarks — Harpoon

**Plugin:** harpoon2

Mark up to 4 files per project and jump between them instantly — no fuzzy search needed. Essential when you constantly switch between `.c`/`.h` pairs or a handful of hot files.

| Key | Action |
|-----|--------|
| `<leader>ha` | Add current file to harpoon list |
| `<leader>hh` | Open harpoon menu (edit the list) |
| `<C-1>` | Jump to harpoon slot 1 |
| `<C-2>` | Jump to harpoon slot 2 |
| `<C-3>` | Jump to harpoon slot 3 |
| `<C-4>` | Jump to harpoon slot 4 |
| `<leader>hp` | Previous harpoon file |
| `<leader>hn` | Next harpoon file |

**Typical workflow:**
1. Open `main.c` → `<leader>ha` (slot 1)
2. Open `main.h` → `<leader>ha` (slot 2)
3. Open `utils.c` → `<leader>ha` (slot 3)
4. Now `<C-1>` / `<C-2>` / `<C-3>` teleport between them instantly.

The list persists across sessions per project directory.

---

## 5. Buffers & Windows

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

## 6. LSP — Code Intelligence

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
| `<leader>xd` | Show diagnostics float for current line |
| `[d` | Previous diagnostic |
| `]d` | Next diagnostic |
| `<C-s>` *(insert)* | Signature help |

### C / C++ only

| Key | Action |
|-----|--------|
| `<leader>a` | Switch between source (`.c`/`.cpp`) and header (`.h`) |
| `<leader>lA` | View AST for symbol under cursor (clangd) |
| `<leader>lT` | Type hierarchy (clangd) |
| `<leader>lI` | Symbol info — offset, type, size (clangd) |
| `<leader>lM` | Clangd memory usage report |

### Reference highlighting (illuminate)

All other occurrences of the word under cursor are highlighted automatically after a short delay (200ms). This is theme-aware and works even without LSP active. It complements the LSP document-highlight you already have.

### Diagnostics display

Errors, warnings, hints and info are shown inline as virtual text. The sign column shows icons:

| Icon | Severity |
|------|----------|
| `󰅚` | Error |
| `󰀪` | Warning |
| `󰌶` | Hint |
| `󰋽` | Info |

### Treesitter Context (sticky header)

The current function or class name is pinned to the top of the window as you scroll past it. Up to 3 lines are shown. Toggle with `<leader>uc`.

---

## 7. Completion & Snippets

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

## 8. Formatting & Linting

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

## 9. Git

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

## 10. Debugging (DAP)

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

## 11. CMake

**Plugin:** cmake-tools.nvim

Integrates CMake build, run, and target management directly into Neovim. Automatically sets `-DCMAKE_EXPORT_COMPILE_COMMANDS=ON` so clangd always has a fresh `compile_commands.json`.

| Key | Action |
|-----|--------|
| `<leader>cg` | Generate (cmake configure) |
| `<leader>cb` | Build current target |
| `<leader>cr` | Run current target |
| `<leader>ct` | Select build target |
| `<leader>cv` | Select build type (Debug / Release / RelWithDebInfo) |
| `<leader>cc` | Clean build directory |
| `<leader>cx` | Stop running build / process |

**Typical project workflow:**
```
<leader>cv   — choose Debug
<leader>cg   — configure (generates compile_commands.json)
<leader>cb   — build
<leader>cr   — run
```

Build output appears in a console panel at the bottom (10 lines). The build directory is `build/<buildType>` by default.

---

## 12. Terminal

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

## 13. Search & Replace

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

## 14. Code Folding

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

## 15. Editing Utilities

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

### Doc comment generation (neogen)

Generates Doxygen blocks for C/C++, Google-style docstrings for Python, and rustdoc for Rust — from the function signature under the cursor.

| Key | Action |
|-----|--------|
| `<leader>ng` | Generate docstring for symbol under cursor |
| `<leader>nf` | Generate function doc |
| `<leader>nc` | Generate class / struct doc |
| `<leader>nt` | Generate type doc |

**Example (C):**
```c
// cursor on this function, press <leader>ng:
int add(int a, int b);

// becomes:
/**
 * @brief
 * @param a
 * @param b
 * @return int
 */
int add(int a, int b);
```

### Smart increment / decrement (dial.nvim)

Extends `<C-a>` / `<C-x>` beyond plain numbers:

| What gets cycled | Examples |
|-----------------|---------|
| Decimal integers | `0` → `1` |
| Hex values | `0xff` → `0x100` |
| Booleans | `true` ↔ `false` |
| C logical ops | `&&` ↔ `\|\|` |
| `yes` / `no` | cycles |
| Semantic versions | `1.0.0` → `1.0.1` |
| Dates | `2024-01-31` → `2024-02-01` |

| Key | Mode | Action |
|-----|------|--------|
| `<C-a>` | Normal / Visual | Increment |
| `<C-x>` | Normal / Visual | Decrement |
| `g<C-a>` | Normal / Visual | Increment staircase (each line +1 more) |
| `g<C-x>` | Normal / Visual | Decrement staircase |

### Extended text objects (mini.ai)

Extends `a`/`i` with additional targets on top of the built-in ones:

| Object | Selects |
|--------|---------|
| `aq` / `iq` | Around / inside any quote (`"`, `'`, `` ` ``) |
| `a)` / `i)` | Around / inside parentheses (same as built-in but smarter) |
| `a]` / `i]` | Around / inside brackets |
| `a}` / `i}` | Around / inside braces |
| `a>` / `i>` | Around / inside angle brackets |
| `a?` / `i?` | Prompted — type any delimiter on the fly |

Works across multiple lines (up to 500 lines by default).

### Split / Join lines (treesj)

| Key | Action |
|-----|--------|
| `<leader>m` | Toggle between single-line and multi-line |
| `<leader>cj` | Join lines into one |
| `<leader>cs` | Split into multiple lines |

**Example:**
```lua
-- Before (single):
if x then return y end

-- After <leader>cs (split):
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

## 16. Diagnostics & Quickfix

### Quickfix / Location list (quicker)

| Key | Action |
|-----|--------|
| `<leader>xq` | Toggle quickfix list |
| `<leader>xl` | Toggle location list |
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

## 17. TODO Comments

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

## 18. LaTeX

**Plugins:** vimtex + texlab LSP + luasnip-latex-snippets

| Key | Action |
|-----|--------|
| `<leader>Lc` | Compile with latexmk |
| `<leader>Lv` | Open PDF in zathura |

Compilation uses `xelatex` with synctex enabled. Forward search (source → PDF position) is wired via zathura synctex.

LSP (texlab) provides completion, diagnostics, and hover documentation for commands and environments.

LaTeX-specific snippets load automatically when editing `.tex` files.

---

## 19. HTTP Client — Kulala

**Plugin:** kulala.nvim

Write HTTP requests in `.http` files and send them directly from Neovim. Useful for testing REST APIs alongside embedded tooling.

**File format:**
```http
### Get device status
GET http://192.168.1.100/api/status
Content-Type: application/json

### Update config
POST http://192.168.1.100/api/config
Content-Type: application/json

{
  "timeout": 5000,
  "baud": 115200
}
```

| Key | Action |
|-----|--------|
| `<leader>Hr` | Run request under cursor |
| `<leader>Ha` | Run all requests in file |
| `<leader>Hn` | Jump to next request |
| `<leader>Hp` | Jump to previous request |
| `<leader>Hi` | Inspect request (show resolved headers/vars) |
| `<leader>Hc` | Copy request as cURL command |

Response appears in a vertical split. Supports environment variables via `.env` files.

---

## 20. Rust / Cargo

**Plugin:** rustaceanvim + crates.nvim

Rust uses a dedicated LSP handler (rustaceanvim) instead of plain lspconfig.

- **Checker:** clippy (runs on save)
- **Inlay hints:** enabled by default — shows parameter names and types inline. Toggle with `<leader>lh`.

### Cargo.toml helpers (crates.nvim)

When editing `Cargo.toml`, crate version completion appears in the completion menu automatically. Hover over a crate name for version info.

---

## 21. Sessions

**Plugin:** persistence.nvim

Sessions save buffers, working directory, tab pages, and window sizes.

| Key | Action |
|-----|--------|
| `<leader>qs` | Restore session for the current directory |
| `<leader>ql` | Restore the last session (regardless of directory) |

Sessions are saved automatically when you quit Neovim.

---

## 22. Undo History — Undotree

**Plugin:** undotree

Neovim's undo is a tree, not a line — you can recover edits that were "undone" and then overwritten. Undotree makes the tree visible.

| Key | Action |
|-----|--------|
| `<leader>uu` | Toggle undotree panel |

**Inside the undotree panel:**

| Key | Action |
|-----|--------|
| `j` / `k` | Move between undo states |
| `Enter` | Restore the selected state |
| `d` | Toggle diff panel |
| `q` | Close undotree |

The diff panel (bottom) shows what changed between the selected state and the current buffer.

> Since `undofile = true` is set, undo history persists across Neovim restarts. You can recover edits from a previous session.

---

## 23. Treesitter Text Objects

Use these in operator-pending or visual mode after an operator (`d`, `y`, `c`, `v`, etc.).

### Built-in (treesitter-textobjects)

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

### Extended (mini.ai)

| Text Object | Selects |
|-------------|---------|
| `aq` / `iq` | Around / inside any quote |
| `a?` / `i?` | Around / inside prompted delimiter |

**Examples:**
```
daf   — delete entire function including signature
yif   — yank function body only
vac   — visually select entire class
cii   — change inside if-block
diq   — delete contents of any surrounding quote
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

## 24. Toggles & Misc

| Key | Action |
|-----|--------|
| `<leader>us` | Toggle spell check (English) |
| `<leader>ud` | Toggle LSP diagnostics on/off |
| `<leader>lh` | Toggle LSP inlay hints |
| `<leader>uc` | Toggle treesitter context (sticky header) |
| `<leader>uu` | Toggle undotree |
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

## 25. Changing the Colorscheme

Edit [colorscheme.lua](lua/system/plugins/colorscheme.lua) and change the `active` variable on line 4:

```lua
local active = "gruvbox8"   -- change this
```

**Available themes:**

| Name | Style |
|------|-------|
| `gruvbox8` | Warm retro (active default) |
| `gruvbox` | Alternative gruvbox (ellisonleao variant) |
| `nord` | Arctic blue |
| `catppuccin` | Soft pastel (mocha) |
| `everforest` | Green forest |
| `tokyonight` | Dark purple (night) |
| `kanagawa` | Japanese ink (wave) |
| `nightfox` | Dark carbon (carbonfox variant) |
| `onedark` | Classic dark (darker variant) |
| `rose_pine` | Muted rose (moon variant) |

Save the file, then run `:Lazy sync` to install the theme if it's new, then restart Neovim.

---

## 26. Tips & Power Moves

### Workflow combos

**Find all usages → fix them all:**
1. `<leader>f*` — grep word under cursor, all results → quickfix
2. `<leader>q` — open quickfix
3. `:cdo s/old/new/g` — substitute across every entry

**Bounce between related files instantly (harpoon):**
1. Open each file → `<leader>ha` to mark it
2. `<C-1>` / `<C-2>` / `<C-3>` to teleport, no searching

**Inspect a symbol without leaving your position:**
- `K` — hover docs
- `<leader>xd` — show diagnostics float
- `<leader>lI` — clangd symbol info (size, offset, type)
- `<leader>lA` — AST view for the symbol
- `<leader>dh` — DAP hover (during a debug session)
- `r` then `<label>` (flash remote) — yank/delete at a distant location without moving

**Generate + fill a doc comment fast:**
1. `<leader>ng` — generate Doxygen / docstring skeleton
2. `<Tab>` — jump through LuaSnip fields to fill each param

**Refactor a function across the project:**
1. `<leader>lr` — rename (LSP renames all references atomically)
2. Or: `<leader>sr` — grug-far for text-based search & replace across files

**Stage partial changes (hunks not files):**
- `]h` / `[h` — navigate hunks
- `<leader>gp` — preview hunk inline
- `<leader>gs` in visual mode — stage only selected lines

**Recover a deleted edit (undotree):**
1. `<leader>uu` — open undotree
2. `j`/`k` — navigate to the state before the deletion
3. `Enter` — restore it

**Embedded C debug session quickstart:**
1. `<leader>cv` → select Debug, `<leader>cg` → configure (generates `compile_commands.json`)
2. `<leader>cb` → build
3. Start OpenOCD in `<leader>tf` (float terminal)
4. `<leader>dc` → DAP picks up `.elf` automatically, connects to OpenOCD
5. `<F10>`/`<F11>`/`<F12>` — step through

### Vim fundamentals worth remembering

```
ci"   — change inside quotes
ca{   — change around braces (includes the braces)
gf    — go to file under cursor
*     — search for word under cursor (forward)
#     — search for word under cursor (backward)
<C-o> — jump back (after gd / gr / flash)
<C-i> — jump forward
`.    — jump to last change position
```

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
