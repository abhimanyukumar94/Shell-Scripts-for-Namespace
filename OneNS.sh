#!/bin/bash

#Add ns
sudo ip netns add ns

#Add veth peer
sudo ip link add veth1 type veth peer name veth2
sudo ip link set veth1 netns ns

sudo ip netns exec ns ifconfig veth1 10.0.0.2/24 up 

#Add default gateway
sudo ip netns exec ns ip route add default via 10.0.0.1
sudo ifconfig veth2 10.0.0.1/24 up

#Enable forwarding
sudo sysctl -w net.ipv4.ip_forward=1

#Flush Forwarding rules
sudo iptables -P FORWARD DROP
sudo iptables -F FORWARD

#Flush NAT rules
sudo iptables -t nat -F

#Configure SNAT
sudo iptables -t nat -A POSTROUTING -s 10.0.0.0/255.255.255.0 -o eth0 -j MASQUERADE

#Enable Forwarding between eth0 and veth2
sudo iptables -A FORWARD -i eth0 -o veth2 -j ACCEPT  
sudo iptables -A FORWARD -o eth0 -i veth2 -j ACCEPT
