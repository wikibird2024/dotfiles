#!/bin/bash
# ==========================================
# ~/.bash_functions
# Loaded by .bashrc after .aliases, so a function here must not share a
# name with an alias (the alias would always win).
# ==========================================

# ==============================
# Navigation
# ==============================

# Jump to the folder yazi was in when it closed
function y() {
    local tmp="$(mktemp -t yazi-cwd.XXXXXX)"
    yazi "$@" --cwd-file="$tmp"
    if [ -f "$tmp" ]; then
        local cwd
        cwd=$(<"$tmp")
        if [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
            cd -- "$cwd"
        fi
        rm -f -- "$tmp"
    fi
}

# ==============================
# Embedded
# ==============================

# Load the ESP-IDF environment (current dir unchanged). Usage: idf [esp-idf dir]
function idf {
    local espidf_dir="${1:-$HOME/esp/esp-idf-v5.5.1}"

    if [ ! -f "$espidf_dir/export.sh" ]; then
        echo "❌ export.sh not found in $espidf_dir"
        return 1
    fi

    source "$espidf_dir/export.sh"
    echo "🚀 ESP-IDF environment loaded (current dir unchanged)."
}

# STM32 boards: run the nearest flash.sh (this folder or above, inside the git
# repo) and say which one, since the App and Boot scripts take different args.
function flash {
    local dir=$PWD
    until [[ -x $dir/flash.sh || -d $dir/.git || $dir == / ]]; do
        dir=$(dirname "$dir")
    done
    if [[ ! -x $dir/flash.sh ]]; then
        echo "flash: no flash.sh in this folder or above" >&2
        return 1
    fi
    echo "→ ${dir##*/}/flash.sh $*"
    "$dir/flash.sh" "$@"
}

# ==============================
# Files
# ==============================

sync-dir() {
    if [ "$#" -ne 2 ]; then
        echo "Usage: sync-dir <source_directory> <destination_directory>"
        return 1
    fi

    local src="$1"
    local dest="$2"

    echo "🚀 Starting optimized rsync transfer from $src to $dest..."

    # Hard links, ACLs, xattrs, sparse files, one file system, progress bar;
    # --delete removes files in dest that are not in src
    rsync -aHAXx --sparse --info=progress2 --delete "$src" "$dest"
}

# ==============================
# Network
# ==============================

iplocal() {
    echo -e "\033[1;34m[Internal Interfaces]\033[0m"
    # Thay \e bằng \033 để awk không báo lỗi
    ip -br -4 addr show | awk '$3 != "" && $1 != "lo" {
        label = ($1 ~ /^wg/) ? "🔒 VPN" : ($1 ~ /^wl/) ? "🌐 WiFi" : "🔌 Other";
        printf "  %-10s %-8s => \033[1;32m%s\033[0m\n", $1, label, $3
    }'
}

myip() {
    echo -e "\033[1;34m[Public Identity]\033[0m"
    local info=$(curl -s "http://ip-api.com/json/?fields=status,country,city,isp,query")

    if [[ $(echo "$info" | jq -r .status) == "success" ]]; then
        # Dùng jq để format đẹp, nhớ dùng -r để không bị dính dấu ngoặc kép
        echo "$info" | jq -r '"  IP       => \u001b[1;32m\(.query)\u001b[0m", "  Provider => \u001b[1;33m\(.isp)\u001b[0m", "  Location => \u001b[1;35m\(.city), \(.country)\u001b[0m"'
    else
        echo -ne "  IP       => \033[1;31m"
        curl -s https://ifconfig.me && echo -e "\033[0m"
    fi
}
