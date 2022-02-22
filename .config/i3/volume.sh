#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    amixer get Master | grep '%' | head -n 1 | cut -d '[' -f 2 | cut -d '%' -f 1
}

function is_mute {
    amixer get Master | grep '%' | grep -oE '[^ ]+$' | grep off > /dev/null
}

function send_notification {
    volume=`get_volume`
    # Send the notification
    dunstify -t 1500 -r 2593 -u normal ": $volume%"
}

case $1 in
    up)
	 #Set the volume on (if it was muted)
	 pactl set-sink-volume @DEFAULT_SINK@ +5%
	#amixer -D pulse set Master on > /dev/null
	# Up the volume (+ 5%)
	#amixer -D pulse sset Master 5%+ > /dev/null
	send_notification
	;;
    down)
	#amixer -D pulse set Master on > /dev/null
	#amixer -D pulse sset Master 5%- > /dev/null
	 pactl set-sink-volume @DEFAULT_SINK@ -5%
	send_notification
	;;
    mute)
    	# Toggle mute
	amixer -D pulse set Master 1+ toggle > /dev/null
	if is_mute ; then
	    dunstify -t 1500 -r 2593 -u normal "Mute"
	else
	    send_notification
	fi
	;;
esac
