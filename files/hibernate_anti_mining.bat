#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi

echo "Configuring the system to hibernate after 20 minutes of inactivity..."

# Enable hibernation by creating a new policy kit rule
cat <<EOL > /etc/polkit-1/localauthority/50-local.d/hibernate.pkla
[Re-enable hibernate]
Identity=unix-user:*
Action=org.freedesktop.login1.hibernate;org.freedesktop.login1.handle-hibernate-key;org.freedesktop.login1;power-mgmt.hibernate
ResultActive=yes
EOL

echo "Hibernation has been enabled."

# Install required packages
echo "Installing required packages..."
apt-get update
apt-get install -y acpid pm-utils

# Configure systemd to hibernate after 20 minutes of inactivity
echo "Configuring automatic hibernation..."

# Create or modify the configuration for automatic hibernation
cat <<EOL > /etc/systemd/sleep.conf
[Sleep]
HibernateDelaySec=20min
EOL

echo "System configured to hibernate after 20 minutes of inactivity."

# Restart the systemd-logind service to apply changes
echo "Restarting systemd-logind service..."
systemctl restart systemd-logind.service

echo "Configuration complete. The system will now hibernate after 20 minutes of inactivity."


chattr +i /etc/systemd/sleep.conf
chattr +i /etc/polkit-1/localauthority/50-local.d/hibernate.pkla


apt-get install auditd

auditctl -w /etc/systemd/sleep.conf -p wa -k hibernate_watch
auditctl -w /etc/polkit-1/localauthority/50-local.d/hibernate.pkla -p wa -k hibernate_watch


ausearch -k hibernate_watch

# Step 1: Create a new user 'user' with a password
USER_NAME="user"
PASSWORD="password@123"  # Replace this with a secure password

echo "Creating user '$USER_NAME'..."
useradd -m -s /bin/bash "$USER_NAME"
echo "$USER_NAME:$PASSWORD" | chpasswd

# Step 2: Grant limited sudo privileges to the user
echo "Configuring sudo privileges for user '$USER_NAME'..."

# Add the following line to the sudoers file
cat <<EOL > /etc/sudoers.d/$USER_NAME
$USER_NAME ALL=(ALL:ALL) NOPASSWD: /usr/bin/apt, /usr/bin/apt-get, /usr/bin/dpkg, !/usr/bin/chattr, !/bin/chattr
EOL


# Step 1: Block known mining domains
echo "Blocking known mining domains..."

cat <<EOL >> /etc/hosts
# Block known crypto mining pools
0.0.0.0 pool.minexmr.com
0.0.0.0 xmr.pool.minergate.com
0.0.0.0 us-east.cryptonight-hub.miningpoolhub.com
0.0.0.0 pool.supportxmr.com
0.0.0.0 xmr-eu1.nanopool.org
0.0.0.0 xmr-asia1.nanopool.org
0.0.0.0 eth.pool.minergate.com
0.0.0.0 etc.pool.minergate.com
0.0.0.0 asia1.ethermine.org
0.0.0.0 us1.ethermine.org
EOL

# Step 2: Restrict CPU and GPU usage using cgroups
echo "Creating cgroups to limit CPU and GPU usage..."

# Create a new cgroup for limiting CPU usage
cgcreate -g cpu:/mining-restriction
echo 100 > /sys/fs/cgroup/cpu/mining-restriction/cpu.shares

# Apply the cgroup limits to all current and future processes
echo "*          -       cpu     /mining-restriction" >> /etc/security/limits.conf


# Step 4: Prevent installation of mining software
echo "Blocking installation of common mining software..."

apt-get remove --purge -y xmrig
apt-get remove --purge -y minergate
apt-get remove --purge -y ethminer
apt-get remove --purge -y claymore
apt-get remove --purge -y cgminer
apt-get remove --purge -y bfgminer

# Block package installation by blacklisting them
cat <<EOL > /etc/apt/preferences.d/no-mining.pref
Package: xmrig
Pin: release *
Pin-Priority: -1

Package: minergate
Pin: release *
Pin-Priority: -1

Package: ethminer
Pin: release *
Pin-Priority: -1

Package: claymore
Pin: release *
Pin-Priority: -1

Package: cgminer
Pin: release *
Pin-Priority: -1

Package: bfgminer
Pin: release *
Pin-Priority: -1
EOL

# Step 5: Make critical files immutable
echo "Making critical configuration files immutable..."

chattr +i /etc/hosts
chattr +i /etc/security/limits.conf
chattr +i /etc/modprobe.d/blacklist-mining.conf
chattr +i /etc/apt/preferences.d/no-mining.pref

# Step 6: Install anti-malware tools (optional)
echo "Installing ClamAV to detect and block mining software..."

apt-get install -y clamav clamav-daemon
systemctl start clamav-freshclam
systemctl enable clamav-freshclam
freshclam

echo "Setup complete. The system is now configured to block cryptocurrency mining."
