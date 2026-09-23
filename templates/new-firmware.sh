#!/usr/bin/env bash
# Copy the embedded-firmware template into a project and set the chip everywhere
# it appears (justfile CHIP, launch.json "chip", OpenOCD target cfg).
#
#   new-firmware.sh <project-dir> [chip]     chip defaults to STM32F746NG
#   e.g. new-firmware.sh ~/work/blinky STM32F411RE
#
# Chip names: `probe-rs chip list`. Existing files in <project-dir> are kept.

set -euo pipefail

TEMPLATE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/embedded-firmware"

dest="${1:?usage: new-firmware.sh <project-dir> [chip]}"
chip="${2:-STM32F746NG}"

# Capture first: `grep -q` exits early and probe-rs then fails on a broken pipe
if command -v probe-rs >/dev/null && ! grep -qxE "[[:space:]]*$chip" <<<"$(probe-rs chip list)"; then
    echo "error: probe-rs doesn't know chip '$chip' (see: probe-rs chip list | grep ...)" >&2
    exit 1
fi

# OpenOCD target: longest chip-name prefix with a matching cfg, e.g.
# STM32F746NG -> stm32f7x.cfg, STM32H743ZI -> stm32h7x.cfg,
# nRF52840_xxAA -> nrf52.cfg, RP2040 -> rp2040.cfg.
# ESP32 is skipped: its OpenOCD support lives in Espressif's fork.
ocd_dir=/usr/share/openocd/scripts/target
ocd_target="target/CHANGE-ME.cfg"
lc="$(echo "$chip" | tr '[:upper:]' '[:lower:]')"
if [[ $lc != esp32* ]]; then
    for ((n = ${#lc}; n >= 4; n--)); do
        p="${lc:0:n}"
        if [ -f "$ocd_dir/${p}x.cfg" ]; then ocd_target="target/${p}x.cfg"; break; fi
        if [ -f "$ocd_dir/${p}.cfg" ]; then ocd_target="target/${p}.cfg"; break; fi
    done
fi

mkdir -p "$dest"
cp -r --update=none "$TEMPLATE"/. "$dest"/

sed -i -E "s/^(CHIP +:= )\".*\"/\1\"$chip\"/; s#target/[a-z0-9_-]+\.cfg#$ocd_target#" "$dest/justfile"
sed -i -E "s/(\"chip\": )\".*\"/\1\"$chip\"/; s#target/[a-z0-9_-]+\.cfg#$ocd_target#" "$dest/.vscode/launch.json"

echo "Created $dest for $chip (OpenOCD: $ocd_target)"
if [ "$ocd_target" = "target/CHANGE-ME.cfg" ]; then
    echo "note: no OpenOCD target found for $chip; probe-rs recipes work, but set the" \
         "OpenOCD cfg in justfile + launch.json before using the OpenOCD fallback." >&2
fi
if [[ $lc == esp32* || $lc == gd32v* ]]; then
    echo "note: $chip isn't ARM; replace cmake/arm-none-eabi.cmake with its toolchain." >&2
fi
