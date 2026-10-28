# nimaltd/ternima

<https://github.com/nimaltd/ternima> · Rust (Tauri) · Apache-2.0 · fit 🟡

Desktop terminal for embedded work (Windows, macOS, Linux AppImage/deb):
serial with every option, **SEGGER RTT and SWO through ST-Link, J-Link or
CMSIS-DAP with no vendor software**, RTT over TCP while the IDE debugs,
Zephyr log filter, live plotter (FFT, XY, scope trigger), session record
and replay, **Modbus RTU/ASCII tester** (master or slave, frame table with
timing).

## When we would use it

- Reading RTT logs from an STM32 over ST-Link without J-Link tools or
  STM32CubeIDE.
- Modbus checks on machine controllers: poll, plot, see each frame.
- A human tool, not an agent tool: it gives Claude nothing.

## Watch-outs

- Brand new (created 2026-10-24, 9 stars), one author.
- Releases are not signed.
- Serial ports need the `dialout` group.
- ⚪ Not run yet.

## Snapshot

| Date | Stars | Version | Open issues |
|---|---|---|---|
| 2026-10-28 | 9 | v1.0.0 | 0 |
