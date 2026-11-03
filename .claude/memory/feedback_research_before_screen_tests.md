---
name: feedback-research-before-screen-tests
description: "Don't loop trial-and-error tests that pop windows on the user's live desktop; research the community fix first"
metadata:
  node_type: memory
  type: feedback
  originSessionId: b70f9f7d-1544-42a7-bd9a-c3339e1ac67e
  modified: 2026-09-29T02:25:53.039Z
---

When a desktop tool (e.g. Flameshot on niri) misbehaves, look up how the community solves it (niri wiki/issues, the tool's issues) before running repeated experiments that open overlays or windows on the user's live screen.

**Why:** 2026-09-29, debugging Flameshot 14 on niri, I kept launching `flameshot gui` overlays and toggling config to test guesses; the user stopped it: "stop spam. find the proper way to do it seek it on community".

**How to apply:** one reproduction to confirm the symptom, then search (WebSearch/WebFetch on GitHub issues, niri wiki) for the known fix; test the found fix once. Ask before any test that takes over the screen.
