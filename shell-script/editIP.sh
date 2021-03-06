#!/bin/bash
NetFile=/etc/sysconfig/network-scripts
IPrestart (){
ifdown eth0  
ifup eth0 
}
#########################################################
[ -z $1 ] && echo "请输入IP地址的:192.168.1.\$1" && exit 2
cp $NetFile/ifcfg-eth0 /tmp/ifcfg-eth0.bak 
echo "# Generated by dracut initrd
DEVICE="eth0"
ONBOOT="yes"
NM_CONTROLLED="no"
TYPE="Ethernet"
BOOTPROTO="none"
IPADDR="192.168.1.$1"
NETMASK="255.255.255.0"
GATEWAY="192.168.1.254"" > $NetFile/ifcfg-eth0
IPrestart &> /dev/null
echo "IP has been successfully changed.
Configuration files grieved:/tmp/ifcfg-eth0.bak"
growpart /dev/vda 1 &> /dev/null
xfs_growfs / &> /dev/null
