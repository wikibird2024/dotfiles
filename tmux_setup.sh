
#!/bin/bash
# ==========================================================
# TMUX Dotfiles Setup Script
# ==========================================================
# Purpose:
# - Create the plugin directory
# - Clone TPM (Tmux Plugin Manager) if not present
# - Set executable permissions
# - Provide instructions to install plugins inside tmux
# ==========================================================

set -e  # Exit script if any command fails

# TPM plugin directory
TMUX_PLUGIN_DIR="$HOME/.tmux/plugins"

# 1️⃣ Create plugin directory if it doesn't exist
mkdir -p "$TMUX_PLUGIN_DIR"

# 2️⃣ Clone TPM if not already installed
if [ ! -d "$TMUX_PLUGIN_DIR/tpm" ]; then
    echo "Cloning TPM (Tmux Plugin Manager)..."
    git clone https://github.com/tmux-plugins/tpm "$TMUX_PLUGIN_DIR/tpm"
else
    echo "TPM already exists, skipping clone."
fi

# 3️⃣ Set executable permissions for TPM
chmod +x "$TMUX_PLUGIN_DIR/tpm/tpm"

# 4️⃣ Check if .tmux.conf exists
if [ ! -f "$HOME/.tmux.conf" ]; then
    echo "Warning: ~/.tmux.conf not found!"
    echo "Make sure to symlink or copy your .tmux.conf first."
fi

# 5️⃣ Instructions to install plugins
echo
echo "==========================="
echo "TMUX setup is ready."
echo "- Open tmux:"
echo "    tmux"
echo "- Press prefix + I (Ctrl-a + I) to install all plugins listed in .tmux.conf"
echo "==========================="
