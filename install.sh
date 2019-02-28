#!/bin/bash

#Pushover installation script

echo "=== Pushover.net installation script, press CTRL+C anytime to abort"
echo "=== STEP 1: Downloading script to home directory, here is its content:"
cd ~/
ls -a
wget -O ~/pushover.sh https://github.com/ptath/pushover/raw/master/pushover.sh
echo "=== Here is it"
ls -la | grep pushover.sh
echo "=== STEP 2: Making script executable..."
chmod +x ~/pushover.sh
ls -la | grep pushover.sh
echo "=== STEP 3 (hardest one): Editing file in vi (press i to edit mode),"
echo "=== put yours USER_TOKEN and APP_TOKEN from here <https://pushover.net/apps>,"
echo "=== then press ESC and type :wq then ENTER)"
read -p "Press ENTER to proceed..."
read -p "Absolutely sure? Read vi instructions again =) ENTER to proceed..."
vi ~/pushover.sh
echo "Your pushover tokens:"
sed -n 4,9p pushover.sh 
read -p "=== Ok, trying to send test message, check it and press ENTER"
~/pushover.sh "Pushover script succesefully installed" "Congrats!" "echo"
echo "=== That's all"
~/pushover.sh
cd ~/
