#!/bin/sh

killall dnsmasq

switch='br0'
sudo ip link set $1 down
sudo ovs-vsctl del-port ${switch} $1
sudo ovs-vsctl del-br ${switch}
sudo iptables -t nat -D POSTROUTING -o wlp3s0 -j MASQUERADE
sudo iptables -D FORWARD -m conntrack --ctstate \
RELATED,ESTABLISHED -j ACCEPT
sudo iptables -D FORWARD -i br0 -o wlp3s0 -j ACCEPT
sudo iptables -D INPUT -i br0 -p udp -d 0/0 --dport 67:68 -j ACCEPT
