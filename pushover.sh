#!/bin/bash

# Version 0.2
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
# Colors for terminal
if test -t 1; then
    ncolors=$(which tput > /dev/null && tput colors)
    if test -n "$ncolors" && test $ncolors -ge 8; then
        termcols=$(tput cols)
        bold="$(tput bold)"
        standout="$(tput smso)"
        normal="$(tput sgr0)"
        red="$(tput setaf 1)"
        green="$(tput setaf 2)"
        cyan="$(tput setaf 6)"
    fi
fi

print_red() {
        text="$1"
        printf "${bold}${red}${text}${normal}"
}

print_green() {
        text="$1"
        printf "${bold}${green}${text}${normal}"
}

print_cyan() {
        text="$1"
        printf "${bold}${cyan}${text}${normal}"
}

print_title() {
    title="$1"
    text="$2"

    echo
    echo "${cyan}================================================================================${normal}"
    echo
    echo -e "  ${bold}${cyan}${title}${normal}"
    echo
    echo -en "  ${text}"
    echo
    echo "${cyan}================================================================================${normal}"
    echo
}

if [ "$USER_TOKEN" == "" ]; then
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
