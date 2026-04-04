
# 🚀 Neovim Lua Configuration

A modular and scalable Neovim configuration written in Lua, optimized for **C, C++, Rust, and LaTeX** development.

## 📂 Directory Structure

```text
.
├── config/              # Shared logic & helper modules (The "Brain")
├── core/                # Core Neovim settings (The "Foundation")
├── plugins/             # Plugin declarations & setups (The "Tools")
├── utils/               # Helper functions for internal use
└── init.lua             # Main entry point

```

---

## 🔍 Detailed Breakdown

### 🛠 `lua/user/core/`

These files are loaded immediately when Neovim starts.

* **`options.lua`**: Native Neovim settings (indentation, line numbers, mouse support).
* **`keymaps.lua`**: Global/General keybindings (buffer navigation, window management).
* **`autocommands.lua`**: Automated tasks (e.g., highlighting on yank, auto-formatting).
* **`init.lua`**: Orchestrates the loading of all core modules.

### 🧠 `lua/user/config/`

Contains reusable logic used by multiple plugins (LSP, CMP).

* **`lsp_on_attach.lua`**: Keymaps and functions that trigger only when an LSP is active (e.g., `Go to definition`).
* **`lsp_capabilities.lua`**: Extra features sent to the LSP servers (e.g., informing the server that we use `nvim-cmp` for autocompletion).
* **`cmp_sources.lua`**: List of data sources for the completion engine (LSP, Snippets, Buffer).

### 🔌 `lua/user/plugins/`

This is where the magic happens. Every file or folder here represents a feature.

* **`lsp/`**: Configuration for Language Servers (`clangd` for C++, `rust_analyzer` for Rust).
* **`cmp/`**: The `nvim-cmp` setup for the autocompletion UI.
* **`ui/`**: Visual enhancements like `lualine` (status bar), `neo-tree` (file explorer), and `bufferline`.
* **`treesitter.lua`**: High-level syntax highlighting and code structure analysis.
* **`ts_comment.lua`**: Context-aware commenting (Smart `gc`).
* **`latex.lua`**: Specific settings for `vimtex` and LaTeX workflows.

### 🧰 `lua/user/utils/`

* Contains utility functions (e.g., a function to toggle the terminal or a custom logger).

---

## ⌨️ Keybindings (Example)

* `<Leader>e`: Toggle File Explorer (`neo-tree`/`nvim-tree`).
* `gd`: Go to Definition (LSP).
* `K`: Show documentation hover (LSP).
* `gcc`: Comment/Uncomment line.

---

## 📦 Requirements

* **Neovim >= 0.10.0**
* **Treesitter Parsers**: `:TSUpdate`
* **External Tools**: `ripgrep` (for Telescope), `fd`, `latexmk` (for LaTeX).

