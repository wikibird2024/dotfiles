#!/usr/bin/env bash
# Setup modular Kitty config (pro style)

CONFIG_DIR="$HOME/.config/kitty"
PROFILE_DIR="$CONFIG_DIR/profiles"

echo ">>> Creating Kitty config structure in $CONFIG_DIR"

# Create directories
mkdir -p "$PROFILE_DIR"

# Create main kitty.conf
cat > "$CONFIG_DIR/kitty.conf" << 'EOF'
# Main Kitty config - modular includes
include font.conf
include theme.conf
include keybindings.conf
include performance.conf
include profiles/ssh_example.conf
EOF

# Create font.conf
cat > "$CONFIG_DIR/font.conf" << 'EOF'
# Font configuration
font_family      JetBrainsMono Nerd Font
bold_font        auto
italic_font      auto
font_size        12.0
disable_ligatures never
EOF

# Create theme.conf
cat > "$CONFIG_DIR/theme.conf" << 'EOF'
# Theme / Colorscheme (Catppuccin example)
background #1e1e2e
foreground #cdd6f4
cursor     #89b4fa

color0  #45475a
color1  #f38ba8
color2  #a6e3a1
color3  #f9e2af
color4  #89b4fa
color5  #cba6f7
color6  #94e2d5
color7  #bac2de
EOF

# Create keybindings.conf
cat > "$CONFIG_DIR/keybindings.conf" << 'EOF'
# Keybindings for splits & navigation (Vim/Tmux style)

# Splits
map ctrl+shift+enter     launch --location=hsplit
map ctrl+shift+backspace launch --location=vsplit

# Move between panes (Vim-like)
map ctrl+h neighboring_window left
map ctrl+l neighboring_window right
map ctrl+j neighboring_window down
map ctrl+k neighboring_window up

# Tabs
map ctrl+tab     next_tab
map ctrl+shift+tab previous_tab

# Clipboard
map ctrl+shift+c copy_to_clipboard
map ctrl+shift+v paste_from_clipboard
EOF

# Create performance.conf
cat > "$CONFIG_DIR/performance.conf" << 'EOF'
# Performance tuning
scrollback_lines 20000
repaint_delay 8
input_delay 2
sync_to_monitor yes
background_opacity 0.95
EOF

# Create example profile
cat > "$PROFILE_DIR/ssh_example.conf" << 'EOF'
# Example profile: SSH into server
# Usage: open new tab with: kitty @ launch --type=tab --cwd=$HOME --profile ssh_example

launch --type=tab --title "My Server" ssh user@server.example.com
EOF

echo ">>> Kitty config setup complete!"
echo ">>> You can edit the files inside $CONFIG_DIR"

