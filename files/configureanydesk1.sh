# Ensure anydesk service is started
systemctl start anydesk

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
systemctl restart anydesk

# Confirm installation
echo "AnyDesk installation and configuration completed."
echo "Unattended access is enabled with the specified password."

