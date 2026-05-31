# Neovim Keymap Guide (Personal Configuration)

## 1. Core Design

This setup is organized into 3 layers:

- Vim Core (navigation + code intelligence)
- Leader Layer (workspace actions)
- VS Code Compatibility Layer (minimal alias only)

---

## 2. Global Rules

- Leader key: `Space`
- Workspace actions: `Space + ...`
- Code navigation: `gd / gr / gi / K`
- Buffers behave like tabs (`Tab / Shift+Tab`)
- VS Code shortcuts are optional and secondary

---

## 3. File & Search

### Find files
- `Space + f + f`

### Search in project
- `Space + f + g`

### Recent files
- `Space + f + h`

### Buffers
- `Space + f + b`

### VS Code style (optional)
- `Ctrl + P` → find files
- `Space + sg` → search project
- `Space + p` → command palette

---

## 4. Code Navigation (Core Vim)

- `gd` → go to definition
- `gr` → references
- `gi` → implementation
- `K` → hover documentation

---

## 5. Diagnostics

- `[d` → previous error/warning
- `]d` → next error/warning

---

## 6. Buffers (Tabs)

- `Tab` → next buffer
- `Shift + Tab` → previous buffer
- `Space + b + d` → delete buffer

---

## 7. Window Management

### Move between windows
- `Ctrl + h/j/k/l`

### Resize windows
- `Ctrl + Arrow Keys`

### Split windows
- `Space + |` → vertical split
- `Space + -` → horizontal split

---

## 8. File Explorer

- `Space + e` → toggle explorer
- `Space + o` → focus explorer
- `Space + r` → reveal current file

---

## 9. Terminal

- `Space + t` → toggle terminal
- `Space + tf` → floating terminal
- `Space + th` → horizontal terminal
- `Space + tv` → vertical terminal

---

## 10. Debug (DAP)

- `Space + d + c` → continue
- `Space + d + s` → step over
- `Space + d + i` → step into
- `Space + d + b` → breakpoint
- `Space + d + u` → toggle debug UI
- `Space + d + r` → restart

---

## 11. LSP (Code Intelligence)

### Core Vim keys
- `gd` → definition
- `gr` → references
- `gi` → implementation
- `K` → hover

### Leader actions
- `Space + l + a` → code action
- `Space + l + d` → definition (menu)
- `Space + l + r` → rename
- `Space + l + f` → format
- `Space + l + i` → LSP info
- `Space + l + o` → outline

---

## 12. Visual Mode

- `J` → move line down
- `K` → move line up
- `<` → indent left
- `>` → indent right

---

## 13. Clipboard

- `Space + y` → copy to system clipboard
- `Space + y + p` → paste from system clipboard

---

## 14. VS Code Compatibility Layer

Minimal shortcuts for transition only:

- `Ctrl + P` → quick open files
- `Ctrl + B` → toggle explorer
- `Space + p` → command palette
- `Space + sg` → project search
- `Alt + Left` → go back
- `Alt + Right` → go forward

---

## 15. Usage Strategy

### Beginner
- Use Ctrl+P / Ctrl+B freely
- Use Space shortcuts for search and tools

### Intermediate
- Start using:
  - `gd / gr / K`
  - `Space + f / l`

### Advanced
- Ctrl layer becomes optional
- Leader + Vim core becomes primary workflow

---

## 16. Mental Model

- Ctrl layer → convenience (VS Code migration)
- Leader layer → workspace control
- Vim core → speed and navigation (professional standard)
