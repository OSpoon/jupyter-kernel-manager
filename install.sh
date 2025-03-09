#!/bin/bash

# Create installation directory
INSTALL_DIR="$HOME/jupyter-kernel-manager"
SCRIPT_DIR="$INSTALL_DIR/bin"
SCRIPT_PATH="$SCRIPT_DIR/jkm.sh"

# Create directory structure
echo "Creating installation directory..."
mkdir -p "$SCRIPT_DIR"

# Download script
echo "Downloading script..."
curl -o "$SCRIPT_PATH" https://raw.githubusercontent.com/OSpoon/jupyter-kernel-manager/main/bin/jkm.sh

# Make script executable
chmod +x "$SCRIPT_PATH"

# Create symlink without .sh extension
ln -sf "$SCRIPT_PATH" "$SCRIPT_DIR/jkm"

# Add to PATH in shell config
SHELL_CONFIG="$HOME/.zshrc"
if [ "$SHELL" = "/bin/bash" ]; then
    SHELL_CONFIG="$HOME/.bash_profile"
fi

if ! grep -q "$SCRIPT_DIR" "$SHELL_CONFIG"; then
    echo "Adding to PATH..."
    echo "export PATH=\"\$PATH:$SCRIPT_DIR\"" >> "$SHELL_CONFIG"
fi

# Installation complete
echo -e "\nInstallation completed!"
echo "Script installed to: $SCRIPT_PATH"
echo -e "\nTo start using jkm, run either:"
echo "1. source $SHELL_CONFIG"
echo "   OR"
echo "2. $SCRIPT_DIR/jkm"
echo -e "\nAfter that, you can use 'jkm' command directly.\n"

read -p "Press Enter to exit"