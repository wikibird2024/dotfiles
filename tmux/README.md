# Tmux Configuration — APEX Stable

An optimized, highly stable, and production-ready Tmux configuration designed specifically for power users leveraging **i3wm/Hyprland** window managers and **Neovim** development environments.

This configuration eliminates responsiveness bottlenecks, guarantees perfect 24-bit TrueColor rendering, provides frictionless Vim-style workspace navigation, and implements an automated layout state backup strategy.

---

## 🚀 Architectural Highlights

- **Instantaneous Input Feedback**: Configures the terminal escape time to zero (`escape-time 0`). This eliminates the classic visual lag window when hitting the `<Esc>` key inside modal editors like Neovim.
- **Dynamic File Synchronization**: Explicitly activates terminal `focus-events`, enabling Neovim's automated buffers refresh mechanism (`:autoread`) whenever an updated file background state is detected.
- **Color Fidelity Correction**: Explicitly overrides terminal profiles using `tmux-256color` and mapping `RGB/Tc` attributes. This guarantees exact, uniform color scheme mapping for themes like Catppuccin across nested terminal pipelines.
- **Massive Historical Line Rollback**: Expands the terminal pane buffer memory to `50,000` concurrent lines to prevent data loss during long-running application diagnostics or verbose system builds.

---

## ⚡ Keybindings Reference Manual

### The Global Modifier
The default, unergonomic `Ctrl + b` prefix has been stripped from the system. Your new primary orchestration key combo is:

$$\mathbf{Prefix = C\text{-}a \quad (Ctrl + a)}$$

### Core Control Operations
*These operations require typing the `Prefix` sequence (`Ctrl + a`) prior to the trigger key.*

| Input Sequence | Target Runtime Action |
| :--- | :--- |
| `Prefix` $\rightarrow$ `\|` | Split pane **Vertically** (side-by-side) preserving current working directory (`$PWD`). |
| `Prefix` $\rightarrow$ `-` | Split pane **Horizontally** (top-and-bottom) preserving current working directory (`$PWD`). |
| `Prefix` $\rightarrow$ `S` | Execute emergency manual backup of all active workspace structures, layouts, and targets. |
| `Prefix` $\rightarrow$ `Ctrl + r` | Manually restore the last successfully cached hardware session configuration. |
| `Prefix` $\rightarrow$ `r` | Soft-reload the hardware `~/.tmux.conf` configurations directly into live sessions. |

### Zero-Prefix Pane Navigation (Vim Kinematics)
To accelerate multitasking transitions across active terminal splits, structural pane changes do not require the prefix key sequence. Hold down the **Alt key (`M-`)** alongside standard layout directions:

| Input Mapping | Action Vector |
| :--- | :--- |
| `Alt + h` | Shift focus directly to the terminal pane on the **Left** |
| `Alt + j` | Shift focus directly to the terminal pane **Below** |
| `Alt + k` | Shift focus directly to the terminal pane **Above** |
| `Alt + l` | Shift focus directly to the terminal pane on the **Right** |

---

## 📋 Buffer Copy Mode & System Clipboard Sync

This system forces the terminal environment to inherit structural **Vim navigation mechanics** when selecting text within raw execution outputs.

1. **Invocation**: Tap `Prefix` followed by `[` to enter the historical scrollback buffer layout layer.
2. **Kinematics**: Use standard navigation rules (`h`, `j`, `k`, `l`) to traverse up through old logs.
3. **Selection Boundaries**: Tap `v` to set the entry anchor point and toggle visual character highlighting.
4. **The Yank Action**: Tap `y` to extract the selection. The script securely transfers the content into the system operating system clipboard, clears the memory layout, and drops you back into live terminal insertion mode.

---

## 🔌 Automated Dependency Management (TPM)

The environment manages plugins natively using the **Tmux Plugin Manager (TPM)**. It includes automated configuration logic: if it detects that the engine is missing from local workspace files on launch, it automatically fetches the repository data from GitHub and triggers the package build scripts silently in the background.

### Integrated Extension Array
- `tmux-plugins/tpm`: The programmatic core manager framework.
- `tmux-plugins/tmux-sensible`: Standard baseline optimizations for universal stability shell safety rules.
- `tmux-plugins/tmux-yank`: Advanced low-level interface mechanics binding terminal streams to local system clipboards.
- `tmux-plugins/tmux-resurrect`: Safely captures internal environment structural states (paths, pane locations, active windows) to disk.
- `tmux-plugins/tmux-continuum`: Automates state snapshot intervals every **15 minutes** to protect work against power loss or hardware faults.

---

## 🎨 Visual Aesthetics & Status Interface

Features an elegant, minimalist theme styled after the **Catppuccin** palette framework pinned cleanly to the bottom workspace margin (`bg=#1e1e2e`, `fg=#cdd6f4`).

- **Left Accent**: Bright, bold yellow block highlighting the target terminal active session container (` #S`).
- **Center Array**: Explicitly locked tracking indexes (`#I:#W`). Dynamic process workspace window name hijacking (`allow-rename off`) is strictly disabled to prevent unstable tab reshuffling during long executions.
- **Right Accent**: Clean, real-time clock tracking indicators (`󱑒 %H:%M`) next to the active server session root user profile identity (`󰭹 #{user}`).
