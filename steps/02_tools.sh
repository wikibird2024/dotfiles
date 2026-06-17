#!/usr/bin/env bash
# Step 2 — Install CLI tools: Neovim, fzf, fd, starship, zoxide
# Each block is guarded — safe to re-run.

set -euo pipefail
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/lib/log.sh"
source "$DOTFILES_DIR/lib/detect.sh"

log_step "02 — CLI tools"

# ── Neovim (latest stable AppImage / tarball) ─────────────────
install_neovim() {
    if has nvim; then
        log_ok "nvim $(nvim --version | head -1) already installed."
        return
    fi
    log_info "Installing Neovim (latest stable)..."
    local tmp; tmp=$(mktemp -d)
    curl -Lo "$tmp/nvim.tar.gz" \
        https://github.com/neovim/neovim/releases/latest/download/nvim-linux-x86_64.tar.gz
    sudo tar -C /usr/local --strip-components=1 -xzf "$tmp/nvim.tar.gz"
    rm -rf "$tmp"
    log_ok "nvim $(nvim --version | head -1) installed."
}

# ── fzf ───────────────────────────────────────────────────────
install_fzf() {
    if has fzf; then
        log_ok "fzf $(fzf --version) already installed."
        return
    fi
    log_info "Installing fzf..."
    rm -rf "$HOME/.fzf"
    git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
    "$HOME/.fzf/install" --all --no-update-rc >/dev/null
    log_ok "fzf installed."
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
        pacman) sudo pacman -S --noconfirm fd ;;
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

install_neovim
install_fzf
install_fd
install_starship
install_zoxide
install_tpm

log_ok "All CLI tools done."
