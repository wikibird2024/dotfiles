# dotfiles

Personal Linux setup for embedded work: niri (or i3) + kitty + tmux + Neovim.
Managed with [GNU Stow](https://www.gnu.org/software/stow/): each folder below that says
**stow** mirrors `$HOME`, and `stow <folder>` links its files into place.

## New machine

```bash
git clone https://github.com/wikibird2024/dotfiles.git ~/dotfiles
cd ~/dotfiles && ./bootstrap.sh          # packages, tools, fonts, links
./bootstrap.sh --only-stow               # later: re-link after a git pull
```

Arch and Debian/Ubuntu. Details and flags: [`steps/README.md`](steps/README.md).

## Folders

**Desktop**

| Folder | What | Install |
|---|---|---|
| [`niri`](niri/README.md) | niri compositor: workspaces, keys, scratchpad, focus-or-launch — **main desktop** | stow |
| [`noctalia`](noctalia/README.md) | Noctalia shell (bar, launcher...) for niri | stow |
| [`i3_wm_endervour`](i3_wm_endervour/README.md) | i3 X11 session, bar, scripts | stow |
| [`picom`](picom/README.md) | compositor for i3 | stow |
| [`Xresources`](Xresources/README.md) | X11 cursor, fonts, 1.25× DPI | stow |
| [`xorg`](xorg/README.md) | Caps Lock → Escape for X11 | `sudo stow -t / xorg` |
| [`fontconfig`](fontconfig/README.md) | font rendering | stow |
| [`theme`](theme/README.md) | `theme <name>`: one color profile for kitty, alacritty, tmux, Neovim | stow |

**Terminal and shell**

| Folder | What | Install |
|---|---|---|
| [`kitty`](kitty/README.md) | main terminal | stow |
| [`alacritty`](alacritty/README.md) | backup terminal | stow |
| [`xfce4_terminal`](xfce4_terminal/README.md) | Xfce terminal | manual stow |
| [`tmux`](tmux/README.md) | tmux + tms project switcher | stow |
| [`bash`](bash/README.md) | login shell: `.bashrc`, aliases, functions | stow |
| [`zsh`](zsh/README.md) | optional zsh | stow |
| [`starship`](starship/README.md) | prompt | stow |

**Editors and tools**

| Folder | What | Install |
|---|---|---|
| [`neovim`](neovim/README.md) | main editor (LSP, DAP, embedded C/C++, Rust) — manual in `MANUAL.md` | stow |
| [`neovim_light`](neovim_light/README.md) | lighter Neovim variant | not stowed |
| [`vim`](vim/README.md) | full Vim with plugins | stow |
| [`vim_light`](vim_light/README.md) | zero-dependency `.vimrc` to copy anywhere | copy |
| [`zathura`](zathura/README.md) | PDF viewer | stow |
| [`flameshot`](flameshot/README.md) | screenshots (i3) | stow |
| [`clang`](clang/README.md) | `.clang-format` C/C++ style | stow |
| [`mods`](mods/README.md) | AI on the command line | stow |
| [`claude`](claude/README.md) | Claude Code global rules and skills | stow |
| [`git`](git/README.md) | `.gitconfig` (delta), global ignore; secret check before commit | stow |

**Setup and extras**

| Folder | What |
|---|---|
| [`steps`](steps/README.md), [`lib`](lib/README.md) | the bootstrap stages and their helpers |
| [`templates`](templates/README.md) | embedded firmware project skeleton (`new-firmware.sh`), Claude settings seed |
| [`scripts`](scripts/README.md) | one-off helpers and older installers |
| [`project_scripts`](project_scripts/README.md) | build/test templates for CMake projects (firmware or PC tool), deploy example |
| [`asterisk`](asterisk/README.md) | Asterisk PBX config (copy to `/etc/asterisk`) |
| [`doc`](doc/README.md) | notes |

`CLAUDE.md` describes the repo for Claude Code.

