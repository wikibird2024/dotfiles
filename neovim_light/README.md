# Custom Neovim Keymaps Manual

This document provides a comprehensive user manual for the custom keybindings configured in `lua/config/keymaps.lua`. The keymaps are built around ergonomic workflows, utilizing structural "hubs" to group actions efficiently.

## ⚙️ Global Settings

* **Leader Key**: `<Space>` (Spacebar)
* **Timeout Length**: `500ms` (Time allowed to complete a mapped sequence)

---

## 🚀 1. The Command Hub (`<Space><Space>`)
The central landing hub for quick, global configuration actions and interface toggles.

| Keybinding | Mode | Action |
| :--- | :---: | :--- |
| `<leader><leader>` | Normal | **Command Hub** (No Operation / Prefix) |
| `<leader><leader>h` | Normal | Clear Search Highlights (`:noh`) |
| `<leader><leader>f` | Normal | Hub: Find Files (FzfLua) |
| `<leader><leader>b` | Normal | Hub: Search Buffers (FzfLua) |
| `<leader><leader>l` | Normal | Hub: Look up LSP Document Symbols |
| `<leader><leader>t` | Normal | Hub: Toggle Terminal |

---

## 📝 2. Mode-Specific Navigation

### Insert Mode
Ergonomic shortcuts designed to navigate comfortably without lifting your hands from the home row to reach the arrow keys or the `<Esc>` key.

| Keybinding | Action |
| :--- | :--- |
| `<Alt> + q` | Exit Insert Mode (Alternative to `<Esc>`) |
| `<Alt> + l` *or* `<Ctrl> + l` | Move cursor one character to the **Right** |
| `<Alt> + e` | Jump directly to the **End of the Line** |

### Visual Mode
Advanced structural manipulation of highlighted blocks of code.

| Keybinding | Action |
| :--- | :--- |
| `J` | Move selected block **Down** (auto-indents) |
| `K` | Move selected block **Up** (auto-indents) |
| `<` | Indent block **Left** (keeps selection active) |
| `>` | Indent block **Right** (keeps selection active) |

---

## 🐛 3. Development & Tooling

### 🪲 Debugger (DAP Hub: `<Space>d`)
Manage breakpoints, stepping execution, and user interface layouts during debug sessions.

| Keybinding | Action |
| :--- | :--- |
| `<leader>dc` | Debugger: **Continue** execution |
| `<leader>ds` | Debugger: **Step Over** line |
| `<leader>di` | Debugger: **Step Into** function |
| `<leader>db` | Debugger: **Toggle Breakpoint** on current line |
| `<leader>du` | Debugger: **Toggle UI** layout panels |
| `<leader>dr` | Debugger: **Restart** current session |

### 📂 File Explorer (Neo-tree: `<Space>e`/`o`/`r`)
Interactions with your workspace directory layout tree.

| Keybinding | Action |
| :--- | :--- |
| `<leader>e` | **Toggle** File Explorer sidebar open/closed |
| `<leader>o` | Shift **Focus** window directly to File Explorer |
| `<leader>r` | **Reveal** the active file within the directory tree |

### 🔍 Search & Find (Fzf-lua: `<Space>f`)
Fuzzy finder integrations powered by `fzf-lua`.

| Keybinding | Action |
| :--- | :--- |
| `<leader>ff` | Search for **Files** by name |
| `<leader>fg` | **Live Grep** (Search text inside all project files) |
| `<leader>fh` | Open file **History** (recently closed files) |
| `<leader>fb` | Filter through active **Buffers** |

### 🛠️ LSP & LaTeX Support (`<Space>l` / `<Space>L`)
Language Server Protocol engine interactions and document formatting.

| Keybinding | Action |
| :--- | :--- |
| `<leader>ld` | Go to Symbol **Definition** |
| `<leader>lr` | Smart Variable/Function **Rename** |
| `<leader>la` | Trigger LSP **Code Action** context menu |
| `<leader>lh` | Show Documentation **Hover** popup card |
| `<leader>lf` | Re-format document asynchronously |
| `<leader>li` | Show connected **LSP Info** status panel |
| `<leader>Lc` | **LaTeX**: Compile active project document |
| `<leader>Lv` | **LaTeX**: View compiled PDF output document |

---

## 🪟 4. Environment Management

### 📑 Buffer Controls
Navigate and manage active file buffers.

| Keybinding | Action |
| :--- | :--- |
| `[b` | Switch to the **Previous Buffer** |
| `]b` | Switch to the **Next Buffer** |
| `<leader>bd` | **Delete** (Close) current buffer |
| `<leader>ba` | **Close Other Buffers** safely (preserves your active workspace layout) |

### 🖼️ Window Splits & Navigation
Manage viewports across split structures. Use standard Vim directions (`h, j, k, l`).

| Keybinding | Action |
| :--- | :--- |
| `<leader>ww` | Save active buffer contents to disk (`:update`) |
| `<leader>wv` | Create a **Vertical Split** window view |
| `<leader>ws` | Create a **Horizontal Split** window view |
| `<leader>wq` | **Close** the current active window view pane |
| `<Ctrl> + h` | Shift focus window **Left** |
| `<Ctrl> + j` | Shift focus window **Down** |
| `<Ctrl> + k` | Shift focus window **Up** |
| `<Ctrl> + l` | Shift focus window **Right** |

#### Window Resizing Layout Control
Adjust focus viewport sizing using standard terminal arrow keys.
* **Height Modification**: `<Ctrl> + Up` (Grow) / `<Ctrl> + Down` (Shrink)
* **Width Modification**: `<Ctrl> + Right` (Grow) / `<Ctrl> + Left` (Shrink)

---

## 💻 5. Integrated Terminal (`<Space>t`)

Powered by `ToggleTerm`. All active terminal panes automatically map custom directional escapes so you can move windows without changing modes.

### Normal Mode Activations
* `<leader>t` : Toggle Standard Default Terminal View
* `<leader>tf` : Open Terminal in a centered **Floating** window overlay
* `<leader>th` : Open Terminal in a **Horizontal** split layout
* `<leader>tv` : Open Terminal in a **Vertical** split layout

### Active Terminal Pane Mode Interactions (`t` mode)
When typing inside the terminal, use these combinations to control Neovim without executing native shell commands:

| Keybinding | Terminal Mode Action |
| :--- | :--- |
| `<Esc><Esc>` | Escape out of Terminal insertion mode into Terminal normal mode |
| `<Ctrl> + h` | Jump out of terminal pane to the window **Left** |
| `<Ctrl> + j` | Jump out of terminal pane to the window **Down** |
| `<Ctrl> + k` | Jump out of terminal pane to the window **Up** |
| `<Ctrl> + l` | Jump out of terminal pane to the window **Right** |

---

## 📋 6. System Clipboard Operations

Explicit bindings designed to bridge your Neovim environment with your system operating system pasteboard registers (`+`).

* `<leader>y` : **Yank (Copy)** active highlighted selection or line directly to system clipboard. (Works in *Normal* and *Visual* modes).
* `<leader>yp` : **Paste** clipboard content directly into document.
