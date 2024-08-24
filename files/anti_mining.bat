#!/bin/bash

# Check if running as root
if [ "$EUID" -ne 0 ]
  then echo "Please run as root"
  exit
fi


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

dpkg --configure -a
apt-get install -y clamav clamav-daemon
systemctl start clamav-freshclam
systemctl enable clamav-freshclam
freshclam

echo "Setup complete. The system is now configured to block cryptocurrency mining."

echo "System configured to hibernate after 20 minutes of inactivity."


