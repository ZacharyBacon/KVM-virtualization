#!/bin/bash
if [ $# -eq 0 ];then
echo "${0} host1 host2 host3 ... ... host(N)"
fi
for host in $@
do
rsync -aSH --delete /usr/local/hadoop/etc ${host}:/usr/local/hadoop/ -e 'ssh' &
rsync /etc/hosts ${host}:/etc/
done

