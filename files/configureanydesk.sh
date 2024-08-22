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

sudo apt install libcanberra-gtk-module libcanberra-gtk3-module -y

