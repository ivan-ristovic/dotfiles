#!/usr/bin/env bash

config_dir="$HOME"/.config
theme="$config_dir/rofi/applets/shared/theme.rasi"
prompt="$(hostname)"
mesg="Uptime : $(uptime -p | sed -e 's/up //g')"

list_col='1'
list_row='7'

test -f /run/systemd/shutdown/scheduled
is_shutdown=$?

layout=$(cat "$theme" | grep 'USE_ICON' | cut -d'=' -f2)
if [[ "$layout" == 'NO' ]]; then
    option_1=" Lock"
    option_2="󰍃 Logout"
    option_3=" Suspend"
    option_4=" Hibernate"
    option_5=" Reboot"
    option_6=" Shutdown"
    if [ $is_shutdown -eq 0 ] ; then
        option_7="󰜺 Cancel scheduled shutdown"
    else 
        option_7="󰄉 Shutdown in 1h"
    fi
    yes=' Yes'
    no=' No'
else
    option_1=""
    option_2="󰍃"
    option_3=""
    option_4=""
    option_5=""
    option_6=""
    if [ $is_shutdown -eq 0 ] ; then
        option_7="󰜺"
    else 
        option_7="󰄉"
    fi
    yes=''
    no=''
fi

rofi_cmd() {
    rofi -theme-str "listview {columns: $list_col; lines: $list_row;}" \
        -theme-str 'textbox-prompt-colon {str: " ";}' \
        -dmenu \
        -p "$prompt" \
        -mesg "$mesg" \
        -markup-rows \
        -theme ${theme}
}

run_rofi() {
    echo -e "$option_1\n$option_2\n$option_3\n$option_4\n$option_5\n$option_6\n$option_7" | rofi_cmd
}

confirm_cmd() {
    rofi -theme-str 'window {location: center; anchor: center; fullscreen: false; width: 350px;}' \
        -theme-str 'mainbox {orientation: vertical; children: [ "message", "listview" ];}' \
        -theme-str 'listview {columns: 2; lines: 1;}' \
        -theme-str 'element-text {horizontal-align: 0.5;}' \
        -theme-str 'textbox {horizontal-align: 0.5;}' \
        -dmenu \
        -p 'Confirmation' \
        -mesg 'Are you Sure?' \
        -theme "$theme"
}

confirm_exit() {
    echo -e "$yes\n$no" | confirm_cmd
}

confirm_run () {    
    selected="$(confirm_exit)"
    if [[ "$selected" == "$yes" ]]; then
        ${1} && ${2} && ${3}
    else
        exit
    fi  
}

run_cmd() {
    if [[ "$1" == '--opt1' ]]; then
        confirm_run "i3lock -i /usr/share/backgrounds/wp.png -p default -t"            
    elif [[ "$1" == '--opt2' ]]; then
        confirm_run 'kill -9 -1'
    elif [[ "$1" == '--opt3' ]]; then
        confirm_run 'mpc -q pause' 'amixer set Master mute' 'systemctl suspend'
    elif [[ "$1" == '--opt4' ]]; then
        confirm_run 'systemctl hibernate'
    elif [[ "$1" == '--opt5' ]]; then
        confirm_run 'systemctl reboot'
    elif [[ "$1" == '--opt6' ]]; then
        confirm_run 'systemctl poweroff'
    elif [[ "$1" == '--opt7' ]]; then
        if [ $is_shutdown -eq 0 ] ; then
            confirm_run 'shutdown -c'
        else 
            confirm_run 'shutdown -h +60'
        fi
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
        if [ $is_shutdown -eq 0 ] ; then
            notify-send "Scheduled shutdown cancelled"
        else 
            notify-send "Powering off in 1h"
        fi
        ;;
esac

