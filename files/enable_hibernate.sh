# Step 2: Create a systemd service for automatic hibernation after 2 minutes of inactivity
echo "Creating auto-hibernate.service..."

SERVICE_PATH="/etc/systemd/system/auto-hibernate.service"

cat <<EOF > "$SERVICE_PATH"
[Unit]
Description=Automatic Hibernation after Inactivity
After=sleep.target

[Service]
Type=simple
ExecStart=/bin/bash -c "sleep 120 && systemctl hibernate"
ExecStop=/usr/bin/systemd-inhibit --what=sleep --mode=delay --who=auto-hibernate --why="Preparing to hibernate"
Restart=on-failure
User=root

[Install]
WantedBy=sleep.target
EOF

# Step 3: Reload systemd, enable and start the service
echo "Enabling and starting the auto-hibernate service..."

systemctl daemon-reload
systemctl enable auto-hibernate.service
systemctl start auto-hibernate.service

echo "Auto-hibernate service created and started."

echo "Setup complete. Your system will now hibernate automatically after 2 minutes of inactivity."