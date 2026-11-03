---
name: project-history-rewrite-2026-10-05
description: "dotfiles git history was rewritten twice on 2026-10-05 (keys removed, then squashed/reworded); other clones must reset"
metadata:
  node_type: memory
  type: project
  originSessionId: 38155389-a218-4075-81e4-777e5f2bc853
  modified: 2026-10-05T12:16:08.952Z
---

On 2026-10-05 the public dotfiles repo history was force-pushed twice: first to strip 4 leaked Google API keys (git filter-repo), then rebuilt as a straight line (433 → 252 commits, merges flattened, every message reworded to `ADD|MOD|FIX|DEL: summary`, one author `TranHao <tranhaobku2017@gmail.com>`).

**Why:** keys had been committed to a public repo; old messages were "ok", "..", Vietnamese one-worders.

**How to apply:**
- Any other clone (home laptop, hx_main, hx_inspiron machines) must run `git fetch && git reset --hard origin/main` once; a plain `git pull` would merge the old history (and the keys) back in. If old-looking commits ("Merge branch 'main'", messages like "ok") reappear, that is what happened.
- Backups with the old history (still containing keys) live at `~/dotfiles-backup-2026-10-05*.git` until the user deletes them.
- The user still had to revoke the keys in the Google console; ask if unsure.
- Commit messages follow `TYPE: summary` (ADD/MOD/FIX/DEL); a `.githooks/pre-commit` runs ripsecrets.
