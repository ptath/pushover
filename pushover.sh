#!/bin/bash

# Version 0.3
# By ptath (https://ptath.ru)
# Pushover script

#Config section, edit these lines:
USER_TOKEN="" #required
APP_TOKEN="" #required
TITLE="" #optional
SOUND="" #optional
DEVICE="" #optional
PRIORITY="" #optional
#Config section end

# DO NOT ERIT BELOW

if [ "$USER_TOKEN" == "" ] || [ "$APP_TOKEN" == "" ]; then
  echo "  Please edit this script and provide yours USER and APP tokens!"
  echo "    e.g. vi ~/scripts/pushover.sh"
  exit
fi

if [ $# -eq 0 ]; then
	cat <<INFO

Usage:
	./pushover.sh "message" "title" "sound"
	"message" is mandatory
	"title" is optional, otherwize local username and host will be shown
	"sound" is optional, see https://pushover.net/api#sounds for available sounds

Examples:
	./pushover.sh "This is a test message"
		only message
	./pushover.sh "Test message" "Test title" "echo"
		message with title and echo sound
	./pushover.sh "\`ls -la\`"
		output of command "ls -la"

You can customize script for other settings

INFO
	exit
fi

MESSAGE=$1
TITLE=$2
SOUND=$3

if [ $# -lt 2 ]; then
	TITLE="`whoami`@${HOSTNAME}"
fi

wget https://api.pushover.net/1/messages.json --post-data="token=$APP_TOKEN&user=$USER_TOKEN&message=$MESSAGE&title=$TITLE&sound=$SOUND&priority=$PRIORITY&device=$DEVICE" -qO- > /dev/null 2>&1 &
