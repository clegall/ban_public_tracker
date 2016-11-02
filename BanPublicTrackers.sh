#!/bin/bash
#
# [From QuickBox Installation Script]
#
# GitHub:   https://github.com/clegall/ban_public_tracker
# Author:   Swizards.net / clegall
# URL:      https://www.kolgate.xyz

echo -n "Blocking public trackers ... "
wget -q -O/etc/trackers https://raw.githubusercontent.com/clegall/QuickBox/master/commands/trackers
cat >/etc/cron.daily/denypublic<<'EOF'
IFS=$'\n'
L=$(/usr/bin/sort /etc/trackers | /usr/bin/uniq)
for fn in $L; do
        /sbin/iptables -D INPUT -d $fn -j DROP
        /sbin/iptables -D FORWARD -d $fn -j DROP
        /sbin/iptables -D OUTPUT -d $fn -j DROP
        /sbin/iptables -A INPUT -d $fn -j DROP
        /sbin/iptables -A FORWARD -d $fn -j DROP
        /sbin/iptables -A OUTPUT -d $fn -j DROP
done
EOF
chmod +x /etc/cron.daily/denypublic
curl -s -LO https://raw.githubusercontent.com/clegall/QuickBox/master/commands/hostsTrackers
cat hostsTrackers >> /etc/hosts
  echo "${OK}"
