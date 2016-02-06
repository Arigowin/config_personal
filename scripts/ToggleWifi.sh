#!/bin/bash

status=$( LC_ALL=C nmcli -t -f WIFI nm)
if [ $status = "enabled" ] ; then
    nmcli nm wifi off
    notify-send "Wireless disabled"
else
    nmcli nm wifi on
    notify-send "Wireless enabled"
fi
exit 0
