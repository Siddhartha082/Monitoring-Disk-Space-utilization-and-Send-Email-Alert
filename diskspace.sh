#!/bin/bash
#Purpose: Monitoring Disk Space Utilization and Send Email Alert
#Version:1.0
#Created Date: SAT JAN 17 06:10 IST 2025
#Author: Siddhartha
# START #
THRESHOULD=40
mailto="root"
HOSTNAME=$(hostname)

for path in `/bin/df -h | grep -vE 'Filesystem|tmpfs' | awk '{print $5}' |sed 's/%//g'`
do
        if [ $path -ge $THRESHOULD ]; then
        df -h | grep $path% >> /tmp/temp
        fi
done

VALUE=`cat /tmp/temp | wc -l`
        if [ $VALUE -ge 1 ]; then
        mail -s "$HOSTNAME Disk Usage is Critical" $mailto < /tmp/temp
        fi

#rm -rf /tmp/temp


# END #
