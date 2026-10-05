# steps

The five stages of `bootstrap.sh`, run in order. Each can also run alone (`bash steps/03_fonts.sh`)
and is safe to re-run. Not stowed.

| Step | Does | Skip flag |
|---|---|---|
| `01_packages.sh` | system packages (apt / pacman): build tools, stow, zsh, ripgrep, linters, desktop apps (i3, kitty, niri, noctalia on Arch...), pip tools | `--skip-packages` |
| `02_tools.sh` | tools from upstream: Neovim, fzf, fd, starship, zoxide, TPM, Rust, stylua, luacheck, lazygit, just, probe-rs, tms, yazi, delta, ripsecrets | `--skip-tools` |
| `03_fonts.sh` | JetBrainsMono Nerd Font into `~/.local/share/fonts` | `--skip-fonts` |
| `04_stow.sh` | links every package, moves blocking files aside, turns on the repo's secret check (`.githooks`), sets the color profile, seeds Claude settings, vim plugins | `--skip-stow` |
| `05_shell.sh` | makes zsh the login shell — **off** unless `--set-zsh-shell` | – |

`./bootstrap.sh --only-stow` = step 4 only (after `git pull`).

Distros: Arch and Debian/Ubuntu (apt). niri and Noctalia are installed on Arch only — on
Debian/Ubuntu they need a PPA, a third-party repo or a source build (see `niri/README.md`).
A failed `cargo install` warns and continues; other failures stop the step.
