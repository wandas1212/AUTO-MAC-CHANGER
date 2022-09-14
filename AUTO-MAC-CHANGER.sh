#!/bin/bash

sudo arp -an >> mac
awk '{ print $4}' mac > ups
mapfile -t array <ups
rm -rf ups mac

i=0
len=${#array[@]}
wget -q --spider http://google.com
until [ $? -eq 0 ];
do
    sudo ifconfig wlan0 down && sudo macchanger -m ${array[$i]} wlan0 && sudo ifconfig wlan0 up
    let i++
done
#=======================================

