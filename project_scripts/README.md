# project_scripts

Build / test / deploy scripts for CMake projects. Not stowed: copy a script
into a project's folder and edit the **Project settings** block at its top.

| Script | Does | Used in |
|---|---|---|
| `build.sh` | configure + build a CMake preset, check the output (one `.hex` / `.bin` each, or the PC program), optionally copy the firmware to a PC tool's folder | STM32F7 spray coating: App (firmware), debugger (Qt tool) |
| `test.sh` | configure + build a separate host-test project, run ctest, report "7/7 passed" | STM32F7 spray coating: App |
| `deploy.sh` | Grader Tool only: CMake `Debug` build, `scp` the firmware and `rsync` the tool to a lab machine | Grader Tool |

## build.sh

```sh
./build.sh              # first preset in PRESETS
./build.sh Release      # another preset (unknown names are refused)
```

Steps: configure (`cmake --preset`, so a fresh clone or a deleted build folder
just works) → build → verify → copy (only when `COPY_DIR` is set) → summary.

| Setting | Firmware + PC tool | PC program (Qt, ...) |
|---|---|---|
| `PRESETS` | `(Debug Release)` | `(debug release asan)` |
| `BUILD_ROOT` | `"build"` | `"build-cmake"` |
| `ARTIFACTS` | `(hex bin)`: each must exist exactly once | `()` |
| `PROGRAM` | `""` | `"my_tool"`: checks `$BUILD_DIR/bin/my_tool`, warns if an old copy is still running |
| `COPY_DIR` / `COPY_TYPES` | `"../My_Tool/FW"` / `(hex)`: fixed file name, so the tool's path is set once; a missing tool folder only warns | `""` |

## test.sh

```sh
./test.sh               # all tests
./test.sh StepGen       # only tests matching the name (ctest -R); fails if none match
```

Settings: `TEST_DIR` (the test project's folder), `BUILD_DIR`. Counts come from
ctest's own summary line; the full output is kept in `$BUILD_DIR/ctest_output.log`.
Colors switch off when the output goes to a file.

## deploy.sh

Still the Grader Tool version: the SSH target (`greystone@172.16.21.48`) and
paths are hard-coded. For new firmware projects that flash over a probe, prefer
`templates/embedded-firmware/` (a `justfile` with build / flash / debug).
