#!/bin/bash

# Uninstall AnyDesk if it is already installed
echo "Uninstalling AnyDesk if present..."
sudo apt-get remove --purge -y anydesk
sudo rm -rf /etc/anydesk
sudo rm -rf ~/.anydesk

# Add AnyDesk GPG key and repository
echo "Adding AnyDesk repository..."

# Add the AnyDesk GPG key
wget -qO - https://keys.anydesk.com/repos/DEB-GPG-KEY | sudo apt-key add -

# Add the AnyDesk repository
echo "deb http://deb.anydesk.com/ all main" | sudo tee /etc/apt/sources.list.d/anydesk.list

# Update package list
sudo apt-get update

# Install AnyDesk
echo "Installing AnyDesk..."
sudo apt-get install -y anydesk

# Enable and configure unattended access
echo "Configuring unattended access..."

# Ensure anydesk service is started
sudo systemctl start anydesk

# Wait for AnyDesk to start up and create initial configuration files
sleep 10

# Set a password for unattended access
ANYDESK_PASSWORD="yourpassword"
echo "$ANYDESK_PASSWORD" | sudo anydesk --set-password

# Enable the "unattended access" mode
sudo anydesk --set-setting security.unattended_access true
sudo anydesk --set-setting security.interactive_access 2 # 2 = allow always

# Enable AnyDesk to start on boot
echo "Enabling AnyDesk to start on boot..."
sudo systemctl enable anydesk

# Restart AnyDesk service to apply changes
echo "Restarting AnyDesk service..."
sudo systemctl restart anydesk

# Confirm installation
echo "AnyDesk installation and configuration completed."
echo "Unattended access is enabled with the specified password."

# Start AnyDesk
echo "Starting AnyDesk..."
anydesk --fullscreen
