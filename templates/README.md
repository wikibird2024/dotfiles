# templates

Starting points copied into new projects. Not stowed.

| Path | Contents |
|---|---|
| `new-firmware.sh` | `new-firmware.sh <dir> [chip]` — copies `embedded-firmware/` into `<dir>` and sets the chip (default STM32F746NG) in the justfile, VS Code launch config and OpenOCD target, and writes `CODE_STYLE.md` from `claude/.claude/rules/c-code-style.md` (the one master copy). Chip names: `probe-rs chip list`. Existing files are kept. |
| `embedded-firmware/` | CMake + `justfile` project skeleton: `CMakePresets.json`, `cmake/arm-none-eabi.cmake` toolchain, `just build / flash / debug` recipes used by both VS Code and Neovim; `.clang-format` (layout), `.clang-tidy` (name check, shown live by clangd), `.clangd` (no name check in CubeMX folders) |

`just` and `probe-rs` are installed by `steps/02_tools.sh`.

## Flash

Each project owns its flash command as a CMake target `flash`, so Neovim
(`<leader>cf`), `just flash`, VS Code and the terminal all do the same thing:
`cmake --build --preset <preset> --target flash`. For a CubeMX project, copy
`embedded-firmware/cmake/flash.cmake` and add after `add_executable`:

```cmake
include(cmake/flash.cmake)
add_flash_target(${CMAKE_PROJECT_NAME})   # chip from the .ioc; or CHIP STM32F411RE
```

It uses probe-rs, else STM32_Programmer_CLI (`$STM32_PRG_PATH`), and reads
every write back. Pick one tool like Zephyr's `west flash --runner`:
`cmake --preset debug -DFLASH_RUNNER=stm32cubeprogrammer` (or `probe-rs`,
`auto`). An app behind a bootloader writes its own `flash` target instead (the
spin coater's runs `tools/flash.py`, which also writes the boot record).
