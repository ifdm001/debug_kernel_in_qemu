#!/bin/sh

sudo sysctl net.ipv4.ip_forward=1
sudo sysctl net.ipv6.conf.default.forwarding=1
sudo sysctl net.ipv6.conf.all.forwarding=1

switch='br0'
sudo ovs-vsctl add-br ${switch}
sudo ip address add 172.20.0.1/24 dev ${switch}
sudo ovs-vsctl add-port ${switch} $1
sudo /usr/bin/ip link set $1 up promisc on
sudo dnsmasq --interface=${switch} \
    --bind-interfaces \
    --dhcp-range=172.20.0.2,172.20.0.254
sudo iptables -A INPUT -i br0 -p udp -d 0/0 --dport 67:68 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -o wlp3s0 -j MASQUERADE
sudo iptables -A FORWARD -m conntrack --ctstate \
RELATED,ESTABLISHED -j ACCEPT
sudo iptables -A FORWARD -i br0 -o wlp3s0 -j ACCEPT
