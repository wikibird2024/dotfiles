# scripts

Stand-alone helper and installer scripts, run by hand. Not stowed, not used by `bootstrap.sh`.

| Path | Contents |
|---|---|
| `build_tex.sh`, `clean_tex.sh` | build a LaTeX document / remove its temp files |
| `extract_function.sh` | list the function declarations in the headers of `main/` and `components/` (ESP-IDF layout) into `function_list_by_component.txt` |
| `network-setup.sh` | NetworkManager privacy setup (run with sudo); uses `configs/` |
| `configs/00-macrandomize.conf`, `99-privacy.conf` | NetworkManager snippets: random MAC while scanning, privacy options |
| `dependency_i3.sh` | install packages the i3 config needs |
| `install_sh/` | older one-tool installers (Debian/Ubuntu): nvim, fzf, fd, ripgrep, tmux, esp-idf, pyenv, fcitx5, nerd fonts... |
| `install_arch_sh/` | the same for Arch: yay (AUR helper), fcitx5, esp-idf, i3blocks, tmux... |

Most of `install_sh/` is superseded by `bootstrap.sh`; keep for one-off installs.
