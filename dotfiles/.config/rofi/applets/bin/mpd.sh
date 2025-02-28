#!/usr/bin/env bash

theme="$HOME"/.config/rofi/applets/shared/theme.rasi

status="`mpc status`"
if [[ -z "$status" ]]; then
    prompt='Offline'
    mesg="MPD is Offline"
else
    prompt="`mpc -f "%artist%" current`"
    if [[ -z "$prompt" ]]; then
        mesg="`mpc status | head -1` :: `mpc status | grep "#" | awk '{print $3}'`"
    else
        mesg="`mpc -f "%title%" current` :: `mpc status | grep "#" | awk '{print $3}'`"
    fi
fi

list_col='1'
list_row='7'

layout=`cat ${theme} | grep 'USE_ICON' | cut -d'=' -f2`
if [[ "$layout" == 'NO' ]]; then
    if [[ ${status} == *"[playing]"* ]]; then
        option_1=" Pause"
    else
        option_1=" Play"
    fi
    option_2=" Stop"
    option_3=" Previous"
    option_4=" Next"
    option_5=" Repeat"
    option_6=" Random"
    option_7=" Seek to start"
else
    if [[ ${status} == *"[playing]"* ]]; then
        option_1=""
    else
        option_1=""
    fi
    option_2=""
    option_3=""
    option_4=""
    option_5=""
    option_6=""
    option_7=""
fi

active=''
urgent=''
if [[ ${status} == *"repeat: on"* ]]; then
    active="-a 4"
elif [[ ${status} == *"repeat: off"* ]]; then
    urgent="-u 4"
else
    option_6=" Parsing Error"
fi

if [[ ${status} == *"random: on"* ]]; then
    [ -n "$active" ] && active+=",5" || active="-a 5"
elif [[ ${status} == *"random: off"* ]]; then
    [ -n "$urgent" ] && urgent+=",5" || urgent="-u 5"
else
    option_7=" Parsing Error"
fi

rofi_cmd() {
    rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
        -theme-str 'textbox-prompt-colon {str: "";}' \
        -dmenu \
        -p "$prompt" \
        -mesg "$mesg" \
        ${active} ${urgent} \
        -markup-rows \
        -theme ${theme}
}

run_rofi() {
    echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6\n$option_7" | rofi_cmd
}

show_notification() {
    notify-send -u low -t 2000 "  `mpc current`"
}

run_cmd() {
    if [[ "$1" == '--opt1' ]]; then
        mpc -q toggle
    elif [[ "$1" == '--opt2' ]]; then
        mpc -q stop
    elif [[ "$1" == '--opt3' ]]; then
        mpc -q prev && show_notification
    elif [[ "$1" == '--opt4' ]]; then
        mpc -q next && show_notification
    elif [[ "$1" == '--opt5' ]]; then
        mpc -q repeat
    elif [[ "$1" == '--opt6' ]]; then
        mpc -q random && show_notification
    elif [[ "$1" == '--opt7' ]]; then
        mpc -q seek 0%
    fi
}

chosen="$(run_rofi)"
case ${chosen} in
    $option_1)
        run_cmd --opt1
        ;;
    $option_2)
        run_cmd --opt2
        ;;
    $option_3)
        run_cmd --opt3
        ;;
    $option_4)
        run_cmd --opt4
        ;;
    $option_5)
        run_cmd --opt5
        ;;
    $option_6)
        run_cmd --opt6
        ;;
    $option_7)
        run_cmd --opt7
        ;;
esac
