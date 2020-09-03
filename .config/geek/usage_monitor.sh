#!/bin/sh
myData=`top -l 1`
typeset -i cnt=0

echo "CPU             \c"
myCPU=`echo "$myData" |awk -F '[ % ]' '/CPU usage/ {print $3+$6}' |bc`
myCPU=`echo "tmp=$myCPU; tmp /= 1; tmp" |bc`

while [ $cnt -lt $myCPU ]
do
    echo "\033[1;32m|\033[0m\c"
    cnt=`expr $cnt + 5`
done

while [ $cnt -lt 99 ]
do
    echo "|\c"
    cnt=`expr $cnt + 5`
done

printf %6d $myCPU && echo "%\c"
echo "\r"

unset myCPU
cnt=0

echo "Memory          \c"
# カーネル, OS系使用量
myWiredMem=`echo "$myData" |grep "PhysMem" |sed -e "s/(//g" |awk '{print $4}' |sed s/M// |sed s/\(//`
myUsedMem=`echo "$myData" |awk '/PhysMem/ {print $2}' |egrep "[0-9]M" |sed s/M//`
myFreeMem=`echo "$myData" |awk '/PhysMem/ {print $6}' |egrep "[0-9]M" |sed s/M//`
myTotalMem=`sysctl hw.memsize |awk '{print $2}'`
myTotalMem=`echo "tmp=$myTotalMem; tmp /= 1048576; tmp" |bc`

# Macが10Gと省略し始めるので頑張ってみた
if [ ! -n "$myUsedMem" -a -n "$myFreeMem" ]; then
    myUsedMem=`echo |awk '{print t - f - a}' t=$myTotalMem f=$myFreeMem a=$myWiredMem`
fi
if [ ! -n "$myFreeMem" -a -n "$myUsedMem" ]; then
    myFreeMem=`echo |awk '{print t - u - a}' t=$myTotalMem u=$myUsedMem a=$myWiredMem`
fi

myUsedPer=`echo "tmp=($myUsedMem * 100 / $myTotalMem); tmp" |bc`
myWiredUsedPer=`echo "tmp=($myWiredMem * 100 / $myTotalMem); tmp" |bc`
myTotalUsedPer=`echo |awk '{print a + u}' a=$myWiredUsedPer u=$myUsedPer`

while [ $cnt -lt $myTotalUsedPer ]
do
    if [ $cnt -lt $myUsedPer ];
    then
        echo "\033[1;32m|\033[0m\c"
    else
        echo "\033[0;35m|\033[0m\c"
    fi
    cnt=`expr $cnt + 5`
done

while [ $cnt -lt 99 ]
do
    echo "|\c"
    cnt=`expr $cnt + 5`
done

printf %6d $myTotalUsedPer && echo "%\c"
echo "\r"

unset myData
unset myWiredMem
unset myUsedMem
unset myFreeMem
unset myTotalMem
unset myUsedPer
unset myWiredUsedPer
unset myTotalUsedPer
cnt=0

echo "Disk            \c"
myDisk=`df |awk '/dev\/disk1s1/ && NF>1 {print $5}' |sed 's/\%//'`

while [ $cnt -lt $myDisk ]
do
    echo "\033[1;32m|\033[0m\c"
    cnt=`expr $cnt + 5`
done

while [ $cnt -lt 99 ]
do
    echo "|\c"
    cnt=`expr $cnt + 5`
done

printf %6d $myDisk && echo "%\c"
echo "\r"

unset myDisk
unset cnt
