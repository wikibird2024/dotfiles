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

# Run the nearest <script> (this folder or above, up to the git repo root;
# outside a repo, this folder only) and say which one, since a repo can hold
# several (App, Boot) that take different args. The script runs as its own
# process, so it cannot change this shell; the project scripts cd to their
# own folder. With none found, list the ones in the folders below.
function run_nearest_script {
    local name=$1
    shift
    local here root dir found path
    here=$(pwd -P) # physical path, to compare with git's root
    root=$(git rev-parse --show-toplevel 2>/dev/null) || root=$here
    dir=$here
    until [[ -x $dir/$name || $dir == "$root" || $dir == / ]]; do
        dir=$(dirname "$dir")
    done
    if [[ ! -x $dir/$name ]]; then
        echo "$name: none in this folder or above (up to ${root##*/})" >&2
        found=$(find "$here" -maxdepth 3 \( -name build -o -name .git -o -name node_modules \) -prune \
            -o -name "$name" -type f -executable -print 2>/dev/null | sort)
        if [[ -n $found ]]; then
            echo "cd into one of these folders:" >&2
            while IFS= read -r path; do
                echo "  ${path#"$here"/}" >&2
            done <<<"$found"
        fi
        return 1
    fi
    echo "→ ${dir##*/}/$name $*"
    "$dir/$name" "$@"
}

# Project scripts from any subfolder: b = build, tests, flash. Not `test`:
# that is a shell builtin other code calls (nvm.sh). The unalias clears the
# old `b` alias when this file is sourced into a running shell.
unalias b 2>/dev/null
function b { run_nearest_script build.sh "$@"; }
function tests { run_nearest_script test.sh "$@"; }
function flash { run_nearest_script flash.sh "$@"; }

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
