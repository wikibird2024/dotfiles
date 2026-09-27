# templates

Starting points copied into new projects. Not stowed.

| Path | Contents |
|---|---|
| `new-firmware.sh` | `new-firmware.sh <dir> [chip]` — copies `embedded-firmware/` into `<dir>` and sets the chip (default STM32F746NG) in the justfile, VS Code launch config and OpenOCD target. Chip names: `probe-rs chip list`. Existing files are kept. |
| `embedded-firmware/` | CMake + `justfile` project skeleton: `CMakePresets.json`, `cmake/arm-none-eabi.cmake` toolchain, `just build / flash / debug` recipes used by both VS Code and Neovim |
| `claude/settings.json` | Claude Code settings copied once to `~/.claude/settings.json` on a new machine |

`just` and `probe-rs` are installed by `steps/02_tools.sh`.
