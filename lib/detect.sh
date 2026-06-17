#!/usr/bin/env bash
# Detect OS package manager and display server — sourced by install steps

detect_pkg_manager() {
    if has apt;    then echo "apt";    return; fi
    if has pacman; then echo "pacman"; return; fi
    if has dnf;    then echo "dnf";    return; fi
    echo "unknown"
}

# pkg_install <pkg-apt> [pkg-pacman] [pkg-dnf]
# Installs a package using the detected package manager.
# If only one arg given, the same name is used across all managers.
pkg_install() {
    local apt_pkg="${1}"
    local pac_pkg="${2:-$1}"
    local dnf_pkg="${3:-$1}"
    local pm
    pm=$(detect_pkg_manager)
    case "$pm" in
        apt)    sudo apt-get install -y "$apt_pkg" ;;
        pacman) sudo pacman -S --noconfirm "$pac_pkg" ;;
        dnf)    sudo dnf install -y "$dnf_pkg" ;;
        *)      log_error "Unknown package manager. Install '$apt_pkg' manually."; return 1 ;;
    esac
}

pkg_update() {
    local pm
    pm=$(detect_pkg_manager)
    case "$pm" in
        apt)    sudo apt-get update -y ;;
        pacman) sudo pacman -Sy ;;
        dnf)    sudo dnf check-update -y || true ;;
    esac
}

detect_display() {
    if [ "${WAYLAND_DISPLAY:-}" != "" ] || [ "${XDG_SESSION_TYPE:-}" = "wayland" ]; then
        echo "wayland"
    else
        echo "x11"
    fi
}
