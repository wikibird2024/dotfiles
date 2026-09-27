# mods

Config for [mods](https://github.com/charmbracelet/mods), AI on the command line
(`git diff | mods "write a commit message"`).

Stowed by `steps/04_stow.sh` (`stow -R -t ~ mods`). → `~/.config/mods/mods.yml`

Default provider **Gemini** (`gemini-2.5-flash`), format presets for `-f` (markdown / json),
MCP server examples. API keys come from environment variables, not this file.
