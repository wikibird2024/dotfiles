# Graphify-Labs/graphify

<https://github.com/Graphify-Labs/graphify> · Python · Apache-2.0 · fit 🟡

`/graphify .` maps a project (code, docs, PDFs, images) into a knowledge
graph the agent queries instead of grep: `graph.html` (clickable),
`GRAPH_REPORT.md`, `graph.json`. Code is parsed locally with tree-sitter
(no LLM); docs, PDFs and images use the assistant. Every edge is marked
`EXTRACTED` or `INFERRED`.

## When we would use it

- A big firmware repo plus its datasheets and reference-manual PDFs in one
  graph ⚪ (not tried on C or on a 1000-page PDF).
- Overlaps archify + flow-map (pictures) and Understand-Anything (🔴 for
  tokens).

## Watch-outs

- `graphify install` registers itself into the assistant: read what it
  writes first.
- README pushes the paid Graphify Cloud.
- 1630 open issues; very fast release pace (v0.9.97).
- PDFs and images go through the model: token cost.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-28 | 137k | v0.9.97 | 1630 |
