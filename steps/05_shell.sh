#!/usr/bin/env bash
# Step 5 — Set zsh as the default shell

set -euo pipefail
DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$DOTFILES_DIR/lib/log.sh"

log_step "05 — Default shell"

ZSH_PATH="$(which zsh 2>/dev/null || true)"

if [ -z "$ZSH_PATH" ]; then
    log_error "zsh not found — did step 01 run successfully?"
    exit 1
fi

if [ "$SHELL" = "$ZSH_PATH" ]; then
    log_ok "zsh is already the default shell."
    exit 0
fi

log_info "Changing default shell to $ZSH_PATH..."

# Add zsh to /etc/shells if missing (required for chsh)
if ! grep -qxF "$ZSH_PATH" /etc/shells; then
    log_info "Adding $ZSH_PATH to /etc/shells..."
    echo "$ZSH_PATH" | sudo tee -a /etc/shells >/dev/null
fi

chsh -s "$ZSH_PATH"
log_ok "Default shell set to zsh. Takes effect on next login."
