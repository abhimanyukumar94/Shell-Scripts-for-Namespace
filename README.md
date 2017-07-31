# Shell Scripts for Networking Namespace
Namespace scripts used for Introduction to Networking Namespaces demo

# Description
I will refer to Networking Namespace as Namespace (NS) henceforth,

1. OneNS.sh - This script will configure one interface in NS (veth1, 10.0.0.2) and another in the hypervisor (veth2, 10.0.0.1). IP forwarding is enabled in the hypervisor between eth0 (the physical interface) and veth2. SNAT is configured in Masquerade mode, where all the traffic going out of eth0 will take eth0’s IP address.

2. NSBridge.sh - Just enter the number of NS (N) to be configured. The following will be setup after executing the script: N number of NS; OVS bridge IP address: 10.0.0.1; Nth NS IP address: 10.0.0.N+1; interface in NS: vethN; corresponding interface in bridge: br-vethN. 

3. NS3.sh - 3 NS will be configured in series: NS1—NS2—NS3. Result is NS behaving as routers.

4. Delete-NS.sh - This will take in the number of NS configured (using the above scripts), and will delete all of them, apart from deleting the OVS bridge configured (using the above scripts).

Comments have been provided for each step inside the scripts for lucidity.
