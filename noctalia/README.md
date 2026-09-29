# noctalia

Hand-written config for the [Noctalia](https://docs.noctalia.dev) desktop shell used with niri
(bar, launcher, notifications, lock, wallpaper).

Stowed by `steps/04_stow.sh` (`stow -R -t ~ noctalia`). → `~/.config/noctalia/`

| File | Contents |
|---|---|
| `bar.toml` | workspaces widget shows names (`1 Browser`, `2 Dev`...) instead of numbers |

Noctalia merges every `*.toml` here. **Settings changed in the Settings window (`Mod+,`) go to
`~/.local/state/noctalia/settings.toml` (not tracked) and override these files.** Keys and panels:
`niri/README.md`. Docs: <https://docs.noctalia.dev/noctalia/configuration/>.
