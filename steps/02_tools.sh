#!/usr/bin/env bash
# Step 2 — Install CLI tools: Neovim, fzf, fd, starship, zoxide
# Each block is guarded — safe to re-run.

set -euo pipefail
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/lib/log.sh"
source "$DOTFILES_DIR/lib/detect.sh"

log_step "02 — CLI tools"

# Release-file names differ per CPU: neovim uses x86_64/arm64,
# lazygit uses x86_64/arm64 too (uname -m says aarch64 on ARM).
case "$(uname -m)" in
    x86_64) REL_ARCH=x86_64 ;;
    aarch64 | arm64) REL_ARCH=arm64 ;;
    *) REL_ARCH="" ;;
esac

# ── Neovim (latest stable AppImage / tarball) ─────────────────
install_neovim() {
    if has nvim; then
        log_ok "nvim $(nvim --version | head -1) already installed."
        return
    fi
    if [ -z "$REL_ARCH" ]; then
        log_warn "No Neovim release for $(uname -m) — install nvim with your package manager."
        return
    fi
    log_info "Installing Neovim (latest stable)..."
    local tmp; tmp=$(mktemp -d)
    curl -Lo "$tmp/nvim.tar.gz" \
        https://github.com/neovim/neovim/releases/latest/download/nvim-linux-${REL_ARCH}.tar.gz
    sudo tar -C /usr/local --strip-components=1 -xzf "$tmp/nvim.tar.gz"
    rm -rf "$tmp"
    log_ok "nvim $(nvim --version | head -1) installed."
}

# ── fzf ───────────────────────────────────────────────────────
install_fzf() {
    if has fzf; then
        log_ok "fzf $(fzf --version) already installed."
    else
        log_info "Installing fzf..."
        rm -rf "$HOME/.fzf"
        git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
        "$HOME/.fzf/install" --all --no-update-rc >/dev/null
        log_ok "fzf installed."
    fi
    # ~/.fzf/bin is only on PATH in interactive shells. A symlink in
    # ~/.local/bin makes fzf visible everywhere: tmux popups, launchers,
    # scripts run outside a shell.
    if [ -x "$HOME/.fzf/bin/fzf" ]; then
        mkdir -p "$HOME/.local/bin"
        ln -sf "$HOME/.fzf/bin/fzf" "$HOME/.local/bin/fzf"
    fi
}

# ── fd ────────────────────────────────────────────────────────
install_fd() {
    if has fd; then
        log_ok "fd already installed."
        return
    fi
    log_info "Installing fd..."
    local pm; pm=$(detect_pkg_manager)
    case "$pm" in
        apt)
            # fd-find is the apt package name; binary is 'fdfind'
            sudo apt-get install -y fd-find
            # Alias fdfind → fd in local bin
            mkdir -p "$HOME/.local/bin"
            ln -sf "$(which fdfind)" "$HOME/.local/bin/fd"
            ;;
        pacman) sudo pacman -S --needed --noconfirm fd ;;
        *)
            log_warn "Install fd manually: https://github.com/sharkdp/fd"
            ;;
    esac
    log_ok "fd installed."
}

# ── Starship prompt ───────────────────────────────────────────
install_starship() {
    if has starship; then
        log_ok "starship $(starship --version | head -1) already installed."
        return
    fi
    log_info "Installing starship..."
    curl -sS https://starship.rs/install.sh | sh -s -- --yes
    log_ok "starship installed."
}

# ── Zoxide (smart cd) ─────────────────────────────────────────
install_zoxide() {
    if has zoxide; then
        log_ok "zoxide already installed."
        return
    fi
    log_info "Installing zoxide..."
    curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
    log_ok "zoxide installed."
}

# ── TPM (Tmux Plugin Manager) — bootstrap only ────────────────
install_tpm() {
    local tpm_dir="$HOME/.tmux/plugins/tpm"
    if [ -d "$tpm_dir" ]; then
        log_ok "TPM already present."
        return
    fi
    log_info "Installing TPM..."
    git clone --depth 1 https://github.com/tmux-plugins/tpm "$tpm_dir"
    log_ok "TPM installed. Plugins will auto-install on first tmux launch."
}

# ── Rust toolchain (needed for stylua, and for any Rust work) ──
install_rust() {
    if has cargo; then
        log_ok "cargo $(cargo --version) already installed."
        return
    fi
    log_info "Installing Rust via rustup..."
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y --default-toolchain stable >/dev/null
    log_ok "Rust installed."
}

