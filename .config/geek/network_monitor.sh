#!/bin/sh
ext_info=`curl --silent api.ipify.org --max-time 5`

en0_info=`ifconfig en0 |grep inet |grep netmask |grep -v 127.0.0.1 |awk '{print $2}'`
en2_info=`ifconfig en2 |grep inet |grep netmask |grep -v 127.0.0.1 |awk '{print $2}'`

wait

if [ -n "$ext_info" ];
then
    echo "External        : $ext_info"
else
    echo "External        : OFFLINE"
fi

unset ext_info

if [ -n "$en0_info" ];
then
    wifi_network=`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I |awk -F: '/ SSID: / {print $2}' |sed -e 's/.*SSID: //'`
    wifi_txRate=`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I |awk -F: '/ lastTxRate: / {print $2}' |sed -e 's/.*lastTxRate: //'`
    wifi_maxRate=`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I |awk -F: '/ maxRate: / {print $2}' |sed -e 's/.*maxRate: //'`
    wifi_channel=`/System/Library/PrivateFrameworks/Apple80211.framework/Versions/A/Resources/airport -I |awk -F: '/ channel: / {print $2}' |sed -e 's/.*channel: //' -e 's/,1//'`

    echo "Wi-Fi           : $en0_info"
    echo "- SSID          :$wifi_network"
    echo "- Channel       :$wifi_channel"
    echo "- Transmit Rate :$wifi_txRate"
    echo "- Max Rate      :$wifi_maxRate"

    unset wifi_network
    unset wifi_txRate
    unset wifi_maxRate
    unset wifi_channel
else
    echo "Wi-Fi           : INACTIVE"
fi

unset en0_info

if [ -n "$en2_info" ];
then
    echo "Ethernet        : $en2_info"
else
    echo "Ethernet        : INACTIVE"
fi

unset en2_info
