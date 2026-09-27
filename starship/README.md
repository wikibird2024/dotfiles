# starship

Config for the [Starship](https://starship.rs) shell prompt (bash and zsh).

Stowed by `steps/04_stow.sh` (`stow -R -t ~ starship`). → `~/.config/starship.toml`

Compact two-line prompt: OS, user@host, folder, git branch/status, language versions (C, Rust,
Python, Node), memory, battery, command time, clock on the right. Timeouts raised for big repos
(Yocto). Uses ANSI color names, so it follows the terminal palette set by `theme`.
