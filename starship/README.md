# starship

Config for the [Starship](https://starship.rs) shell prompt (bash and zsh).

Stowed by `steps/04_stow.sh` (`stow -R -t ~ starship`). → `~/.config/starship.toml`

Boxed two-line prompt:

```
╭╴󰣇 dotfiles  main ⇡2 +3 !1 ?4                             ✘ 1 ✦1 took 3s 20:42:30
╰╴❯
```

- Left of the line, "where am I": OS logo (Arch/EndeavourOS, macOS, Windows; 🌿 Mint and Ubuntu; emoji for other systems), user@host (only as root, over SSH or as another
  user, e.g. in a container), container name, folder, git branch/state/status (counts: ⇡ahead ⇣behind +staged !modified ?untracked -deleted ~conflict *stash), language
  icons (C, 🦀 Rust, 🐍 Python + virtualenv, Node; no versions, to stay short in tmux splits),
  package version.
- Right of the line, "what just happened": exit code of a failed command, background jobs,
  memory (above 75%), command time (over 1s), clock.
- Battery is left to the Noctalia bar. No `sudo` module: it runs `sudo -n true` on every
  prompt and fills the journal with "a password is required".

Colors are ANSI names only (no hex), so the prompt follows the terminal palette set by `theme`;
the frame uses `bright-black` (palette color8, the dim color of every profile).
Timeouts are raised for big repos (Yocto).
