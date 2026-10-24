# pbakaus/impeccable

<https://github.com/pbakaus/impeccable> · Rust (engine) + Markdown · Apache-2.0 · fit 🟡

Design skill that grew from Anthropic's `frontend-design`. One skill, 24
commands (`/impeccable audit`, `critique`, `polish`, `typeset`, `layout`,
`harden`, `live` …) and 62 fixed rules that catch the "AI look" (Inter
everywhere, purple gradients, cards in cards, gray text on color). The rules
also run as a CLI with no LLM and no API key.

## When we would use it

- Any web page or dashboard we build: `/impeccable init` once (writes
  `PRODUCT.md`), then `audit` / `polish` before shipping.
- The better of our two design picks for a real product UI.

## Watch-outs

- Web only (HTML/CSS/JS); not for Avalonia windows.
- `init` writes `PRODUCT.md` / `DESIGN.md` into the repo.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-24 | 86k | engine-v0.1.17 | 37 |
