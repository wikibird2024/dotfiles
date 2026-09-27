# claude

Global instructions and skills for [Claude Code](https://claude.com/claude-code).

Stowed by `steps/04_stow.sh` (`stow -R -t ~ claude`). `04_stow.sh` creates `~/.claude/skills/` as a real folder first, so only
these files are linked and Claude Code's own data (credentials, history) never ends up in git.

| File | Purpose |
|---|---|
| `.claude/CLAUDE.md` | rules for every project (naming, wording, ...) |
| `.claude/skills/project-status/SKILL.md` | `/project-status`: read-only report on the current repo (git, build, tests, open work) |

`~/.claude/settings.json` is **not** linked: Claude Code writes to it. A new machine gets a copy of
`templates/claude/settings.json` once.
