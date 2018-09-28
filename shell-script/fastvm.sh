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
elif [ $Number -ge 80 ];then
  echo "The number you input is not greater than 30..."
  exit 4
else
  if [ -f ${XMLFile}/node${Number}.xml ];then
     echo "The ID that you have entered in the virtual machine is input again."
     exit 5
  fi
fi

#######################################################
echo "Create virtual machine..."
cp ${XMLFile}/.node.xml ${XMLFile}/node${Number}.xml
sed -i "s/node/node${Number}/" ${XMLFile}/node${Number}.xml
qemu-img create -f qcow2 -b node.qcow2 ${IMGFile}/node${Number}.img 30G
virsh define ${XMLFile}/node${Number}.xml &> /dev/null
echo "node${Number} Create successfully!!!"
