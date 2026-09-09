#!/usr/bin/env bash
# Step 1 — Install core system packages
# Idempotent: apt/pacman won't reinstall already-present packages.

set -euo pipefail
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/lib/log.sh"
source "$DOTFILES_DIR/lib/detect.sh"

log_step "01 — Core system packages"

pkg_update

# ── Essentials ────────────────────────────────────────────────
PKGS_APT=(
    git curl wget unzip build-essential
    stow zsh
    xclip xsel wl-clipboard   # clipboard backends
    ripgrep                    # rg (used by nvim live grep)
    fontconfig                 # fc-cache for nerd fonts
    python3 python3-pip
    ninja-build cmake gettext  # needed if building nvim from source
    # nvim2 formatters/linters (see CLAUDE.md "External Tool Dependencies")
    shellcheck shfmt clang-format bear luarocks
)

PKGS_PACMAN=(
    git curl wget unzip base-devel
    stow zsh
    xclip xsel wl-clipboard
    ripgrep
    fontconfig
    python python-pip
    ninja cmake
    shellcheck shfmt clang bear luarocks
)

pm=$(detect_pkg_manager)
log_info "Package manager: $pm"

case "$pm" in
    apt)
        sudo apt-get install -y "${PKGS_APT[@]}"
        ;;
    pacman)
        sudo pacman -S --noconfirm "${PKGS_PACMAN[@]}"
        ;;
    *)
        log_warn "Unknown package manager — install packages manually."
        ;;
esac

log_ok "Core packages done."

# ── Desktop apps (i3_wm_endervour / picom / zathura / flameshot / ─
#    kitty / alacritty stow packages ship configs for these; install
#    the actual programs too). Best-effort: one missing/renamed
#    package must not abort the rest of bootstrap.
DESKTOP_PKGS_APT=(i3-wm i3status i3blocks rofi feh dunst picom zathura flameshot kitty alacritty)
DESKTOP_PKGS_PACMAN=(i3-wm i3status i3blocks rofi feh dunst picom zathura flameshot kitty alacritty)

install_desktop_pkg() {
    local pkg="$1" pm="$2"
    case "$pm" in
        apt)    sudo apt-get install -y "$pkg" ;;
        pacman) sudo pacman -S --noconfirm "$pkg" ;;
    esac
}

if [ "$pm" = "apt" ] || [ "$pm" = "pacman" ]; then
    log_info "Installing desktop apps for i3/tiling-WM configs (best-effort)..."
    list_ref="DESKTOP_PKGS_${pm^^}[@]"
    for pkg in "${!list_ref}"; do
        install_desktop_pkg "$pkg" "$pm" \
            && log_ok "$pkg installed." \
            || log_warn "$pkg failed/unavailable — install manually if you use i3."
    done
fi

# ── Python tools nvim-dap-python / nvim-lint expect ───────────────
# Ubuntu/Debian mark the system python as externally-managed (PEP 668);
# --break-system-packages is required, and debugpy must land in the
# system-visible python3 (not an isolated venv) so nvim-dap-python can
# `import debugpy` directly.
if has python3; then
    log_info "Installing cpplint + debugpy for nvim..."
    # --break-system-packages is only understood by pip >= 23 and only
    # needed on PEP 668 distros; fall back to it only if the plain
    # install is refused, so older distros aren't broken by an unknown flag.
    python3 -m pip install --user --quiet cpplint debugpy 2>/dev/null \
        || python3 -m pip install --user --break-system-packages --quiet cpplint debugpy \
        && log_ok "cpplint + debugpy installed." \
        || log_warn "pip install of cpplint/debugpy failed — install manually."
fi
