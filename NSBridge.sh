#!/bin/bash

# OVS bridge IP address: 10.0.0.1
# Nth NS IP address: 10.0.0.N+1
# Interface in NS: vethN
# Corresponding interface in bridge: br-vethN

#Add OVS Bridge
sudo ovs-vsctl add-br br0
sudo ip link set dev br0 up

echo How many NS do you want?
read ns
for((i=1, j=$((i+2)); i<=$ns; i++, j++))
{
 #Add NS
 sudo ip netns add ns$i

 #Add veth peer for NS
 sudo ip link add veth$i type veth peer name br-veth$i
 sudo ip link set veth$i netns ns$i

 #Configure IP for NS interfaces 
 sudo ip netns exec ns$i ifconfig veth$i 10.0.0.$j/24 up

 #Adding Interfaces to Linux Bridge
 sudo ovs-vsctl add-port br0 br-veth$i
 sudo ip link set dev br-veth$i up

 #Add default gateway in NS
 sudo ip netns exec ns$i ip route add default via 10.0.0.1
}

#Giving IP to bridge
sudo ifconfig br0 10.0.0.1/24 up

#Enable forwarding
sudo sysctl -w net.ipv4.ip_forward=1

#Flush Forwarding rules
sudo iptables -P FORWARD DROP
sudo iptables -F FORWARD

#Flush NAT rules
sudo iptables -t nat -F

#Configure SNAT
sudo iptables -t nat -A POSTROUTING -s 10.0.0.0/255.255.255.0 -o eth0 -j MASQUERADE

#Enable Forwarding between eth0 and br0
sudo iptables -A FORWARD -i eth0 -o br0 -j ACCEPT
sudo iptables -A FORWARD -o eth0 -i br0 -j ACCEPT

