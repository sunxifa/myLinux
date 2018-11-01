#!/bin/bash
for host in `cat /etc/hosts | grep 117| tail -n 20  | awk '{print $2}'`;do
	scp collect_network_info.sh $host:~
	ssh $host "sh /root/collect_network_info.sh" >/root/DAP/host_info_net/${host}_info.txt
done
