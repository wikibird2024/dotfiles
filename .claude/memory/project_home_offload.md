---
name: project-home-offload
description: "This PC keeps large home folders on the HDD at /mnt/storage/home_offload, symlinked back; the system SSD is small"
metadata:
  node_type: memory
  type: project
  originSessionId: 01dc6ddb-47ec-4825-b43f-6e39667cef19
  modified: 2026-11-05T06:54:36.697Z
---

Large home folders live in `/mnt/storage/home_offload` with a symlink at the old path: `.nuget`, `.stm32cubeide`, `.stm32cubemx`, `.wine`, `.arduino15`, `hvtt_shots`, `vtt_shots`, `CuongHoang`, `esp`, `.espressif` (most moved 2026-11-05).

**Why:** the system SSD is only 87 GB and reached 92% full; the HDD has 1.5 TB free.

**How to apply:** when space runs low, use the same pattern (copy, checksum compare, symlink). Keep Neovim, Rust, the ARM toolchain and active projects on the SSD for speed. The HDD mounts with `nofail`, so if it is missing the PC boots but these tools fail: check the mount first. Snaps stay on the SSD.
