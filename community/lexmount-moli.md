# lexmount/moli

<https://github.com/lexmount/moli> · Rust · Apache-2.0 / MIT · fit 🟡

Headless browser for AI agents and scraping, a light replacement for headless
Chrome. Runs V8 + Servo/Stylo CSS; skips layout and paint unless asked
(`--layout`). One binary speaks CDP, WebDriver and BiDi, so Playwright,
Puppeteer and Selenium connect to it directly.

## When we would use it

- Claude Code gets an empty page from WebFetch (the site needs JavaScript):
  `moli fetch --dump markdown <url>` runs the JS first.
- Scraping or a browsing agent, if we ever build one.
- Simple Playwright scripts with ~1/10 of Chrome's memory.

Not for: full end-to-end UI tests (keep Chromium), Canvas/WebGL/media.

## Watch-outs

- ~1 in 5 automation tasks fail where Chrome passes (their own benchmark:
  ~82% vs ~99.8%).
- Open bugs: no HTML5 drag-and-drop (#1101); layout not updated after DOM
  changes (#1080); slow geometry queries on big pages (#1617).
- Install is `curl … | sh`: read the script first.
- Made by Lexmount, which also sells a cloud version.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-21 | 19.9k | v1.1.18 | 415 |
