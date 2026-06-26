# Neovim Workflow Guide

Practical day-to-day workflows combining all plugins.

---

## Table of Contents

1. [Embedded C Project](#1-embedded-c-project)
2. [Starting a New C File from Scratch](#2-starting-a-new-c-file-from-scratch)
3. [Refactor — Rename a Symbol](#3-refactor--rename-a-symbol)
4. [Recovering Deleted Code](#4-recovering-deleted-code)
5. [Rust Workflow](#5-rust-workflow)
6. [Testing an HTTP Endpoint](#6-testing-an-http-endpoint)
7. [Exploring an Unfamiliar Codebase](#7-exploring-an-unfamiliar-codebase)
8. [The Mental Model](#8-the-mental-model)

---

## 1. Embedded C Project

The full loop from opening the project to committing.

```
1. OPEN PROJECT
   <leader>qs          — restore last session (buffers + layout)

2. ORIENT
   <leader>e           — neo-tree, browse files
   <leader>lo          — aerial outline on the right

3. PIN HOT FILES — do this once per project
   open main.c         → <leader>ha   (slot 1)
   open main.h         → <leader>ha   (slot 2)
   open CMakeLists.txt → <leader>ha   (slot 3)
   Now <C-1> <C-2> <C-3> teleport between them instantly

4. BUILD
   <leader>cv          — select build type (Debug / Release)
   <leader>cg          — cmake configure → generates compile_commands.json
                         clangd re-indexes automatically
   <leader>cb          — build, output appears in bottom panel

5. WRITE CODE
   K                   — hover any function to see its signature
   <C-s> in insert     — signature help mid-argument list
   <leader>lI          — clangd symbol info (size, offset, type of struct field)
   <leader>lA          — AST view when something behaves unexpectedly
   <leader>ng          — generate Doxygen block for a new function
   <Tab>               — jump through @param / @return fields (LuaSnip)
   <C-a> on true       — flip to false instantly (dial.nvim)
   <leader>lh          — toggle inlay hints

6. DEBUG
   <leader>tf          — float terminal → start openocd
   <leader>db          — set breakpoints
   <leader>dc / <F5>   — connect, auto-discovers .elf / .axf
   <F10>               — step over
   <F11>               — step into
   <F12>               — step out
   <leader>dh          — hover a variable to see its current value
   <leader>de          — evaluate an expression in the REPL
   <leader>du          — toggle debug UI panel

7. COMMIT
   <leader>gg          — lazygit: stage hunks, write message, push
```

---

## 2. Starting a New C File from Scratch

```
1. Create file, write a function signature

2. <leader>ng          — neogen generates Doxygen skeleton
   <Tab>               — jump through each @param / @return field

3. Write the body
   <leader>lh          — toggle inlay hints (see param types inline)
   <C-s> in insert     — signature help if you forget param order

4. Save
                       — clang-format runs automatically
                       — cpplint lints
                       — trailing whitespace stripped

5. <leader>a           — flip to the header, declare the function
   <C-1>               — back to .c instantly (harpoon)
```

---

## 3. Refactor — Rename a Symbol

### LSP rename (recommended — touches every reference atomically)

```
cursor on symbol
<leader>lr             — enter new name, LSP updates all references across files
```

### Text-based rename (macros, comments, non-LSP files)

```
cursor on symbol
<leader>f*             — grep all occurrences → quickfix list
<leader>xq             — open quickfix to review every hit
:cdo s/old/new/gc      — step through each file, confirm replacements
```

---

## 4. Recovering Deleted Code

Neovim's undo is a tree — branches survive even after being overwritten. `undofile = true` means history persists across restarts.

```
<leader>uu             — open undotree panel
j / k                  — walk back through history
                         diff panel shows exactly what changed at each state
Enter                  — restore the selected state

Works even after closing and reopening Neovim.
You can recover code deleted in a previous session.
```

---

## 5. Rust Workflow

```
1. MANAGE DEPENDENCIES
   open Cargo.toml
   hover a crate name   — crates.nvim shows latest version info
   <C-a> on version     — bump patch/minor version (dial.nvim semver support)

2. WRITE CODE
   <leader>lh           — inlay hints show inferred types everywhere
   save                 — clippy runs, rustfmt formats automatically

3. DEBUG
   <leader>cr           — cmake-tools run (or cargo build in terminal)
   <leader>dc           — codelldb auto-finds target/debug/<binary>
   <F10> <F11> <F12>    — step through
```

---

## 6. Testing an HTTP Endpoint

Create a `requests.http` file in your project:

```http
### Reset device
POST http://192.168.1.100/api/reset

### Read temperature sensor
GET http://192.168.1.100/api/sensor/temperature

### Update config
POST http://192.168.1.100/api/config
Content-Type: application/json

{
  "baud": 115200,
  "timeout": 5000
}
```

```
<leader>Hn / <leader>Hp   — jump between requests in the file
<leader>Hr                 — send the request under cursor
                             response appears in a vertical split
<leader>Hi                 — inspect resolved headers and variables
<leader>Hc                 — copy as curl command (for sharing / CI scripts)
<leader>Ha                 — run all requests in sequence
```

> Keymaps are **buffer-local** — they only exist when you are inside an `.http` file.

---

## 7. Exploring an Unfamiliar Codebase

```
FIND ENTRY POINTS
<leader>ff             — find a file by name
<leader>fg             — live grep for a keyword

UNDERSTAND A SYMBOL
gd                     — jump to definition
K                      — hover docs
<leader>lI             — clangd symbol info (type, size, offset)
<leader>lT             — type hierarchy (C++ class tree)
<C-o>                  — jump back after exploring

FIND ALL USAGES
gr                     — all references in fzf list
<leader>f*             — grep word under cursor → quickfix

UNDERSTAND FILE STRUCTURE
<leader>lo             — aerial outline (functions, classes, methods)
zM                     — collapse all folds, see only signatures
zp on a fold           — peek inside without fully opening

UNDERSTAND SCOPE WHILE SCROLLING
                       — treesitter-context pins current function at top of window

TRACK WHAT YOU FIND
<leader>ha             — mark important files to harpoon
<leader>hh             — review / reorder your marked files
```

---

## 8. The Mental Model

Quick reference for which tool answers which question.

| Question | Tool | Key |
|---|---|---|
| Where am I in the file? | aerial + treesitter-context | `<leader>lo` / automatic |
| What does this symbol do? | hover | `K` |
| What type / size is this? | clangd symbol info | `<leader>lI` |
| Why does the compiler see it this way? | clangd AST | `<leader>lA` |
| Where is it defined? | LSP definition | `gd` |
| Where is it used? | LSP references | `gr` |
| Where does it appear as text? | fzf grep | `<leader>f*` |
| How do I get there fast? | harpoon / flash | `<C-1..4>` / `s` |
| Did I break anything? | diagnostics | virtual text + `<leader>xd` |
| What did this look like before? | undotree | `<leader>uu` |
| How do I build / run? | cmake-tools | `<leader>cb` / `<leader>cr` |
