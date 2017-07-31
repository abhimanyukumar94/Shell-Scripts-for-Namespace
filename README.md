# Shell-Scripts-for-Namespace
Namespace scripts used for Introduction to Networking Namespaces demo

# Description

1. OneNS.sh - This script will configure one interface in NS (veth1, 10.0.0.2) and another in the hypervisor (veth2, 10.0.0.1). IP forwarding is enabled in the hypervisor between eth0 (the physical interface) and veth2. SNAT is configured in Masquerade mode, where all the traffic going out of eth0 will take eth0’s IP address.

2. NSBridge.sh - Just enter the number of NS (N) to be configured. The following will be setup after executing the script: N number of NS; OVS bridge IP address: 10.0.0.1; Nth NS IP address: 10.0.0.N+1; interface in NS: vethN; corresponding interface in bridge: br-vethN. 

3. NS3.sh - 3 NS will be configured in series: NS1—NS2—NS3. Result is NS behaving as routers.

Comments have been provided for each step inside the scripts for lucidity.
