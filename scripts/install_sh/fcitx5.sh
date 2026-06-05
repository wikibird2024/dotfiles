#!/bin/bash

# Set Script to exit immediately if a command exits with a non-zero status
set -e

# --- 1. Install Fcitx5 and Bamboo Packages ---
echo "--- Starting system update and installation of Fcitx5 + Bamboo ---"

# Update package lists
sudo apt update

# Install Fcitx5, config tool, required frontends (GTK/Qt), and the Bamboo input method.
# In Debian/Ubuntu, fcitx5-chinese-addons often includes fcitx5-bamboo.
sudo apt install -y fcitx5 fcitx5-config-tool fcitx5-frontend-gtk3 fcitx5-frontend-qt5 fcitx5-module-xorg fcitx5-chinese-addons

echo "--- Package installation completed ---"

# --- 2. Set Environment Variables ---
echo "--- Setting Fcitx5 Environment Variables ---"

PROFILE_FILE="$HOME/.profile"

# Check and append environment variables to ~/.profile if they don't already exist
if ! grep -q "GTK_IM_MODULE=fcitx" "$PROFILE_FILE"; then
    echo "" >> "$PROFILE_FILE"
    echo "# Fcitx5 Environment Variables (Vietnamese Input)" >> "$PROFILE_FILE"
    echo "export GTK_IM_MODULE=fcitx" >> "$PROFILE_FILE"
    echo "export QT_IM_MODULE=fcitx" >> "$PROFILE_FILE"
    echo "export XMODIFIERS=@im=fcitx" >> "$PROFILE_FILE"
    echo "export SDL_IM_MODULE=fcitx" >> "$PROFILE_FILE"
    echo "Environment variables have been added to $PROFILE_FILE. You must LOG OUT/LOG IN for them to take effect."
else
    echo "Environment Variables already exist in $PROFILE_FILE."
fi

# --- 3. Post-Script Instructions ---
echo "
#############################################################
#              MANDATORY FINAL STEPS
#############################################################

1. LOG OUT AND LOG IN AGAIN:
   This step is essential for the environment variables to take effect and for Fcitx5 to start correctly.

2. CONFIGURE THE BAMBOO INPUT METHOD:
   After logging back in, you must OPEN THE FCITX5 CONFIGURATION TOOL:
   - Open Terminal and type: fcitx5-configtool
   - In the configuration window, click the '+' button (Add Input Method).
   - Uncheck 'Only show current language'.
   - Find and select 'Bamboo'. (If Bamboo is not listed, try 'Vietnamese' or 'Unikey' if installed).
   - Click OK.

3. USAGE:
   - Use the key combination **Ctrl + Space** (or **Shift + Space**) to switch to the Bamboo input method.
   - Test by typing Vietnamese characters with diacritics (e.g., 'aa' -> 'â', 'ow' -> 'ơ').

Installation complete. Good luck!
"
