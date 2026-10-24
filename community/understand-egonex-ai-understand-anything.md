# Egonex-AI/Understand-Anything

<https://github.com/Egonex-AI/Understand-Anything> · TypeScript · MIT · fit 🟡

Claude Code plugin: a multi-agent scan builds a knowledge graph of every
file, function and class (`.ua/knowledge-graph.json`), then a web dashboard
with guided tours, search by meaning, layer colors and "what does my diff
affect" (`/understand-diff`). Output can be in Vietnamese (`--language vi`).

## When we would use it

- Joining a large unknown codebase (vendor SDK, inherited project).
- `/understand-chat`, `/understand-explain <file>` for quick questions.

## Watch-outs

- The first `/understand` reads the whole repo: **many tokens** on a big
  project. Not worth it for our small firmware repos.
- Generated HAL/CubeMX code would fill the graph: exclude it.
- Adds a `.ua/` folder to the repo: add it to `.gitignore`.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-24 | 88k | v2.9.0 | 335 |
