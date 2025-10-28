
#!/usr/bin/env bash
# ======================================================
# Universal Network Tools Installer (Debian/Ubuntu/Arch)
# Author: Ginko
# ======================================================

set -euo pipefail
LOGFILE="$HOME/network_tools_install.log"

echo "🔧 Starting Network Tools installation..."
echo "📄 Log file: $LOGFILE"
echo "" >"$LOGFILE"

install_pkg() {
    local PKG="$1" DESC="$2"
    echo "👉 Installing $DESC ($PKG)..." | tee -a "$LOGFILE"
    if command -v apt &>/dev/null; then
        sudo DEBIAN_FRONTEND=noninteractive apt install -yq "$PKG" >>"$LOGFILE" 2>&1
    elif command -v pacman &>/dev/null; then
        sudo pacman -S --noconfirm "$PKG" >>"$LOGFILE" 2>&1
    else
        echo "⚠️ Unsupported system. Please install $PKG manually." | tee -a "$LOGFILE"
        return
    fi

    if command -v "$PKG" &>/dev/null; then
        echo "   ✅ [$PKG] Installed successfully" | tee -a "$LOGFILE"
    else
        echo "   ❌ [$PKG] Installation failed or not found" | tee -a "$LOGFILE"
    fi
    echo "" | tee -a "$LOGFILE"
}

# ─── Update system ────────────────────────────────────────────────
echo "🔄 Updating system repositories..." | tee -a "$LOGFILE"
if command -v apt &>/dev/null; then
    sudo apt update -yq >>"$LOGFILE" 2>&1
    sudo DEBIAN_FRONTEND=noninteractive apt dist-upgrade -yq >>"$LOGFILE" 2>&1
elif command -v pacman &>/dev/null; then
    sudo pacman -Syu --noconfirm >>"$LOGFILE" 2>&1
fi
echo "" | tee -a "$LOGFILE"

# ─── Core network utilities ───────────────────────────────────────
install_pkg iproute2 "Modern networking tools (ip, ss)"
install_pkg ethtool "NIC configuration and diagnostics"
install_pkg network-manager "NetworkManager CLI (nmcli)"

# ─── Connectivity testing ─────────────────────────────────────────
install_pkg mtr "Traceroute + ping in realtime"
install_pkg nmap "Port and service scanner"
install_pkg netcat-openbsd "Netcat (TCP/UDP testing)"

# ─── Bandwidth testing ────────────────────────────────────────────
install_pkg iperf3 "Throughput testing (TCP/UDP)"
install_pkg bmon "Realtime bandwidth monitor"

# ─── HTTP / API testing ───────────────────────────────────────────
install_pkg curl "Standard HTTP client"
install_pkg httpie "User-friendly HTTP client"

# ─── Packet capture & analysis ────────────────────────────────────
if command -v apt &>/dev/null; then
    echo "wireshark-common wireshark-common/install-setuid boolean false" | sudo debconf-set-selections
fi
install_pkg tcpdump "Packet capture CLI"
install_pkg tshark "Wireshark CLI analyzer"

# ─── SSH & secure connections ─────────────────────────────────────
install_pkg openssh-client "SSH client (ssh, scp, sftp)"
install_pkg autossh "Persistent SSH tunnels"
install_pkg mosh "Next-gen SSH for unstable links"

# ─── Network monitoring ───────────────────────────────────────────
install_pkg iftop "Realtime traffic per connection"
install_pkg lsof "List open network sockets"

echo "✅ Installation completed. Check $LOGFILE for details."
