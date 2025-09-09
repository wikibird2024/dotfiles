
# ~/.bash_functions
# ==========================================
# Ginko Pro Shell Functions - Clean & Professional
# Purpose:
# - Manual pyenv enable/disable for avoiding ESP-IDF conflicts
# - Load ESP-IDF environment cleanly without pyenv interference
# - Run idf.py inside ESP-IDF env safely
# - Provide toggle and status functions for pyenv
# ==========================================

# --- Enable pyenv in current shell session ---
e_pyenv() {
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

# --- Disable pyenv in current shell session ---
d_pyenv() {
    export PATH=$(echo "$PATH" | tr ':' '\n' | grep -v "$HOME/.pyenv/bin" | paste -sd ':' -)
    unset PYENV_ROOT
    echo "❌ Pyenv disabled."
}

# --- Toggle pyenv enable/disable ---
toggle_pyenv() {
    if [[ "$PATH" == *"$HOME/.pyenv/bin"* ]]; then
        disable_pyenv
    else
        enable_pyenv
    fi
}

# --- Show current pyenv status ---
pyenv_status() {
    if [[ "$PATH" == *"$HOME/.pyenv/bin"* ]]; then
        echo "✅ Pyenv ENABLED."
        pyenv version
    else
        echo "❌ Pyenv DISABLED."
    fi
}

# --- Load ESP-IDF environment in current shell, keep current directory ---
idf() {
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

# --- Run idf.py inside ESP-IDF env without pyenv interference ---
idf_py() {
    local espidf_dir="$HOME/esp/esp-idf"

    # If first argument is a directory, use it as esp-idf path
    if [ -d "$1" ]; then
        espidf_dir="$1"
        shift
    fi

    if [ ! -d "$espidf_dir" ]; then
        echo "❌ ESP-IDF directory not found: $espidf_dir"
        return 1
    fi

    disable_pyenv

    cd "$espidf_dir" || return 1

    if [ ! -f export.sh ]; then
        echo "⚠️ export.sh not found in $espidf_dir"
        return 1
    fi

    source ./export.sh

    idf.py "$@"
}

# --- Quick change to ESP-IDF directory ---
goto_espidf() {
    local espidf_dir="${1:-$HOME/esp/esp-idf}"
    if [ -d "$espidf_dir" ]; then
        cd "$espidf_dir" || return 1
        echo "📂 Changed directory to ESP-IDF: $espidf_dir"
    else
        echo "❌ ESP-IDF directory not found: $espidf_dir"
        return 1
    fi
}

# --- END OF ~/.bash_functions ---
