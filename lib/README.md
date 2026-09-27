# lib

Shell helpers sourced by `bootstrap.sh` and `steps/*.sh`. Not stowed.

| File | Provides |
|---|---|
| `log.sh` | colored `log_info` / `log_ok` / `log_warn` / `log_error` / `log_step`, `has <cmd>`, `already_done` |
| `detect.sh` | `detect_pkg_manager` (apt → pacman → dnf), `pkg_install`, `pkg_update`, `detect_display` (wayland/x11) |

`pkg_update` on Arch runs `pacman -Syu` (a full upgrade — `-Sy` alone is an unsupported partial upgrade);
installs use `--needed` so re-running skips installed packages.
