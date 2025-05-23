#!/bin/bash

# Detect the Linux distribution
if [ -f /etc/os-release ]; then
    . /etc/os-release
    DISTRO=$ID
elif type lsb_release >/dev/null 2>&1; then
    DISTRO=$(lsb_release -si | tr '[:upper:]' '[:lower:]')
else
    echo "Cannot detect Linux distribution. Trying to use apt-get by default."
    DISTRO="debian"
fi

# Function to check if xterm is already installed
check_xterm_installed() {
    if command -v xterm >/dev/null 2>&1; then
        echo "xterm is already installed."
        return 0
    else
        echo "xterm is not installed. Installing now..."
        return 1
    fi
}

# Function to fix Kali repositories and GPG keys
fix_kali_repos() {
    echo "Fixing Kali Linux repositories and GPG keys..."
    
    # Fix GPG key issues
    sudo apt-get update --allow-insecure-repositories || true
    sudo apt-get install -y gnupg
    wget -qO - https://archive.kali.org/archive-key.asc | sudo apt-key add -
    
    # Update repositories with proper keys
    echo "deb http://http.kali.org/kali kali-rolling main non-free contrib" | sudo tee /etc/apt/sources.list
    sudo apt-get update
}

# Install xterm based on distribution
install_xterm() {
    case $DISTRO in
        ubuntu|debian|linuxmint|pop|kali)
            # Try to fix apt sources if there are network issues
            if ! ping -c 1 8.8.8.8 >/dev/null 2>&1; then
                echo "Network connectivity issues detected. Trying to use local mirrors..."
                if [ -f /etc/apt/sources.list.d/kali.list ]; then
                    sudo mv /etc/apt/sources.list.d/kali.list /etc/apt/sources.list.d/kali.list.bak
                fi
            fi
            
            # If Kali Linux, fix repositories first
            if [ "$DISTRO" = "kali" ]; then
                fix_kali_repos
            else
                # Update and install xterm
                sudo apt-get update
            fi
            
            # Install xterm
            sudo apt-get install -y xterm
            INSTALL_STATUS=$?
            
            # If xterm is not found, try x-terminal-emulator which is commonly available in Kali
            if [ $INSTALL_STATUS -ne 0 ] && [ "$DISTRO" = "kali" ]; then
                echo "xterm package not found. Trying alternative terminal emulators..."
                TERMINAL_INSTALLED=false
                
                for terminal in qterminal konsole gnome-terminal mate-terminal xfce4-terminal lxterminal terminator; do
                    echo "Trying to install $terminal..."
                    if sudo apt-get install -y $terminal; then
                        TERMINAL_INSTALLED=true
                        echo "$terminal has been successfully installed!"
                        break
                    fi
                done
                
                if [ "$TERMINAL_INSTALLED" = false ]; then
                    echo "Failed to install any terminal emulator."
                    return 1
                fi
            fi
            ;;
        fedora|centos|rhel)
            sudo dnf install -y xterm
            ;;
        arch|manjaro)
            sudo pacman -S --noconfirm xterm
            ;;
        opensuse*)
            sudo zypper install -y xterm
            ;;
        *)
            echo "Unsupported distribution: $DISTRO"
            echo "Trying apt-get as fallback..."
            sudo apt-get update
            sudo apt-get install -y xterm
            
            # If the above fails, try installing a generic terminal emulator
            if [ $? -ne 0 ]; then
                echo "Trying alternative terminal emulators..."
                TERMINAL_INSTALLED=false
                
                for terminal in qterminal konsole gnome-terminal mate-terminal xfce4-terminal lxterminal terminator; do
                    echo "Trying to install $terminal..."
                    if sudo apt-get install -y $terminal; then
                        TERMINAL_INSTALLED=true
                        echo "$terminal has been successfully installed!"
                        break
                    fi
                done
                
                if [ "$TERMINAL_INSTALLED" = false ]; then
                    echo "Failed to install any terminal emulator."
                    return 1
                fi
            fi
            ;;
    esac
    return 0
}

# Main execution
echo "Checking for xterm installation..."
if ! check_xterm_installed; then
    echo "Installing xterm for $DISTRO..."
    
    # Try to install and capture the result
    if install_xterm; then
        # Verify installation
        if command -v xterm >/dev/null 2>&1; then
            echo "xterm has been successfully installed!"
        else
            # Check for any available terminal emulator
            TERMINAL_FOUND=false
            for terminal in qterminal konsole gnome-terminal mate-terminal xfce4-terminal lxterminal terminator; do
                if command -v $terminal >/dev/null 2>&1; then
                    echo "$terminal is available as an alternative to xterm."
                    TERMINAL_FOUND=true
                    break
                fi
            done
            
            if [ "$TERMINAL_FOUND" = false ]; then
                echo "No terminal emulator was found. Installation failed."
                exit 1
            fi
        fi
    else
        echo "Installation failed."
        exit 1
    fi
fi

echo "Terminal emulator is ready to use." 