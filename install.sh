!/bin/bash
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

[ -e /bin/pushover ] && echo " Already installed? Exiting..." && exit
[ -e ~/scripts/pushover.sh ] && echo " Already installed? Exiting..." && exit

[ ! -d ~/scripts ] && mkdir ~/scripts
echo " Downloading script to home/scripts directory, here is its content:"
[ -e ~/scripts/pushover.sh ] && echo " Removing old script"
cd ~/scripts && ls -a

wget -q -O ~/scripts/pushover.sh https://github.com/ptath/pushover/raw/master/pushover.sh
chmod +x ~/scripts/pushover.sh

echo "  Editing file in vi (press $(print_cyan "i") to edit mode),"
echo "  put yours USER_TOKEN and APP_TOKEN from here $(print_cyan "<https://pushover.net/apps>"),"
echo "  then press ESC and type $(print_cyan ":wq") then ENTER)"

read -p " Press ENTER to proceed..."
read -p " Absolutely sure? Read vi instructions again =) ENTER to proceed..."
vi ~/scripts/pushover.sh

echo "  Your pushover tokens: "
sed -n 8,9p ~/scripts/pushover.sh

if [ $(sudo 2>/dev/null| grep -c "not found") -eq 0 ];then
        echo "    $(print_red "No sudo")? Maybe router or smth else, trying to set pushover command globally anyway..."
        ln -s ~/scripts/pushover.sh /bin/pushover
else
        echo "    sudo $print_green "OK")"
        sudo ln -s ~/scripts/pushover.sh /bin/pushover
fi

read -p " Ok, trying to send test message, check it and press ENTER"
~/scripts/pushover.sh "Pushover script succesefully installed" "Congrats!" "echo"
echo "  That's all, run ~/scripts/pushover.sh or just $(print_cyan "pushover")"

~/scripts/pushover.sh
cd ~/
