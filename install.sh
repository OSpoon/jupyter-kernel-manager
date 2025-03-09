#!/bin/bash

# Create installation directory
INSTALL_DIR="$HOME/jupyter-kernel-manager"
SCRIPT_DIR="$INSTALL_DIR/bin"
SCRIPT_PATH="$SCRIPT_DIR/jkm.sh"

# Create directory if not exists
echo "Creating installation directory..."
mkdir -p "$INSTALL_DIR"

# Download script
echo "Downloading script..."
curl -o "$SCRIPT_PATH" https://raw.githubusercontent.com/OSpoon/jupyter-kernel-manager/main/bin/jkm.sh

# Make script executable
chmod +x "$SCRIPT_PATH"

# Add to PATH in shell config
SHELL_CONFIG="$HOME/.zshrc"
if [ -f "$HOME/.bashrc" ]; then
    SHELL_CONFIG="$HOME/.bashrc"
fi

if ! grep -q "$INSTALL_DIR" "$SHELL_CONFIG"; then
    echo "Adding to PATH..."
    echo "export PATH=\"\$PATH:$INSTALL_DIR\"" >> "$SHELL_CONFIG"
    export PATH="$PATH:$INSTALL_DIR"
fi

echo -e "\nInstallation completed!"
echo "Script installed to: $SCRIPT_PATH"
echo "Please restart your terminal and use 'jkm' command"

read -p "Press Enter to exit"