#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
    brightnessctl | grep '%' | head -n 1 | cut -d '(' -f 2 | cut -d '%' -f 1
}

function send_notification {
    volume=`get_volume`
    # Send the notification
    dunstify -t 1500 -r 2593 -u normal ": $volume%"
}

case $1 in
    up)
	# Up the volume (+ 5%)
	brightnessctl set 10%+ > /dev/null
	send_notification
	;;
    down)
	brightnessctl set 10%- > /dev/null
	send_notification
	;;
esac
