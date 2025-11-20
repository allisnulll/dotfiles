#!/usr/bin/env bash

BWS_FILE=$HOME/.cache/waybar_disabled_ws
LWS_FILE=$HOME/.cache/last_ws
[ -f $BWS_FILE ] || touch $BWS_FILE
[ -s $LWS_FILE ] || echo 1 > $LWS_FILE

current_ws=$(hyprctl -j activeworkspace | jq ".id")

cws=$(grep -qw $current_ws $BWS_FILE && echo 1 || echo 0)
lws=$(grep -qw $(tail -n 1 $LWS_FILE) $BWS_FILE && echo 1 || echo 0)

case $1 in
    bar)
        if [ $cws -eq 1 ]; then
            sed -i "/^$current_ws$/d" $BWS_FILE
        else
            echo $current_ws >> $BWS_FILE
        fi
        pkill -x -SIGUSR1 waybar
        ;;

    last)
        hyprctl dispatch workspace $(head -n 1 $LWS_FILE)
        ;;

    off)
        rm $BWS_FILE $LWS_FILE
        ;;

    *)
        if [ $current_ws -ne $(tail -n 1 $LWS_FILE) ]; then
            if [ $cws -ne $lws ]; then
                pkill -x -SIGUSR1 waybar
            fi

            echo $current_ws >> $LWS_FILE
            tail -n 2 $LWS_FILE > $LWS_FILE.tmp
            mv $LWS_FILE.tmp $LWS_FILE
        fi
        ;;
esac
