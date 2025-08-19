
#!/bin/bash
# ======================================================
# Network Tools Installer for Debian/Ubuntu
# Installs each package individually and logs results
# ======================================================

LOGFILE="$HOME/network_tools_install.log"

echo "🔄 Starting network tools installation..." | tee "$LOGFILE"
echo "Log file: $LOGFILE"

# Install + log function
install_pkg() {
    PKG=$1
    DESC=$2
    echo "👉 Installing $DESC ($PKG)..." | tee -a "$LOGFILE"
    if sudo apt install -y "$PKG" >>"$LOGFILE" 2>&1; then
        echo "   ✅ [$PKG] Installed successfully" | tee -a "$LOGFILE"
    else
        echo "   ❌ [$PKG] Installation failed" | tee -a "$LOGFILE"
    fi
    echo "" | tee -a "$LOGFILE"
}

# System update first
echo "🔄 Updating system..." | tee -a "$LOGFILE"
sudo apt update -y >>"$LOGFILE" 2>&1 && sudo apt upgrade -y >>"$LOGFILE" 2>&1
echo "" | tee -a "$LOGFILE"

# 1. Network management & configuration
install_pkg iproute2 "Modern networking tools (ip, ss)"
install_pkg ethtool "NIC configuration and diagnostics"
install_pkg network-manager "NetworkManager CLI (nmcli)"

# 2. Connectivity testing
install_pkg mtr "Traceroute + ping in realtime"
install_pkg nmap "Port and service scanner"
install_pkg netcat-openbsd "Netcat (TCP/UDP testing)"

# 3. Bandwidth and performance testing
install_pkg iperf3 "Throughput testing (TCP/UDP)"
install_pkg bmon "Realtime bandwidth monitoring"

# 4. HTTP / API testing
install_pkg curl "Standard HTTP client"
install_pkg httpie "User-friendly HTTP client"

# 5. Packet capture & analysis
install_pkg tcpdump "Packet capture CLI"
install_pkg tshark "Wireshark CLI analyzer"

# 6. SSH & secure connections
install_pkg openssh-client "SSH client (ssh, scp, sftp)"
install_pkg autossh "Persistent SSH tunnels"
install_pkg mosh "Next-gen SSH for unstable links"

# 7. Network monitoring
install_pkg iftop "Realtime per-connection traffic"
install_pkg lsof "Check which processes us_