# ── stylua (Lua formatter, conform.nvim) ───────────────────────
install_stylua() {
    if has stylua; then
        log_ok "stylua already installed."
        return
    fi
    # shellcheck disable=SC1091
    [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
    if ! has cargo; then
        log_warn "cargo not found — skipping stylua install."
        return
    fi
    log_info "Installing stylua (cargo install)..."
    cargo install stylua --locked && log_ok "stylua installed." ||
        log_warn "stylua build failed — run: cargo install stylua --locked"
}

# ── satty (screenshot editor for niri: Print = slurp + grim + satty) ──
# Built with cargo: the release binary needs a newer glibc than Ubuntu 24.04.
# Needs libgtk-4-dev, libadwaita-1-dev, libepoxy-dev (01_packages.sh).
install_satty() {
    if has satty; then
        log_ok "satty already installed."
        return
    fi
    # shellcheck disable=SC1091
    [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
    if ! has cargo; then
        log_warn "cargo not found — skipping satty install."
        return
    fi
    log_info "Installing satty (cargo install)..."
    cargo install satty --locked && log_ok "satty installed." ||
        log_warn "satty build failed — run: cargo install satty --locked"
}

# ── luacheck (Lua linter, nvim-lint) ───────────────────────────
install_luacheck() {
    if has luacheck; then
        log_ok "luacheck already installed."
        return
    fi
    if ! has luarocks; then
        log_warn "luarocks not found — skipping luacheck install."
        return
    fi
    log_info "Installing luacheck (luarocks)..."
    sudo luarocks install luacheck
    log_ok "luacheck installed."
}

# ── lazygit (not in every distro's repos, so fetch the binary) ──
install_lazygit() {
    if has lazygit; then
        log_ok "lazygit $(lazygit --version | head -1) already installed."
        return
    fi
    if [ -z "$REL_ARCH" ]; then
        log_warn "No lazygit release for $(uname -m) — install it manually."
        return
    fi
    log_info "Installing lazygit..."
    local tmp; tmp=$(mktemp -d)
    local ver
    ver=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" \
        | grep -Po '"tag_name": *"v\K[^"]*' || true)
    if [ -z "$ver" ]; then
        log_warn "Could not determine latest lazygit version (GitHub API rate-limited?) — skipping, install manually."
        rm -rf "$tmp"
        return
    fi
    curl -Lo "$tmp/lazygit.tar.gz" \
        "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${ver}_Linux_${REL_ARCH}.tar.gz"
    tar -xzf "$tmp/lazygit.tar.gz" -C "$tmp" lazygit
    sudo install "$tmp/lazygit" /usr/local/bin/lazygit
    rm -rf "$tmp"
    log_ok "lazygit installed."
}

# ── just + probe-rs (embedded build/flash/debug; templates/embedded-firmware) ──
install_cargo_tool() {
    local bin="$1" crate="$2"
    if has "$bin"; then
        log_ok "$bin already installed."
        return
    fi
    # shellcheck disable=SC1091
    [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
    if ! has cargo; then
        log_warn "cargo not found — skipping $bin install."
        return
    fi
    log_info "Installing $bin (cargo install $crate)..."
    # a failed build (e.g. missing system libs) must not stop the other tools
    cargo install "$crate" --locked && log_ok "$bin installed." ||
        log_warn "$bin build failed — run: cargo install $crate --locked"
}

# ── rudo (left dock for niri without Noctalia, niri/.config/rudo) ──
# Needs gtk4-layer-shell, which Ubuntu 24.04 does not package: build it into
# ~/.local (no sudo) and link rudo to it with an rpath. Arch: Noctalia has a dock.
RUDO_TAG=v0.3.2
GTK4_LAYER_SHELL_TAG=v1.3.0
install_rudo() {
    if has rudo; then
        log_ok "rudo already installed."
        return
    fi
    has niri || { log_info "niri not installed — skipping rudo."; return; }
    has noctalia && { log_info "Noctalia has its own dock — skipping rudo."; return; }
    # shellcheck disable=SC1091
    [ -f "$HOME/.cargo/env" ] && source "$HOME/.cargo/env"
    if ! has cargo; then
        log_warn "cargo not found — skipping rudo install."
        return
    fi
    local lib
    lib="$HOME/.local/lib/$(gcc -dumpmachine 2>/dev/null || echo x86_64-linux-gnu)"
    if ! PKG_CONFIG_PATH="$lib/pkgconfig" pkg-config --exists gtk4-layer-shell-0; then
        log_info "Building gtk4-layer-shell $GTK4_LAYER_SHELL_TAG into ~/.local..."
        has meson || pip install --user --break-system-packages meson
        local tmp; tmp=$(mktemp -d)
        if ! (git clone -q --depth 1 -b "$GTK4_LAYER_SHELL_TAG" \
            https://github.com/wmww/gtk4-layer-shell "$tmp/src" &&
            meson setup "$tmp/build" "$tmp/src" --prefix "$HOME/.local" --libdir "$lib" \
                --buildtype release -Dintrospection=false -Dvapi=false \
                -Dexamples=false -Ddocs=false -Dtests=false >/dev/null &&
            ninja -C "$tmp/build" install >/dev/null); then
            rm -rf "$tmp"
            log_warn "gtk4-layer-shell build failed (needs libwayland-dev wayland-protocols libgtk-4-dev) — skipping rudo."
            return
        fi
        rm -rf "$tmp"
    fi
    # with steps/patches/rudo-*.patch (window -> app icon matching)
    log_info "Installing rudo $RUDO_TAG (cargo install, patched)..."
    local src; src=$(mktemp -d)
    if git clone -q --depth 1 -b "$RUDO_TAG" https://github.com/skorotkiewicz/rudo "$src" &&
        git -C "$src" apply "$DOTFILES_DIR"/steps/patches/rudo-*.patch &&
        PKG_CONFIG_PATH="$lib/pkgconfig" RUSTFLAGS="-C link-args=-Wl,-rpath,$lib" \
            cargo install --path "$src" --locked; then
        log_ok "rudo installed."
    else
        log_warn "rudo build failed — see install_rudo in steps/02_tools.sh"
    fi
    rm -rf "$src"
}

install_neovim
install_fzf
install_fd
install_starship
install_zoxide
install_tpm
install_rust
install_stylua
install_satty
install_luacheck
install_lazygit
install_cargo_tool just just
install_cargo_tool probe-rs probe-rs-tools
install_cargo_tool tms tmux-sessionizer
install_cargo_tool yazi yazi-fm # file manager, tmux prefix + e
# git: delta is the pager in git/.gitconfig; ripsecrets runs in .githooks/pre-commit
install_cargo_tool delta git-delta
install_cargo_tool ripsecrets ripsecrets
install_rudo

log_ok "All CLI tools done."
