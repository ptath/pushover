#!/bin/bash
# Version 0.2
# By ptath (https://ptath.ru)

# Pushover installation script

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

print_title "Pushover.net installation script" "Press CTRL+C anytime to abort"

[ -e /bin/pushover ] && echo " Already installed (/bin/pushover)? Exiting..." && exit
[ -e ~/scripts/pushover.sh ] && echo " Already installed (~/scripts/pushover.sh)? Exiting..." && exit

[ ! -d ~/scripts ] && mkdir ~/scripts
[ -e ~/scripts/pushover.sh ] && echo " Removing old script" && rm ~/scripts/pushover.sh

wget -q -O ~/scripts/pushover.sh https://github.com/ptath/pushover/raw/master/pushover.sh
chmod +x ~/scripts/pushover.sh
echo " Downloaded script to home/scripts directory, here is its content:"
cd ~/scripts && ls -a

echo "  Editing file in vi (press $(print_cyan "i") to edit mode),"
echo "    put yours USER_TOKEN and APP_TOKEN from here $(print_cyan "<https://pushover.net/apps>"),"
echo "    then press ESC and type $(print_cyan ":wq") then ENTER)"

read -p "   Press ENTER to proceed..."
read -p "   Absolutely sure? Read vi instructions again =) ENTER to proceed..."
vi ~/scripts/pushover.sh

echo "  Your pushover tokens are: "
sed -n 8,9p ~/scripts/pushover.sh

if [ $(sudo 2>/dev/null| grep -c "not found") -eq 0 ];then
        echo "    $(print_red "No sudo")? Maybe router or smth else, trying to set pushover command globally anyway..."
        ln -s ~/scripts/pushover.sh /bin/pushover
else
        echo "    sudo $(print_green "OK"), trying to create symlink..."
        sudo ln -s ~/scripts/pushover.sh /bin/pushover
fi

echo " Ok, trying to send test message..."
~/scripts/pushover.sh "Pushover script succesefully installed" "Congrats!" "echo"
print_title "That's all, run '~/scripts/pushover.sh'" "Or just 'pushover' if global installation OK"

~/scripts/pushover.sh
