#!/usr/bin/env bash
# Step 1 — Install core system packages
# Idempotent: pacman --needed and apt skip already-installed packages.

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
    # neovim formatters/linters (see CLAUDE.md "External Tool Dependencies")
    shellcheck shfmt clang-format bear luarocks
    pkg-config libudev-dev     # cargo install probe-rs-tools (Arch: in base)
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
        sudo pacman -S --needed --noconfirm "${PKGS_PACMAN[@]}"
        ;;
    *)
        log_warn "Unknown package manager — install packages manually."
        ;;
esac

log_ok "Core packages done."

# ── Vim (vim stow package) ───────────────────────────────────
# Clipboard-enabled build (+clipboard for `set clipboard=unnamedplus`) and
# nodejs for coc.nvim. Best-effort: Arch's gvim conflicts with an installed
# vim, which --noconfirm refuses, so a failure here must not abort bootstrap.
case "$pm" in
    apt) sudo apt-get install -y vim-gtk3 nodejs || log_warn "vim/nodejs install failed — install manually." ;;
    pacman) sudo pacman -S --needed --noconfirm gvim nodejs || log_warn "gvim/nodejs install failed (replace vim with gvim manually)." ;;
esac

# ── Desktop apps (i3_wm_endervour / picom / zathura / flameshot / ─
#    kitty / alacritty stow packages ship configs for these; install
#    the actual programs too). Best-effort: one missing/renamed
#    package must not abort the rest of bootstrap.
# i3status-rust is not packaged for Debian/Ubuntu: the i3 bar falls back to i3blocks there.
# niri: Noctalia has no Ubuntu 24.04 package, so niri/.config/niri/scripts/shell uses
# waybar/fuzzel/mako/swaylock... instead. niri itself comes from pacstall on Ubuntu (see niri/README.md).
DESKTOP_PKGS_APT=(i3-wm i3status i3blocks rofi feh dunst picom zathura flameshot kitty alacritty
    waybar fuzzel mako-notifier swaylock swayidle swaybg brightnessctl playerctl cliphist wl-clipboard
    libnotify-bin foot picocom jq qtwayland5 sfwbar
    slurp grim libgtk-4-dev libadwaita-1-dev libepoxy-dev)
DESKTOP_PKGS_PACMAN=(i3-wm i3status i3status-rust i3blocks rofi feh dunst picom zathura flameshot kitty alacritty niri noctalia xwayland-satellite foot picocom jq)

install_desktop_pkg() {
    local pkg="$1" pm="$2"
    case "$pm" in
        apt)    sudo apt-get install -y "$pkg" ;;
        pacman) sudo pacman -S --needed --noconfirm "$pkg" ;;
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
