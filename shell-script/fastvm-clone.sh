#!/bin/bash
XMLFile=/etc/libvirt/qemu
IMGFile=/var/lib/libvirt/images
#######################################################
read -p "Input host name sequence:" Number
if [ -z $Number ];then
  echo "Please input parameters..."
  exit 2
elif [[ ! $Number =~ ^[0-9]+$ ]];then
  echo "It can only be numeric."
  exit 3
else
  if [ $Number -ge 11 ];then
  echo "The number you input is not greater than 10..."
  exit 4
  fi
fi

#######################################################
echo "Create virtual machine..."
for i in $(seq $Number)
do
  while :
  do
  if [ -f ${XMLFile}/node${i}.xml ];then
     let i++
  else
     break
  fi
  done
cp ${XMLFile}/.node.xml ${XMLFile}/node${i}.xml
sed -i "s/node/node${i}/" ${XMLFile}/node${i}.xml
qemu-img create -f qcow2 -b node.qcow2 ${IMGFile}/node${i}.img 30G &> /dev/null
virsh define ${XMLFile}/node${i}.xml &> /dev/null
echo -e "created node${i}\t\t\t\t\t\033[32;1m[Done]\033[0m"
echo "node${i} Create successfully!!!"
done
