

#!/bin/bash

ns=3
for((i=1; i<=$ns; i++))
{
 #Add ns
 sudo ip netns add ns$i
} 

#Add veth link for NS1 and NS2
sudo ip link add veth1 type veth peer name o-veth1
sudo ip link set veth1 netns ns1
sudo ip link set o-veth1 netns ns2

#Add veth link for NS2 and NS3
sudo ip link add veth2 type veth peer name o-veth2
sudo ip link set veth2 netns ns2
sudo ip link set o-veth2 netns ns3

#Add IP
sudo ip netns exec ns1 ifconfig veth1 10.0.1.1/24 up
sudo ip netns exec ns2 ifconfig o-veth1 10.0.1.2/24 up
sudo ip netns exec ns2 ifconfig veth2 10.0.2.2/24 up
sudo ip netns exec ns3 ifconfig o-veth2 10.0.2.3/24 up

#Default GW in NS1 and NS3
sudo ip netns exec ns1 route add -net 0.0.0.0 netmask 0.0.0.0 gw 10.0.1.2
sudo ip netns exec ns3 route add -net 0.0.0.0 netmask 0.0.0.0 gw 10.0.2.2

sudo ip netns exec ns2 sysctl net.ipv4.ip_forward=1

