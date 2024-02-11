#!/bin/bash

# Get the current IP address and subnet mask
current_ip=$(ifconfig | grep -Eo 'inet (addr:)?([0-9]\.){3}[0-9]' | grep -Eo '([0-9]\.){3}[0-9]' | head -n 1)
current_subnet=$(ifconfig | grep -Eo 'netmask ([0-9]\.){3}[0-9]' | grep -Eo '([0-9]\.){3}[0-9]' | head -n 1)

# Generate a random IP address and subnet mask in the same supernet
random_ip=$(echo $current_ip | cut -d '.' -f 1-2).$(shuf -i 1-254 -n 1).$(shuf -i 1-254 -n 1)
random_subnet=$(echo $current_subnet | cut -d '.' -f 1-3).$(shuf -i 1-254 -n 1)

# Change the IP address and subnet mask
sudo ifconfig eth0 $random_ip netmask $random_subnet

# Print the new IP address and subnet mask
echo "New IP address: $random_ip"
echo "New subnet mask: $random_subnet"

# Sleep for 2 minutes
sleep 1

# Repeat the process
./test2.sh
