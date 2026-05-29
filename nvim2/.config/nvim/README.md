# 🌌 Neovim OS-Style Architecture

A modular, high-performance Neovim configuration built with a **Layered OS Architecture**. This setup treats the editor as a system, separating core logic, rules, and user-space features.

## 🏗️ The Architecture

The system is divided into 5 logical layers for maximum maintainability and "Lazy" performance.

### 1. 🛡️ Kernel Layer (`/kernel`)

The engine of the editor.

* **`options.lua`**: Global system variables and editor behavior.
* **`keymap.lua`**: Core keybindings and Leader definitions.
* **`autocommands.lua`**: Native event listeners (LSP hooks, highlight on yank).

### 2. 📜 Constitution Layer (`/constitution`)

The "Laws" that standardize how plugins interact.

* **`lsp_ui.lua`**: Standardized UI elements (Borders, Icons, Floating windows).
* **`lsp_capabilities.lua`**: Integration with completion and snippet engines.
* **`cmp_sources.lua`**: Configuration for the completion engine backend.

### 3. 🧩 Plugin Layer (`/plugins`)

Modular features isolated by functionality.

* **`lsp/` & `cmp/**`: Full IDE suite with per-server configurations.
* **`tools/`**: Productivity suite (FZF, Flash, Todo, Surround, Markdown).
* **`ui/`**: Visual enhancements (Bufferline, Lualine, Neo-tree, Smear Cursor).
* **`git.lua` / `terminal.lua**`: Version control and terminal integration.

### 4. ⚡ Runtime & Utils Layer (`/runtime`, `/utils`)

* **`runtime/lsp_on_attach.lua`**: Handles live buffer events when an LSP connects.
* **`utils/init.lua`**: Global helper functions and safe-require wrappers.

---

## 🌊 Loading Flow

1. **Entry**: `root/init.lua` initializes the environment.
2. **Core**: Kernel loads system-wide settings (Options -> Keymaps -> Autocmds).
3. **Plugins**: Lazy.nvim initializes modules from `/plugins/init.lua`.
4. **Middleware**: Constitution & Runtime calibrate plugin behaviors and LSP standards.
5. **Helpers**: Utils provides shared logic across all layers.

---

## 🛠️ Requirements

* **Neovim 0.10+** (Compiled with LuaJIT)
* **Build Tools**: `cargo` (for Rust/Yazi), `gcc`, `make`.
* **CLI Tools**: `ripgrep` (search), `fd` (find), `lazygit`.
* **Font**: Any [Nerd Font](https://www.nerdfonts.com/) (JetBrainsMono recommended).


