---
name: project-community-repo-notes
description: "dotfiles/community/ holds short notes on OSS repos worth watching; add or update one when asked to \"check\" a repo"
metadata:
  node_type: memory
  type: project
  originSessionId: 1f57b8f7-c71d-4978-92a3-e33559c224ab
  modified: 2026-10-21T01:43:57.592Z
---

Since 2026-10-21, `dotfiles/community/` keeps one short note per watched GitHub repo (`<owner>-<repo>.md`: what it is, when we'd use it, watch-outs, dated snapshot table) plus an index table in `community/README.md`. Not a stow package.

**Why:** Hao Tran wants a list of good/promising repos to re-check often, with a note on whether they may need them.

**How to apply:** when asked to check a repo, offer to add/update its note; on re-checks, append a new snapshot row (keep old rows to show the trend) and update "Last checked" in the index. The repo is public, so keep notes free of private details. Since 2026-10-28 the `/scout` skill (`claude/.claude/skills/scout/`, linked into `~/.claude/skills` and `~/.claude-personal/skills`) does this: topic + level scans, `check <repo>`, `recheck`; it writes notes only after a yes. Related: [[feedback-community-first-research]].
