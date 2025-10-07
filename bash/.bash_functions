
#!/bin/bash
# ==========================================
# ~/.bash_functions
# Ginko Pro Shell Functions - Safe & Professional
# Compatible Bash, tmux-safe
# ==========================================

# ==============================
# 0️⃣ Pyenv & ESP-IDF Management
# ==============================

function e_pyenv {
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"

    if command -v pyenv >/dev/null 2>&1; then
        eval "$(pyenv init --path)"
        eval "$(pyenv init -)"
        echo "✅ Pyenv enabled."
    else
        echo "⚠️ pyenv not found. Please install pyenv."
    fi
}

function d_pyenv {
    export PATH=$(echo "$PATH" | tr ':' '\n' | grep -v "$HOME/.pyenv/bin" | paste -sd ':' -)
    unset PYENV_ROOT
    echo "❌ Pyenv disabled."
}

function toggle_pyenv {
    if [[ "$PATH" == *"$HOME/.pyenv/bin"* ]]; then
        d_pyenv
    else
        e_pyenv
    fi
}

function pyenv_status {
    if [[ "$PATH" == *"$HOME/.pyenv/bin"* ]]; then
        echo "✅ Pyenv ENABLED."
        pyenv version
    else
        echo "❌ Pyenv DISABLED."
    fi
}

function idf {
    local espidf_dir="${1:-$HOME/esp/esp-idf}"

    if [ ! -d "$espidf_dir" ]; then
        echo "❌ ESP-IDF directory not found: $espidf_dir"
        return 1
    fi

    d_pyenv

    if [ ! -f "$espidf_dir/export.sh" ]; then
        echo "⚠️ export.sh not found in $espidf_dir"
        return 1
    fi

    source "$espidf_dir/export.sh"
    echo "🚀 ESP-IDF environment loaded (current dir unchanged)."
}

function idf_py {
    local espidf_dir="$HOME/esp/esp-idf"

    if [ -d "$1" ]; then
        espidf_dir="$1"
        shift
    fi

    if [ ! -d "$espidf_dir" ]; then
        echo "❌ ESP-IDF directory not found: $espidf_dir"
        return 1
    fi

    d_pyenv
    cd "$espidf_dir" || return 1

    if [ ! -f export.sh ]; then
        echo "⚠️ export.sh not found in $espidf_dir"
        return 1
    fi

    source ./export.sh
    idf.py "$@"
}

function goto_espidf {
    local espidf_dir="${1:-$HOME/esp/esp-idf}"
    if [ -d "$espidf_dir" ]; then
        cd "$espidf_dir" || return 1
        echo "📂 Changed directory to ESP-IDF: $espidf_dir"
    else
        echo "❌ ESP-IDF directory not found: $espidf_dir"
        return 1
    fi
}

# ==============================
# 1️⃣ Filesystem & Navigation
# ==============================

function mkcd { mkdir -p "$1" && cd "$1"; }
function back { cd -; }

function editf {
    local file
    file=$(find . -type f -name "$1" 2>/dev/null | head -n1)
    if [ -n "$file" ]; then
        nvim "$file"
    else
        echo "Không tìm thấy file: $1"
    fi
}

function clean_tmp { find . -type f -name '*.tmp' -delete; }

function extract {
    local file="$1"
    if [ ! -f "$file" ]; then
        echo "'$file' không tồn tại."
        return 1
    fi

    case "$file" in
        *.tar.bz2) tar xjf "$file" ;;
        *.tar.gz)  tar xzf "$file" ;;
        *.bz2)     bunzip2 "$file" ;;
        *.rar)     unrar x "$file" ;;
        *.gz)      gunzip "$file" ;;
        *.tar)     tar xf "$file" ;;
        *.tbz2)    tar xjf "$file" ;;
        *.tgz)     tar xzf "$file" ;;
        *.zip)     unzip "$file" ;;
        *.Z)       uncompress "$file" ;;
        *.7z)      7z x "$file" ;;
        *) echo "Không biết định dạng: '$file'" ;;
    esac
}

# ==============================
# 2️⃣ Git / VCS Helpers
# ==============================

function gcm { git add . && git commit -m "$1"; }
function gpr { git pull --rebase; }
function gco { git checkout -b "$1"; }
function glg { git log --oneline --graph --decorate --all; }
function gundo { git reset --soft HEAD~1; }

# ==============================
# 3️⃣ System / Dev Helpers
# ==============================

function topc { top -o %CPU; }
function psgrep { ps aux | grep "$1" | grep -v grep; }
function logs { tail -f "$1" | grep --color=auto "$2"; }
function search { grep -rnw --exclude-dir=.git "$1" .; }
function ports { sudo lsof -i -P -n | grep LISTEN; }
function speed { speedtest-cli --simple; }

# ==============================
# 4️⃣ Python / Virtualenv / Build Helpers
# ==============================

function venv { python3 -m venv .venv && source .venv/bin/activate; }
function run { source .venv/bin/activate && python3 "$1"; }
function pipup { python3 -m pip install --upgrade pip; }
function tpy { pytest -v --disable-warnings "$@"; }

# ==============================
# 5️⃣ Embedded / ESP-IDF Helpers
# ==============================

function ports_tty { ls /dev/ttyUSB*; }
function cport { sudo chmod 666 "$1"; }
function flash_all { idf.py build && idf.py flash monitor; }
function flash_only { idf.py flash monitor; }

# ==============================
# 6️⃣ Productivity / Misc
# ==============================

function backup { rsync -avh --progress "$1" "$2"; }
function reload { source ~/.bashrc; }
function now { date +"%Y-%m-%d %H:%M:%S"; }
function logtop { tar -xOzf "$1" | head -n "$2"; }
function fetch_extract { curl -LO "$1" && extract "$(basename $1)"; }

# ==============================
# END OF FILE
# ==============================
