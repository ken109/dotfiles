#!/bin/sh
INTF=en0
sample1=(`/usr/sbin/netstat -ib | awk "/$INTF/"'{print $7" "$10; exit}'`)
sleep 1
sample2=(`/usr/sbin/netstat -ib | awk "/$INTF/"'{print $7" "$10; exit}'`)
results=(`echo "2k ${sample2[0]} ${sample1[0]} - 1024 / p" "${sample2[1]} ${sample1[1]} - 1024 / p" | dc`)
printf "In : %.2f Kb/sec\nOut: %.2f Kb/sec\n" ${results[0]} ${results[1]}