#!/bin/bash

echo How many NS do you have?
read ns
for((i=1;i <=ns; ++i))
{
 sudo ip netns del ns$i
}
sudo ifconfig br0 down
sudo ovs-vsctl del-br br0
