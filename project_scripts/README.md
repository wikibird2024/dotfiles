# project_scripts

Build / test / deploy scripts from a work firmware project (Grader Tool), kept here as examples. Not stowed.

| Script | Does |
|---|---|
| `build.sh` | CMake build into `build/Debug`, copies the firmware into `../Grader_Tool/FW` |
| `test.sh` | builds and runs the tests in their own build folder |
| `deploy.sh` | CMake `Debug` build, `scp` the firmware and `rsync` the Grader Tool to a lab machine |

**Project-specific:** paths and the SSH target (`greystone@172.16.21.48`) are hard-coded.
Copy into a project and edit the variables at the top. For new projects prefer
`templates/embedded-firmware/` (a `justfile` with build / flash / debug).
