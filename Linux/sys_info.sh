#!/bin/bash

# Set the output file 
output=$HOME/research/sys_info.txt

# Check for existence of the ~/research dir and the ~/research/sys_info.txt file
if [ ! -d ~/research ] 
then 
	mkdir ~/research
fi
if [ ! -f ~/research/sys_info.txt ] 
then
	rm ~/research/sys_info.txt
fi

echo -e "A Quick System Audit Script\n" > $output
date >> $output
echo -e "\nMachine Type Info:" $MACHTYPE >> $output
echo -e '\nuname info of the machine:' >> $output
uname -a >> $output
echo -e '\nIP address(es) of this machine are:' >> $output
hostname -I | awk -F" " '{print($1)}' >> $output
echo -e '\nHostname of this machine is:' $HOSTNAME >> $output
echo -e '\nDNS info of this machine:' >> $output
cat /etc/resolv.conf >> $output
echo -e '\nMemory Info:' >> $output
free -h >> $output
echo -e "\nCPU Info:" >> $output
lscpu | grep CPU >> $output
echo -e "\nDisk Usage:" >> $output
df -H | head -2 >> $output
echo -e "\nWho is logged in: \n$(who)" >> $output
